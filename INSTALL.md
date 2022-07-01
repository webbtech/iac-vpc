# Install Docs

## Module Create Order

1. We need the s3 for the remote terraform state, so navigate to the state directory (prod, test etc.), and create it first
2. vpc

## Removing older Version

We need to destroy the existing iac-webbtech terraform build. To do so we'll need to install an older version.

Attempting to do so resulted in this error: `required_version = ">= 0.12.6, < 0.14"`

For instruction on installing and older version, see [here](https://medium.com/@haridevvengateri/how-to-install-an-older-version-of-terraform-on-mac-os-4b1aac04d45e)

For release listing [see here](https://releases.hashicorp.com/terraform/)
