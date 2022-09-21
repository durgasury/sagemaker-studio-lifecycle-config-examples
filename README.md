# SageMaker Studio Lifecycle Configuration Samples

### Overview

A collection of sample scripts customizing SageMaker Studio Applications using Lifecycle Configuration

Lifecycle Configurations provide a mechanism to customize the Jupyter Server and Kernel Application instances via shell scripts that are executed during the lifecycle of the application.

#### Sample Scripts

* [git-clone-repo](scripts/git-clone-repo) - Checks out a Git repository under the user's home folder automatedly when the Jupter server starts
* [install-autoshutdown-server-extension](scripts/install-autoshutdown-server-extension) (Recommended) - Installs only the server part of idle-kernel shutdown extension. No external dependencies to install, recommended to use in VPCOnly mode with restricted Internet connectivity. Idle timelimit has to be set using Life Cycle Configuration script.
* [install-autoshutdown-extension](scripts/install-autoshutdown-extension) - Installs the auto idle-kernel shutdown extension on the Jupyter Server. This install allows users to set idle timeout limit using the UI. ***Note***: *The UI plugin is only compatible with JupyterLab v1.0. See [JupyterLab versioning](https://docs.aws.amazon.com/sagemaker/latest/dg/studio-jl.html) for JupyterLab versions in SageMaker Studio.*
* [install-lsp-features](scripts/install-lsp-features) - Installs coding assistance tools to enable features like auto-completion, linting, and hover suggestions in Studio JupyterLab v3+.
* [install-pip-package-on-kernel](scripts/install-pip-package-on-kernel) - Installs a python package with pip on a Studio Kernel
* [set-git-config](scripts/set-git-config) - This script sets the username and email address in Git config.
* [set-git-credentials](scripts/set-git-credentials) - Adds the user's git credentials to Secret Manager and configures git to fetch the credentials from there when needed
* [set-proxy-settings](scripts/set-proxy-settings) - Configures HTTP and HTTPS proxy settings on jupter server and on the Studio kernels.

#### Developing LCC Scripts for SageMaker Studio

For best practicies, please check the [DEVELOPMENT.md](DEVELOPMENT.md).
