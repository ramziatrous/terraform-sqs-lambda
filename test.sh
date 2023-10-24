#!/bin/bash
QUEUE_URL="DEINE_QUEUE_URL"
for i in 1 2 3 4 5 6 7 8 9 10
do
    aws sqs send-message \
    --profile DEIN_AWS_SSO_PROFILE \
    --queue-url $QUEUE_URL \
    --message-body "Test $i"
done