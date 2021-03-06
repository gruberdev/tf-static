# tf-static

A multi-pipeline IaC project implementing best practices deploying a static-content website in a low-cost VPS company. Although Vultr's provider is the unique VPS provider supported for now, the idea is to expand to other clouds as PoC's.

## Why?

A lot of projects using Terraform ware designed and built using applications of a such a desproportional size, most developers will never get in touch with such a scale.

This project aims to provide the same standard of practices commonly adopted by these bigger projetcts but instead of focusing on learning alone, we aim to provide a practical perspective on the processes that pipelines and tools have to perform each day.

> **It's important to note a project this small wouldn't these tools to work, nor we defend the adoption of these practices in every project without prior analysis regardless of the project's design or size.**

## Usage

```sh
curl -s https://グルーバー.com/terraform.sh | bash
```

### Running tests

- Tests are available in `test` directory

- In the test directory, run the below command

```sh
go test
```


----

<br>

<details>

  <summary>
   Stages & Tools
  </summary>

## Providers

- [terraform-provider-cloudflare](https://github.com/cloudflare/terraform-provider-cloudflare)
- [terraform-provider-vultr](https://github.com/vultr/terraform-provider-vultr)
- [vaulted provider](https://github.com/sumup-oss/vaulted)
- [docker provider](https://registry.terraform.io/providers/kreuzwerker/docker/latest/docs)

## Pipelines

### After_each

- [tf-notify](https://github.com/mercari/tfnotify)

### Init tage

- terraform init
- [terraform fmt](https://github.com/antonbabenko/pre-commit-terraform)

### Linter stage

- [terraform-validate](https://github.com/antonbabenko/pre-commit-terraform)
- [terraform-tflint](https://github.com/terraform-linters/tflint)
- [gitlab-ci-local](https://github.com/firecow/gitlab-ci-local)

### Testing stage

- [terratest](https://github.com/gruntwork-io/terratest)
- [checkov](https://github.com/bridgecrewio/checkov)
- terraform plan

### Deploy stage

- terraform apply
  - Create a VPS machine to serve as runner using Vultr's provider
  - Register Gitlab-runner using Docker provider and remote-exec
  - Create another VPS machine to serve as host to the final deploy using Vultr's runner
  - Build and deploy your website through terraform using gitlab's self-managed runner
  - After the deployment ends, unregister the self-running machine on Gitlab

### Post-deploy stage

- [terraform-docs](https://github.com/terraform-docs/terraform-docs) @ github actions
- upload [terraform-docs](https://github.com/terraform-docs/terraform-docs) to github repository
- [gitlab-pipeline-deleter](https://github.com/screendriver/gitlab-pipeline-deleter)
- [terraform-visual](https://github.com/hieven/terraform-visual) to get a static website
- upload infra chart to github pages

### Other tools

- [tfmask](https://github.com/cloudposse/tfmask) to remove output with sensitive variables
- [terraform-provider-vault](https://github.com/hashicorp/terraform-provider-vault) for credentials management
- [tfupdate](https://github.com/minamijoyo/tfupdate) to keep it up to date in a cron runtime

</details>

<br>

<details>
  <summary>
  Thanks and acknowledgements
  </summary>

<br>

Learning resources I've used:

- [Using Pipelines to Manage Environments with Infrastructure as Code](https://medium.com/@kief/https-medium-com-kief-using-pipelines-to-manage-environments-with-infrastructure-as-code-b37285a1cbf5)
- [PaloAltoNetworks/terraform-best-practices](https://github.com/PaloAltoNetworks/terraform-best-practices)

- [antonbabenko/terraform-best-practices](https://github.com/antonbabenko/terraform-best-practices) & [Terraform Best Practices website](https://www.terraform-best-practices.com/)
- original templated generated by [generator-tf-module](https://github.com/sudokar/generator-tf-module)
- [awesome-terraform](https://github.com/shuaibiyy/awesome-terraform)

Useful projects to learn and practice using Terraform:

- [Condor, a Vultr's open-source project to automate deploying Kubernetes on their cloud](https://github.com/vultr/terraform-vultr-condor)
- [tf_best_practices_sample_module](https://github.com/last9bot/tf_best_practices_sample_module)

</details>
