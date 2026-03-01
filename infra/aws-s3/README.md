# AWS S3 Module

- Create an AWS S3 bucket.
- Add an IAM user with write permission to the bucket.

## Prerequisites

- An AWS IAM user with permissions to manage S3 buckets and IAM.
  (e.g. predefined policy `AmazonS3FullAccess` and `IAMFullAccess`, though
  they're too permissive).

## Object Lock

Lifecycle rules of AWS S3 are configured to expire (delete) objects after they
have been uploaded for a given period (e.g. 180 days). But we often want to keep
certain objects forever. On this purpose, we can harness the [object lock](https://docs.aws.amazon.com/AmazonS3/latest/userguide/object-lock.html)
feature, specificall by manually enabling the "Object Lock legal hold" for the
underline object.
