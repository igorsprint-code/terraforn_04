###cloud vars

variable "public_key" {
  type    = string
  default = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGiVcfW8Wa/DxbBNzmQcwn7hJOj7ji9eoTpFakVnY/AI webinar"
}

variable "default_zone" {
  type    = string
  default = "ru-central1-a"
}

variable "cloud_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/cloud/get-id"
}

variable "folder_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/folder/get-id"
}


### marketing vars


variable "marketing_env_name" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/folder/get-id"
  default     = "marketing"
}

variable "marketing_zones" {
  type    = list(string)
  default = ["ru-central1-a", "ru-central1-d"]
}

variable "marketing_instance_name" {
  type    = string
  default = "webs"
}

variable "marketing_instance_count" {
  type    = number
  default = 1
}

variable "marketing_image_family" {
  type    = string
  default = "ubuntu-2004-lts"
}

variable "marketing_public_ip" {
  type    = bool
  default = true
}

variable "marketing_labels" {
  type = map(string)
  default = {
    owner   = "i.dedyakhin"
    project = "marketing"
  }
}

### analytics vars


variable "analytics_env_name" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/folder/get-id"
  default     = "analytics"
}

variable "analytics_zones" {
  type    = list(string)
  default = ["ru-central1-a"]
}

variable "analytics_instance_name" {
  type    = string
  default = "web-stage"
}

variable "analytics_instance_count" {
  type    = number
  default = 1
}

variable "analytics_image_family" {
  type    = string
  default = "ubuntu-2004-lts"
}

variable "analytics_public_ip" {
  type    = bool
  default = true
}

variable "analytics_labels" {
  type = map(string)
  default = {
    owner   = "i.dedyakhin"
    project = "marketing"
  }
}