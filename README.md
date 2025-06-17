# DDNS

## Deprecation Notice

There is [a new core integration of Home Assistant](https://www.home-assistant.io/integrations/cloudflare/) which does mostly the same. I recommend using the integration since it is more efficient than an addon. The only feature missing there is to update multiple domains or even zones since you can only have one instance of the integration.

## Description

This add-on provides a script that updates all A records of a Cloudflare zone with your latest public ip address.
_**Note:** .ml, .tk, .cf, .ga and .gq domains aren't supported by Cloudflare's API._
[There is also an integration to automate this in Home Assistant now.](https://www.home-assistant.io/integrations/cloudflare/)
