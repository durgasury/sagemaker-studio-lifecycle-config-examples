# Run a shell script from S3
# Sample hello-world script is attached to the directory
# Upload the file to S3 and update the location in line #13
#!/bin/bash

set -eux

# download LCC script from S3
mkdir -p .lcc-scripts

# update this to your LCC script location
# use VPC endpoint with --endpoint-url if Studio is running in VPC only mode
aws s3 cp s3://<bucket>/<key> .lcc-scripts/lcc.sh

chmod +x .lcc-scripts/lcc.sh

# run the script
/home/sagemaker-user/.lcc-scripts/lcc.sh