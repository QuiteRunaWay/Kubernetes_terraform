resource "yandex_vpc_network" "my-vpc" {
  name = "new-vpc"
}

resource "yandex_vpc_subnet" "my-public" {
  name           = "public"
  zone           = var.zone
  v4_cidr_blocks = ["192.168.10.0/24"]
  network_id     = "${yandex_vpc_network.my-vpc.id}"
}

resource "yandex_vpc_subnet" "my-private" {
  name           = "private"
  zone           = var.zone
  v4_cidr_blocks = ["192.168.20.0/24"]
  network_id     = "${yandex_vpc_network.my-vpc.id}"
  route_table_id = "${yandex_vpc_route_table.nat-route.id}"
}

resource "yandex_vpc_route_table" "nat-route" {
  name       = "nat-route"
  network_id = "${yandex_vpc_network.my-vpc.id}"
  static_route {
    destination_prefix = "0.0.0.0/0"
    next_hop_address   = "192.168.10.254"
}
}

