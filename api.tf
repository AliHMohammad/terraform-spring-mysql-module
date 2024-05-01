
resource "docker_image" "this" {
  name         = var.api-image-name
  keep_locally = true
}

resource "docker_container" "this" {
  name  = "spring-container"
  image = docker_image.this.image_id

  env = [
    "JDBC_DATABASE_URL=jdbc:mysql://${docker_container.rds-container.name}:${local.mysql_port}/${var.schema-name}",
    "JDBC_USERNAME=root",
    "JDBC_PASSWORD=${random_password.this.result}"
  ]

  ports {
    internal = 8080
    external = 8080
    protocol = "tcp"
  }

  networks_advanced {
    name = docker_network.this.id
  }

  depends_on = [time_sleep.wait_15_seconds]
}

resource "time_sleep" "wait_15_seconds" {
  depends_on      = [docker_container.rds-container]
  create_duration = "15s"
}