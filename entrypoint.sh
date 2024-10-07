#!/bin/sh

set -e

if [ -z "$S3_ENDPOINT" ]; then
    echo "S3_ENDPOINT is not set"
    exit 1
fi

if [ -z "$S3_ACCESS_KEY" ]; then
    echo "S3_ACCESS_KEY is not set"
    exit 1
fi

if [ -z "$S3_SECRET_KEY" ]; then
    echo "S3_SECRET_KEY is not set"
    exit 1
fi

if [ -z "$S3_BUCKET" ]; then
    echo "S3_BUCKET is not set"
    exit 1
fi

mc alias set upstream "$S3_ENDPOINT" "$S3_ACCESS_KEY" "$S3_SECRET_KEY"
echo "S3 alias 'upstream' created successfully"


echo "Syncing from S3 bucket to local filesystem..."
mc mirror upstream/$S3_BUCKET /data

echo "Initial sync completed successfully"

echo "Starting watch mode to sync local changes to S3 bucket..."
mc mirror --watch --remove --overwrite /data upstream/$S3_BUCKET