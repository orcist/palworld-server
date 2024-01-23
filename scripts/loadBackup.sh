#!/bin/bash

echo "LOADING BACKUP FROM ${AWS_S3_BUCKET}"
aws s3 sync $AWS_S3_BUCKET /palworld/Pal/Saved/SaveGames/0/**/
echo "BACKUP LOAD COMPLETE"
