#!/bin/bash

while sleep $AWS_S3_BACKUP_EVERY_SECONDS; do
    echo "SAVING BACKUP TO ${AWS_S3_BUCKET}"
    aws s3 sync /palworld/Pal/Saved/SaveGames/0/**/ $AWS_S3_BUCKET
    echo "BACKUP SAVE COMPLETE"
done
