# DDNS

This add-on provides a script that updates all A records of a Cloudflare zone with your latest public ip address.  
_**Note:** .ml, .tk, .cf, .ga and .gq domains aren't supported by Cloudflare's API._  
[There is also an integration to automate this in Home Assistant now.](https://www.home-assistant.io/integrations/cloudflare/)

## Installation

Go to the add-on store of the supervisor and click on _repositories_ under the three dots.
Copy [_https://github.com/kjell5317/addon-ddns_](https://github.com/kjell5317/addon-ddns) into the field and add this repository.
Now you can install this add-on like any other home-assistant add-on.

## Configuration

1. Create an `API token` at [Cloudflare](https://dash.cloudflare.com/profile/api-tokens) and give it _Zone.DNS_ permissions.
2. Copy your `zone id` from your [Cloudflare dashboard](https://dash.cloudflare.com/).
3. Enter these details in the configuration page of this add-on and start it. Watch the log for errors.  
   Your configuration should look similar to this:

```yaml
zones:
  - api_key: <YOUR_API_KEY>
    zone_id: <YOUR_ZONE_ID>
update: 300
```
