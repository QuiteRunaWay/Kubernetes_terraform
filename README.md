# Домашнее задание к занятию "15.1. Организация сети"

Домашнее задание будет состоять из обязательной части, которую необходимо выполнить на провайдере Яндекс.Облако и дополнительной части в AWS по желанию. Все домашние задания в 15 блоке связаны друг с другом и в конце представляют пример законченной инфраструктуры.  
Все задания требуется выполнить с помощью Terraform, результатом выполненного домашнего задания будет код в репозитории. 

Перед началом работ следует настроить доступ до облачных ресурсов из Terraform используя материалы прошлых лекций и [ДЗ](https://github.com/netology-code/virt-homeworks/tree/master/07-terraform-02-syntax ). А также заранее выбрать регион (в случае AWS) и зону.

---
## Задание 1. Яндекс.Облако (обязательное к выполнению)

1. Создать VPC.
- Создать пустую VPC. Выбрать зону.
2. Публичная подсеть.
- Создать в vpc subnet с названием public, сетью 192.168.10.0/24.
- Создать в этой подсети NAT-инстанс, присвоив ему адрес 192.168.10.254. В качестве image_id использовать fd80mrhj8fl2oe87o4e1
- Создать в этой публичной подсети виртуалку с публичным IP и подключиться к ней, убедиться что есть доступ к интернету.
3. Приватная подсеть.
- Создать в vpc subnet с названием private, сетью 192.168.20.0/24.
- Создать route table. Добавить статический маршрут, направляющий весь исходящий трафик private сети в NAT-инстанс
- Создать в этой приватной подсети виртуалку с внутренним IP, подключиться к ней через виртуалку, созданную ранее и убедиться что есть доступ к интернету

Resource terraform для ЯО
- [VPC subnet](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/vpc_subnet)
- [Route table](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/vpc_route_table)
- [Compute Instance](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/compute_instance)
---


## Ответ: 

Устанавливаем YC, Terraform - или как в моем случае - обновляем до актуальных версий, проводим первичную инициализацию в облаке путем задания первичных параметров (токен, идентификаторы облака, рабочей папки и зоны доступности):

![image](https://user-images.githubusercontent.com/92969676/205219818-de70608f-c4b4-4f49-9406-70803a873ee7.png)

![image](https://user-images.githubusercontent.com/92969676/205219433-a57536c2-844d-4bcd-b74d-18d0ce2160b0.png)

![image](https://user-images.githubusercontent.com/92969676/205218453-e49fba3c-81e9-40be-8e62-3e0047ecfd90.png)

Файлы конфигураций приложил.

В файле ```main.tf``` содержится информация по создаваемых VM и первоначальная информация по облаку и сети. Убирать в переменные не стал, информация не критичная, но можно было бы урать в переменные.

В файл ```variables.tf``` для примера положил информацию о зоне, в которой будут подниматься виртуальные машины.

В файл ```network.tf``` вынес всю информацию о создаваемых сетях, подсетях и о таблице маршрутизации.

По итогу план проходит корректно:

![image](https://user-images.githubusercontent.com/92969676/205613803-76e351b5-041f-4a51-aa51-1e19cac45960.png)

Инфраструктура поднимается:

![image](https://user-images.githubusercontent.com/92969676/205614703-7d5ee123-772d-44aa-b558-4fa84e1d34f4.png)

![image](https://user-images.githubusercontent.com/92969676/205614771-545e1d57-3625-43d5-a646-208c84f4ea48.png)

![image](https://user-images.githubusercontent.com/92969676/205614849-29a695a8-4702-48fc-8aed-a4e8f68a1e11.png)

![image](https://user-images.githubusercontent.com/92969676/205614942-ba17b4a9-336e-4cad-a471-9f850c555953.png)


## Задание 2*. AWS (необязательное к выполнению)

1. Создать VPC.
- Cоздать пустую VPC с подсетью 10.10.0.0/16.
2. Публичная подсеть.
- Создать в vpc subnet с названием public, сетью 10.10.1.0/24
- Разрешить в данной subnet присвоение public IP по-умолчанию. 
- Создать Internet gateway 
- Добавить в таблицу маршрутизации маршрут, направляющий весь исходящий трафик в Internet gateway.
- Создать security group с разрешающими правилами на SSH и ICMP. Привязать данную security-group на все создаваемые в данном ДЗ виртуалки
- Создать в этой подсети виртуалку и убедиться, что инстанс имеет публичный IP. Подключиться к ней, убедиться что есть доступ к интернету.
- Добавить NAT gateway в public subnet.
3. Приватная подсеть.
- Создать в vpc subnet с названием private, сетью 10.10.2.0/24
- Создать отдельную таблицу маршрутизации и привязать ее к private-подсети
- Добавить Route, направляющий весь исходящий трафик private сети в NAT.
- Создать виртуалку в приватной сети.
- Подключиться к ней по SSH по приватному IP через виртуалку, созданную ранее в публичной подсети и убедиться, что с виртуалки есть выход в интернет.

Resource terraform
- [VPC](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc)
- [Subnet](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet)
- [Internet Gateway](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/internet_gateway)
