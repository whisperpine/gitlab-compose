# AWS SES Module

Create AWS SES identities and configure DNS records on Cloudflare.

## Prerequisites

- An AWS IAM user with permissions to manage SES (e.g. predefined policy `AmazonSESFullAccess`).
- A domain hosted by Cloudflare DNS (so that DNS records could be managed
  by terraform).
- A Cloudflare API Token with proper permissions:

| Permission type | Permission | Access level |
| - | - | - |
| Zone | DNS | Edit |

## Production Access

When you first sign up for Amazon Simple Email Service (SES), your account is in
the *sandbox* mode by default, with many restrictions (e.g. 200 emails per
24-hour period). This is for dev and testing purpose by design.

To move out of the sandbox, you must *request production access* from AWS. This
grants full access to SES features for sending emails to any recipient.
Go to the AWS SES Console to send a request.

## Testing

Once the AWS SES identity has been set up, it's recommended to test it
independently (see [send-email.sh](../../scripts/send-email.sh)):

```sh
sh ./scripts/send-email.sh
```
