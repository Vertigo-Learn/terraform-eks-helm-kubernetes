terraform {
  required_version = ">= 1.3.0"

  required_providers {

    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.67.0"
    }

    local = {
      source  = "hashicorp/local"
      version = "~> 2.4.0"
    }

    helm = {
      source  = "hashicorp/helm"
      version = "~> 2.9.0"
    }

    null = {
      source  = "hashicorp/null"
      version = "~> 3.2.1"
    }

    random = {
      source  = "hashicorp/random"
      version = "~> 3.5.1"
    }

    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.20.0"
    }
  }
}