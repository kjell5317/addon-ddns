#!/usr/bin/with-contenv bashio
set +u

CONFIG_PATH=/data/options.json

zone=$(bashio::config 'zone')
api_key=$(bashio::config 'api_key')
time=$(bashio::config 'update')

ip1=$(dig +short myip.opendns.com @resolver1.opendns.com)
bashio::log.info "Your IP: $ip1"

if answer=$(curl -s -X GET "https://api.cloudflare.com/client/v4/zones/$zone/dns_records?type=A&match=all" \
    -H "Authorization: Bearer $api_key" \
    -H "Content-Type: application/json") \
    && [ $(echo $answer | jq -r '.success') == 'true' ]
then
    domains=$(echo $answer | jq -r '.result')
else
    bashio::log.error "Failed getting records $(echo $answer | jq -r 'errors')"
fi

for i in $(echo $domains | jq -r '.[] | @base64')
do
    if answer=$(curl -s -X PUT "https://api.cloudflare.com/client/v4/zones/$zone/dns_records/$(echo $i | base64 -d | jq -r '.id')" \
        -H "Authorization: Bearer $api_key" \
        -H "Content-Type: application/json" \
        -d '{"content": "'$ip1'", "name": "'$(echo $i | base64 -d | jq -r '.name')'", "type": "A", "ttl": 1, "proxied": true}') \
        && [ $(echo $answer | jq -r '.success') == 'true' ]
    then
        bashio::log.info "Updated $(echo $i | base64 -d | jq -r '.name')"
    else
        bashio::log.error "Failed updating $(echo $i | base64 -d | jq -r '.name') $(echo $answer | jq -r '.errors | .[0]')"
    fi
done

sleep "$time"


while true
do

    if ip2=$(dig +short myip.opendns.com @resolver1.opendns.com) \
        && [ $ip1 != $ip2 ]
    then
        bashio::log.info "New IP: $ip2"

        if answer=$(curl -s -X GET "https://api.cloudflare.com/client/v4/zones/$zone/dns_records?type=A&match=all" \
            -H "Authorization: Bearer $api_key" \
            -H "Content-Type: application/json") \
            && [ $(echo $answer | jq -r '.success') == 'true' ]
        then
            domains=$(echo $answer | jq -r '.result')
        else
            bashio::log.error "Failed getting records $(echo $answer | jq -r 'errors')"
        fi

        for i in $(echo $domains | jq -r '.[] | @base64')
        do
            if answer=$(curl -s -X PUT "https://api.cloudflare.com/client/v4/zones/$zone/dns_records/$(echo $i | base64 -d | jq -r '.id')" \
                -H "Authorization: Bearer $api_key" \
                -H "Content-Type: application/json" \
                -d '{"content": "'$ip2'", "name": "'$(echo $i | base64 -d | jq -r '.name')'", "type": "A", "ttl": 1, "proxied": true}') \
                && [ $(echo $answer | jq -r '.success') == 'true' ]
            then
                bashio::log.info "Updated $(echo $i | base64 -d | jq -r '.name')"
            else
                bashio::log.error "Failed updating $(echo $i | base64 -d | jq -r '.name') $(echo $answer | jq -r '.errors | .[0]')"
            fi
        done
        ip1="$ip2"
    fi

    sleep "$time"

done
