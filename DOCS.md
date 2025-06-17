# DDNS

## Deprecation Notice

There is [a new core integration of Home Assistant](https://www.home-assistant.io/integrations/cloudflare/) which does mostly the same. I recommend using the integration since it is more efficient than an addon. The only feature missing there is to update multiple domains or even zones since you can only have one instance of the integration.

## Installation

[![Open your Home Assistant instance and show the add add-on repository dialog with a specific repository URL pre-filled.](https://my.home-assistant.io/badges/supervisor_add_addon_repository.svg)](https://my.home-assistant.io/redirect/supervisor_add_addon_repository/?repository_url=https%3A%2F%2Fgithub.com%2Fkjell5317%2Faddon-ddns)

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
