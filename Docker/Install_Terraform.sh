/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
brew tap hashicorp/tap
brew install hashicorp/tap/terraform
terraform --version

