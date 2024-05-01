
resource "docker_image" "rds" {
  name         = "mysql:latest"
  keep_locally = true
}

resource "docker_container" "rds-container" {
  name  = "mysql-spring-container"
  image = docker_image.rds.image_id

  networks_advanced {
    name = docker_network.this.id
  }

  volumes {
    volume_name    = docker_volume.this.name
    container_path = "/var/lib/mysql"
  }

  ports {
    internal = local.mysql_port
    external = var.mysql-external-port
    protocol = "tcp"
  }

  env = [
    "MYSQL_ROOT_PASSWORD=${random_password.this.result}",
    "MYSQL_DATABASE=${var.schema-name}"
  ]

  healthcheck {
    test     = ["CMD", "mysqladmin", "ping", "-h", "localhost"]
    timeout  = "30s"
    retries  = 5
    interval = "10s"
  }
}


resource "docker_volume" "this" {
  name = "SPRINGBOOT"
}

resource "random_password" "this" {
  length = 10
}