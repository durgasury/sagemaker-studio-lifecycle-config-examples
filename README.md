# SageMaker Studio Lifecycle Configuration Samples

### Overview

A collection of sample scripts customizing SageMaker Studio Applications using Lifecycle Configuration

Lifecycle Configurations provide a mechanism to customize the Jupyter Server and Kernel Application instances via shell scripts that are executed during the lifecycle of the application.

#### Sample Scripts

* [change-default-home](scripts/change-default-home) - Updates the home directory for logged in users to a different directory than home.
* [git-clone-repo](scripts/git-clone-repo) - Checks out a Git repository under the user's home folder automatedly when the Jupter server starts.
* [git-clone-with-credentials](scripts/git-clone-with-credentials) - Retrieves git credentials from secrets manager and uses it to clone a git repository in the user's home folder.
* [install-autoshutdown-server-extension](scripts/install-autoshutdown-server-extension) (Recommended) - Installs only the server part of idle-kernel shutdown extension. No external dependencies to install, recommended to use in VPCOnly mode with restricted Internet connectivity. Idle timelimit has to be set using Life Cycle Configuration script.
* [install-autoshutdown-extension](scripts/install-autoshutdown-extension) - Installs the auto idle-kernel shutdown extension on the Jupyter Server. This install allows users to set idle timeout limit using the UI. ***Note***: *The UI plugin is only compatible with JupyterLab v1.0. See [JupyterLab versioning](https://docs.aws.amazon.com/sagemaker/latest/dg/studio-jl.html) for JupyterLab versions in SageMaker Studio.*
* [install-lsp-features](scripts/install-lsp-features) - Installs coding assistance tools to enable features like auto-completion, linting, and hover suggestions in Studio JupyterLab v3+.
* [install-pip-package-on-kernel](scripts/install-pip-package-on-kernel) - Installs a python package with pip on a Studio Kernel
* [install-requirements-txt](scripts/install-requirements-txt) - Checks for a requirements.txt file in the user's home directory. If exists, installs all the packages for the user.
* [push-history-s3](scripts/push-history-s3) - Saves bash and jupyter history to SageMaker default s3 bucket every 5 minutes.
* [remove-local-efs](scripts/remove-local-efs) - Checks for a `.local/lib` folder in the user's home directory on EFS and removes its contents. Attach this script to any KernelGateway app and create an app from the CLI. This resolves any issues with Studio restarts caused due to internal package conflicts.
* [run-lcc-from-s3](scripts/run-lcc-from-s3) - Downloads a shell script from S3 and runs it. This can be used to dynamically update the startup scripts, since the LCC script itself does not change. Note, the timeout for LCC configuration still holds, the script on S3 cannot run longer than the timeout.
* [set-git-config](scripts/set-git-config) - This script sets the username and email address in Git config.
* [set-git-credentials](scripts/set-git-credentials) - Adds the user's git credentials to Secret Manager and configures git to fetch the credentials from there when needed
* [set-proxy-settings](scripts/set-proxy-settings) - Configures HTTP and HTTPS proxy settings on jupter server and on the Studio kernels.


#### Developing LCC Scripts for SageMaker Studio

For best practicies, please check the [DEVELOPMENT.md](DEVELOPMENT.md).
