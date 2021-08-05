# DDNS

This add-on provides a script that updates all A records of a Cloudflare zone with your latest public ip address.
***Note:** .ml, .tk, .cf, .ga and .gq domains aren't supported by Cloudflare's API*

## Installation

Go to the add-on store of the supervisor and click an _repositories_ under the three dots.  
Copy [_https://github.com/kjell5317/addon-ddns_](https://github.com/kjell5317/addon-ddns) into the field and add this repository.  
Now you can install this add-on like any other home-assistant add-on.

## Configuration

Create an API token at [Cloudflare](https://dash.cloudflare.com/profile/api-tokens) and give it Zone.DNS permissions.  
Copy your zone id from your dashboard.  
Enter these details in the configuration page of this add-on and start it. Watch the log for errors.
