terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
  required_version = ">= 1.3.6"
}

provider "yandex" {
  cloud_id  = "b1geb139r52nt0tj6377"
  folder_id = "b1g757o0h39ncetirpju"
}

resource "yandex_compute_instance" "nat" {

  name        = "nat-vm"
  platform_id = "standard-v1"
  zone        = var.zone

  resources {
    cores  = 2
    memory = 2
  }

  boot_disk {
    initialize_params {
      image_id = "fd80mrhj8fl2oe87o4e1"
    }
  }

  network_interface {

    subnet_id  = "${yandex_vpc_subnet.my-public.id}"
    nat        = true
    ip_address = "192.168.10.254"

  }

  metadata = {
    ssh-keys = "ubuntu:${file("~/.ssh/id_rsa.pub")}"
  }

  scheduling_policy {
    preemptible = true
  }
}

resource "yandex_compute_instance" "vm-public" {

  name        = "vm-public"
  platform_id = "standard-v1"
  zone        = var.zone

  resources {
    cores  = 2
    memory = 2
  }

  boot_disk {
    initialize_params {
      image_id = "fd8k5kam36qhmnojj8je"
    }
  }

  network_interface {

    subnet_id  = "${yandex_vpc_subnet.my-public.id}"
    nat        = true
  }

  metadata = {
    ssh-keys = "ubuntu:${file("~/.ssh/id_rsa.pub")}"
  }

  scheduling_policy {
    preemptible = true
  }
}

resource "yandex_compute_instance" "vm-private" {

  name        = "vm-private"
  platform_id = "standard-v1"
  zone        = var.zone

  resources {
    cores  = 2
    memory = 2
  }

  boot_disk {
    initialize_params {
      image_id = "fd8k5kam36qhmnojj8je"
    }
  }

  network_interface {

    subnet_id  = "${yandex_vpc_subnet.my-private.id}"
    nat        = false
  }

  metadata = {
    ssh-keys = "ubuntu:${file("~/.ssh/id_rsa.pub")}"
  }

  scheduling_policy {
    preemptible = true
  }
}