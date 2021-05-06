#!/usr/bin
curl -L "$(curl -s https://api.github.com/repos/terraform-docs/terraform-docs/releases/latest | grep -o -E "https://.+?-linux-amd64.tar.gz")" >terraform-docs.tgz && tar xzf terraform-docs.tgz && chmod +x terraform-docs && sudo mv terraform-docs /usr/bin/
curl -L "$(curl -s https://api.github.com/repos/terraform-linters/tflint/releases/latest | grep -o -E "https://.+?_linux_amd64.zip")" >tflint.zip && unzip tflint.zip && rm tflint.zip && sudo mv tflint /usr/bin/
