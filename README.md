# Automatizando o Gerenciamento de Ambientes Kubernetes com Terraform e Helm

Este repositório contém exemplos de código e recursos para automatizar a criação e o gerenciamento de ambientes Kubernetes no EKS da AWS usando Terraform e Helm. Ele é parte de uma série de artigos que exploram o uso dessas ferramentas para gerenciar micro serviços Kubernetes de forma eficiente e escalável.

## Conteúdo

- Exemplos de código Terraform para criar um cluster EKS na AWS, gerenciar namespaces, criar usuários e atribuir permissões.
- Exemplos de código Terraform para implantar ferramentas no cluster EKS usando Helm.
- Exemplos de como gerar um arquivo kubeconfig para um usuário específico.

## Como usar

1. Clone este repositório.
2. Instale o [Terraform](https://www.terraform.io/downloads.html) e o [Helm](https://helm.sh/docs/intro/install/).
3. Navegue até o diretório do projeto.
4. Execute `terraform init` para inicializar o diretório com Terraform.
5. Execute `terraform apply` para criar os recursos.

## Contribuindo

Contribuições são bem-vindas! Por favor, leia as [diretrizes de contribuição](CONTRIBUTING.md) antes de enviar uma pull request.

## Licença

Este projeto está licenciado sob a licença MIT - veja o arquivo [LICENSE.md](LICENSE.md) para detalhes.
