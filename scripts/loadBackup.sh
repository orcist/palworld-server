#!/bin/bash

echo "LOADING BACKUP FROM ${AWS_S3_BUCKET}"
aws s3 sync $AWS_S3_BUCKET $(find /palworld/Pal/Saved/SaveGames/0/ -mindepth 1 -maxdepth 1 -type d)
echo "BACKUP LOAD COMPLETE"
