# Setup
``` shell
terraform init
terraform plan -out plan.out
terraform apply plan.out
```



# Terraform installation
``` shell
## Installing the requirements
PKGMAN=$([[ "${OS_TYPE}" == "linux" ]] && echo "sudo apt" || echo brew)
${PKGMAN} install wget unzip

## Downloading and installing the terraform locally
TF_VERSION="1.13.1"
OS_TYPE=$(uname -s | tr "[A-Z]" "[a-z]")
OS_ARCH=$([[ $(uname -m) =~ "x86_64" ]] && echo "amd64" || echo "${OS_ARCH}")
wget -P /tmp "https://releases.hashicorp.com/terraform/${TF_VERSION}/terraform_${TF_VERSION}_${OS_TYPE}_${OS_ARCH}.zip"
unzip /tmp/terraform*.zip
sudo mv /tmp/terraform /usr/local/bin
```



# Gcloud installation and setup
``` shell
## Installing python3, pip3 and awscli
OS_TYPE=$(uname -s | tr "[A-Z]" "[a-z]")
PKGMAN=$([[ "${OS_TYPE}" == "linux" ]] && echo "sudo apt" || echo brew)
${PKGMAN} install python3 python3-pip
sudo pip install awscli

## Setting up the awscli - https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-quickstart.html
aws configure
```
