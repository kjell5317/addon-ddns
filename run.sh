#!/usr/bin/with-contenv bashio
set +u

CONFIG_PATH=/data/options.json

zone=$(bashio::config 'zone')
api_key=$(bashio::config 'api_key')
time=$(bashio::config 'update')

while true; do

    ip=$(dig +short myip.opendns.com @resolver1.opendns.com)
    bashio::log.info "$ip"

    if answer=$(curl -s -X GET "https://api.cloudflare.com/client/v4/zones/$zone/dns_records?type=A&match=all" \
        -H "Authorization: Bearer $api_key" \
        -H "Content-Type: application/json") \
        && [ $(echo $answer | jq -r '.success') == 'true' ]; then
            domains=$(echo $answer | jq -r '.result')
    else bashio::log.error "Failed getting records $(echo $answer | jq -r 'errors')"; fi

    for i in "${domains[@]}"; do
        if answer=$(curl -s -X PUT "https://api.cloudflare.com/client/v4/zones/$zone/dns_records/$(echo $i | jq -r '.[0] | .id')" \
            -H "Authorization: Bearer $api_key" \
            -H "Content-Type: application/json" \
            -d '{"content": "'$ip'"}') \
            && [ $(echo $answer | jq -r '.success') == 'true' ]; then
            bashio::log.info "Updated $(echo $i | jq -r '.[0] | .name')"
        else bashio::log.error "Failed updating $(echo $i | jq -r '.[0] | .name') $(echo $answer | jq -r '.errors | .[0]')"; fi
    done

    sleep "$time"
done
