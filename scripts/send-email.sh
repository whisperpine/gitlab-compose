#!/bin/sh

# Purpose: send an email via SMTP (testing AWS SES)
# Usage: sh ./scripts/send-email.sh
# Dependencies: git, curl
# Date: 2025-07-27
# Author: Yusong

set -e

# The root directory of this project.
project_root=$(git rev-parse --show-toplevel)
# The path of email.txt file.
email_content_file="$project_root/scripts/email.txt"

if [ -e "$project_root/.env" ]; then
    # Source env var in ".env" (create it if missing).
    . "$project_root/.env"
else
    echo "Error: '$project_root/.env' file doesn't exist."
    echo "Copy from '$project_root/example.env' and modify it."
    exit 1
fi

# Create email.txt and add text content.
cat <<EOF >"$email_content_file"
From: $GITLAB_EMAIL_FROM
To: $TEST_EMAIL_RECIPIENT
Subject: Test Email from AWS SES
Content-Type: text/plain; charset=UTF-8

This is a test email sent via AWS SES SMTP using curl.
EOF

# Send email through AES SES (via "STARTTLS Port").
curl -v --ssl \
    --url "smtp://$SMTP_ADDRESS:587" \
    --user "$SMTP_USER_NAME:$SMTP_PASSWORD" \
    --mail-from "$GITLAB_EMAIL_FROM" \
    --mail-rcpt "$TEST_EMAIL_RECIPIENT" \
    --upload-file "$email_content_file"

# # Send email through AES SES (via "TLS Wrapper Port").
# curl -v \
#     --url "smtps://$SMTP_ADDRESS:465" \
#     --user "$SMTP_USER_NAME:$SMTP_PASSWORD" \
#     --mail-from "$GITLAB_EMAIL_FROM" \
#     --mail-rcpt "$TEST_EMAIL_RECIPIENT" \
#     --upload-file "$email_content_file"
