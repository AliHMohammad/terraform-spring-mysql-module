terraform {
  required_version = "~>1.8"
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~>3.0"
    }
  }
}