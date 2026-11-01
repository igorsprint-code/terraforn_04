output "network_id" {
  value = yandex_vpc_network.network.id
  description = "network id"
}

output "subnet_id" {
  value = yandex_vpc_subnet.subnet.id
  description = "subnet id"
}