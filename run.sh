#!/usr/bin/with-contenv bashio
set +u

CONFIG_PATH=/data/options.json

zone=$(bashio::config 'zone')
api_key=$(bashio::config 'api_key')

ip=$(dig +short myip.opendns.com @resolver1.opendns.com)
domains=$(curl -X GET "https://api.cloudflare.com/client/v4/zones/${zone}/dns_records?type=A&match=all" \
     -H "Authorization: Bearer ${api_key}" \
     -H "Content-Type: application/json" | \
     jq -r '.result')

for i in "${domains[@]}"; do
    bashio::log.info $(curl -X PUT "https://api.cloudflare.com/client/v4/zones/${zone}/dns_records${domains[i] | jq -r '.id'}?content=${ip}" \
        -H "Authorization: Bearer ${api_key}")
done

bashio::log.info "$ip"