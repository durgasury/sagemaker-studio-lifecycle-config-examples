# This script deletes the .local folder if it exists (resolve user installed packages
# causing issues with Studio JS app restart)
#!/bin/bash
 
set -eux
 
# check if folder exists
LOCAL_DIR=".local/lib"
if [ -d "$LOCAL_DIR" ]; then rm -rf $LOCAL_DIR; fi
 
echo "User installed package directory checked and removed."
