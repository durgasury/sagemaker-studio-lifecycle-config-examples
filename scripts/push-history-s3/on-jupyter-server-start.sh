#!/bin/bash

set -eux

# PARAMETERS
HISTFILESIZE=100000
PROMPT_COMMAND='history -a'

mkdir -p ~/.ipython/profile_default/startup/
touch ~/.ipython/profile_default/startup/00-startup.py

echo "export HISTFILESIZE=$HISTFILESIZE" | tee -a ~/.profile >/dev/null
echo "export PROMPT_COMMAND='$PROMPT_COMMAND'" | tee -a ~/.profile >/dev/null

# set credentials for cron 
/bin/cat <<EOF > /home/sagemaker-user/.log_history/env.sh
export AWS_CONTAINER_CREDENTIALS_RELATIVE_URI=$AWS_CONTAINER_CREDENTIALS_RELATIVE_URI
export AWS_DEFAULT_REGION=$AWS_DEFAULT_REGION
export SHELL=$SHELL
export AWS_ACCOUNT_ID=$AWS_ACCOUNT_ID
EOF

# download the script from Github
mkdir -p .log-history
# update wget url if merged to original 
wget .log-history/push_history.py https://raw.githubusercontent.com/durgasury/amazon-sagemaker-notebook-instance-lifecycle-config-samples/dsury-lcc-scripts/scripts/push-history-s3/push_history.py

sudo yum update -y & sudo yum upgrade -y
sudo yum install cronie -y

sudo service crond start

{sudo crontab -u sagemaker-user -l 2>/dev/null; echo "*/5 * * * * source /home/sagemaker-user/.log_history/env.sh; /opt/conda/bin/aws s3 cp .bash_history /opt/conda/bin/python /home/sagemaker-user/.log-history/push_history.py" } | sudo crontab -u sagemaker-user -