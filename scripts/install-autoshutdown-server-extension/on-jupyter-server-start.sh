#!/bin/bash
# This script installs the idle notebook auto-checker server extension to SageMaker Studio
# The original extension has a lab extension part where users can set the idle timeout via a Jupyter Lab widget.
# In this version the script installs the server side of the extension only. The idle timeout
# can be set via a command-line script which will be also created by this create and places into the
# user's home folder
#
# Installing the server side extension does not require Internet connection (as all the dependencies are stored in the
# install tarball) and can be done via VPCOnly mode.

set -eux

# timeout in minutes
export TIMEOUT_IN_MINS=2

# creating the command-line script for setting the idle timeout
cat > /home/sagemaker-user/set-time-interval.sh << EOF
#!/opt/conda/bin/python
import json
import requests
TIMEOUT=${TIMEOUT_IN_MINS}
session = requests.Session()
# Getting the xsrf token first from Jupyter Server
response = session.get("http://localhost:8888/jupyter/default/tree")
# calls the idle_checker extension's interface to set the timeout value
response = session.post("http://localhost:8888/jupyter/default/sagemaker-studio-autoshutdown/idle_checker",
            json={"idle_time": TIMEOUT, "keep_terminals": False},
            params={"_xsrf": response.headers['Set-Cookie'].split(";")[0].split("=")[1]})
if response.status_code == 200:
    print("Succeeded, idle timeout set to {} minutes".format(TIMEOUT))
else:
    print("Error!")
    print(response.status_code)
EOF
chmod +x /home/sagemaker-user/set-time-interval.sh

# "wget" is not part of the base Jupyter Server image, you need to install it first if needed to download the tarball
# sudo yum install -y wget
# Yoy can download the tarball from GitHub or alternatively, if you're using VPCOnly mode, you can host on S3
wget https://github.com/aws-samples/sagemaker-studio-auto-shutdown-extension/raw/main/sagemaker_studio_autoshutdown-0.1.1.tar.gz
# aws s3 --endpoint-url [S3 Interface Endpoint] cp s3://[tarball location] .

# Installs the extension
tar xzf sagemaker_studio_autoshutdown-0.1.1.tar.gz
cd sagemaker_studio_autoshutdown-0.1.1
pip install pydeps/*
pip install --no-dependencies --no-build-isolation -e .
jupyter serverextension enable --py sagemaker_studio_autoshutdown

# Restarts the jupyter server
nohup supervisorctl -c /etc/supervisor/conf.d/supervisord.conf restart jupyterlabserver

# Waiting for 60 seconds to make sure the Jupyter Server is up and running
sleep 60

# Calling the script to set the idle-timeout and active the extension
/home/sagemaker-user/set-time-interval.sh