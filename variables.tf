
variable "schema-name" {
  type        = string
  description = "The created schema in the mysql rds"
  default     = "default_db"
}

variable "api-image-name" {
  type        = string
  description = "The name of the API image"
}

variable "mysql-external-port" {
  type        = number
  description = "the external port for the mysql-container"
  default     = 5555
}