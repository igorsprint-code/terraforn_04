
module "vpc_dev" {
  source   = "./vpc"
  env_name = "develop"
  zone     = "ru-central1-a"
  cidr     = ["10.0.1.0/24"]
}



module "marketing-vm" {
  source         = "git::https://github.com/udjin10/yandex_compute_instance.git?ref=main"
  env_name       = var.marketing_env_name
  network_id     = module.vpc_dev.network_id
  subnet_zones   = var.marketing_zones
  subnet_ids     = [module.vpc_dev.subnet_id]
  instance_name  = var.marketing_instance_name
  instance_count = var.marketing_instance_count
  image_family   = var.marketing_image_family
  public_ip      = var.marketing_public_ip

  labels = var.marketing_labels

  metadata = {
    user-data          = data.template_file.cloudinit.rendered #Для демонстрации №3
    serial-port-enable = 1
  }

}

module "analytics-vm" {
  source         = "git::https://github.com/udjin10/yandex_compute_instance.git?ref=main"
  env_name       = var.analytics_env_name
  network_id     = module.vpc_dev.network_id
  subnet_zones   = var.analytics_zones
  subnet_ids     = [module.vpc_dev.subnet_id]
  instance_name  = var.analytics_instance_name
  instance_count = var.analytics_instance_count
  image_family   = var.analytics_image_family
  public_ip      = var.analytics_public_ip

  labels = var.analytics_labels

  metadata = {
    user-data          = data.template_file.cloudinit.rendered #Для демонстрации №3
    serial-port-enable = 1
  }

}

#Пример передачи cloud-config в ВМ для демонстрации №3
data "template_file" "cloudinit" {
  template = file("./cloud-init.yml")

  vars = {
    ssh_key = file("~/.ssh/id_ed25519.pub")
  }
}

