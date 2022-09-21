import os
import json
import boto3
import urllib
import logging
import sagemaker
import argparse
from datetime import datetime

# rename if you have a different bucket for logs
LOGGING_BUCKET = sagemaker.Session().default_bucket()

logging.basicConfig(level=logging.INFO, format='%(message)s')
logger = logging.getLogger()
logger.addHandler(logging.FileHandler('/var/log/history_logging.log', 'a'))


def get_user_profile_name():
    with open("/opt/ml/metadata/resource-metadata.json", "r") as f:
        data = json.load(f)
        return data['UserProfileName']


if __name__=="__main__":
    s3 = boto3.client("s3")
    time_prefix = datetime.now().strftime("%Y%m%d-%H%M%S")
    prefix = get_user_profile_name()

    logger.info("Looking for bash history and writing to S3")
    if os.path.exists(".bash_history"):
        logger.info("Found history file. Copying to S3")
        file_name = f"{prefix}/{time_prefix}_.bash_history"
        s3.upload_file(
            ".bash_history",
            LOGGING_BUCKET,
            file_name
        )
    else:
        logger.warning("Bash history file missing!")

    logger.info("Looking for Jupyter history and writing to S3")
    if os.path.exists(".ipython/profile_default/history.sqlite"):
        logger.info("Found Jupyter history. Copying to S3")
        file_name = f"{prefix}/{time_prefix}_history.sqlite"
        s3.upload_file(
            ".ipython/profile_default/history.sqlite",
            LOGGING_BUCKET,
            file_name
        )
    else:
        logger.warning("Jupyter history file missing!")