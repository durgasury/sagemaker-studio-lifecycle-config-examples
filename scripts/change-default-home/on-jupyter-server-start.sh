#!bin/bash
# this script sets the default location on file explorer "~/notebooks"
# and launches new kernels on the new default location
# instead of the home directory
 
set -eux
 
cat > .jupyter/jupyter_notebook_config.json << EOF
{
  "NotebookApp": {
    "nbserver_extensions": {
      "sagemaker_ui_proxy": true,
      "\u2014py": true
    },
    "notebook_dir": "/root/notebooks"
  }
}
EOF

restart-jupyter-server
