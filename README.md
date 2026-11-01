# Домашнее задание к занятию «Продвинутые методы работы с Terraform» Дедяхин Игорь

### Цели задания

1. Научиться использовать модули.
2. Отработать операции state.
3. Закрепить пройденный материал.


### Чек-лист готовности к домашнему заданию

1. Зарегистрирован аккаунт в Yandex Cloud. Использован промокод на грант.
2. Установлен инструмент Yandex CLI.
3. Исходный код для выполнения задания расположен в директории [**04/src**](https://github.com/netology-code/ter-homeworks/tree/main/04/src).
4. Любые ВМ, использованные при выполнении задания, должны быть прерываемыми, для экономии средств.

------
### Внимание!! Обязательно предоставляем на проверку получившийся код в виде ссылки на ваш github-репозиторий!
Убедитесь что ваша версия **Terraform** ~>1.12.0
Пишем красивый код, хардкод значения не допустимы!
------

### Задание 1

1. Возьмите из [демонстрации к лекции готовый код](https://github.com/netology-code/ter-homeworks/tree/main/04/demonstration1) для создания с помощью двух вызовов remote-модуля -> двух ВМ, относящихся к разным проектам(marketing и analytics) используйте labels для обозначения принадлежности.  В файле cloud-init.yml необходимо использовать переменную для ssh-ключа вместо хардкода. Передайте ssh-ключ в функцию template_file в блоке vars ={} .
Воспользуйтесь [**примером**](https://oneuptime.com/blog/post/2026-03-02-how-to-use-cloud-init-with-terraform-for-ubuntu-provisioning/view). Обратите внимание, что ssh-authorized-keys принимает в себя список, а не строку.
3. Добавьте в файл cloud-init.yml установку nginx.
4. Предоставьте скриншот подключения к консоли и вывод команды ```sudo nginx -t```, скриншот консоли ВМ yandex cloud с их метками. Откройте terraform console и предоставьте скриншот содержимого модуля. Пример: > module.marketing_vm
------
В случае использования MacOS вы получите ошибку "Incompatible provider version" . В этом случае скачайте remote модуль локально и поправьте в нем версию template провайдера на более старую.
------

### Решение

1. Берем из задания готовый код, изменяем [main.tf](demonstration1/vms/main.tf), теперь создаются две ВМ labels marketing и analytics. В файле cloud-init.yml заменяем ключ  на переменную ```ssh_key```. С помощью функции template_file ключ будет передаваться в перменную ```ssh_key``` из файла id_ed25519.pub.

2. Добавляем в в файл [cloud-init.yml](demonstration1/vms/cloud-init.yml) установку nginx 

3. Подключаемся к ВМ, проверяем nginx

![nginx](/screenshots/1.png)

Вывод terraform console:

![console](/screenshots/2.png)

### Задание 2

1. Напишите локальный модуль vpc, который будет создавать 2 ресурса: **одну** сеть и **одну** подсеть в зоне, объявленной при вызове модуля, например: ```ru-central1-a```.
2. Вы должны передать в модуль переменные с названием сети, zone и v4_cidr_blocks.
3. Модуль должен возвращать в root module с помощью output информацию о yandex_vpc_subnet. Пришлите скриншот информации из terraform console о своем модуле. Пример: > module.vpc_dev  
4. Замените ресурсы yandex_vpc_network и yandex_vpc_subnet созданным модулем. Не забудьте передать необходимые параметры сети из модуля vpc в модуль с виртуальной машиной.
5. Сгенерируйте документацию к модулю с помощью terraform-docs.
 
Пример вызова

```
module "vpc_dev" {
  source       = "./vpc"
  env_name     = "develop"
  zone = "ru-central1-a"
  cidr = "10.0.1.0/24"
}
```
### Решение

1. Создан локальный модуль [vpc](demonstration1/vms/vpc/main.tf), который будет создавать 2 ресурса: **одну** сеть и **одну** подсеть

2. В модуль бедет переданы перменные с названиями сети, zone и v4_cidr_blocks.

```hcl
module "vpc_dev" {
  source = "./vpc"
  env_name = "develop"
  zone = "ru-central1-a"
  cidr = ["10.0.1.0/24"]
}
```

3. Модуль возвращает в root module  информацию о yandex_vpc_subnet. с помощью [outputs](demonstration1/vms/vpc/outputs.tf)

![console](/screenshots/3.png)
 

4. Ресурсы yandex_vpc_network и yandex_vpc_subnet в [main](demonstration1/vms/main.tf) заменены модулем ```vpc```

5. [Документация](demonstration1/vms/vpc/README.md) сгенерирована с помощью terraform-docs 


### Задание 3
1. Выведите список ресурсов в стейте.
2. Полностью удалите из стейта модуль vpc.
3. Полностью удалите из стейта модуль vm.
4. Импортируйте всё обратно. Проверьте terraform plan. Значимых(!!) изменений быть не должно.
Приложите список выполненных команд и скриншоты процессы.


### Решение

1. Выводим список ресурсов в стейте ```terraform state list```:


![state](/screenshots/4.png)

2. Удаляем из стейта модуль vpc 

- terraform state rm module.vpc_dev.yandex_vpc_network.network

- terraform state rm module.vpc_dev.yandex_vpc_subnet.subnet


![state](/screenshots/5.png)

3. Удаляем из стейта модуль vm 

- terraform state rm module.analytics-vm.yandex_compute_instance.vm[0]

- terraform state rm module.marketing-vm.yandex_compute_instance.vm[0]

![state](/screenshots/6.png)

4. Импортируем все реcурcы обратно, id ресурсов получаем с помощью yc compute instance list, yc vpc network list, yc vpc subnet list

- terraform import module.vpc_dev.yandex_vpc_network.network enpp439oajjg5bn1723j

- terraform import module.vpc_dev.yandex_vpc_subnet.subnet e9boh6ksm105h4gas5lk

- terraform import module.analytics-vm.yandex_compute_instance.vm[0] fhmilq3p7pag17kvq1ra

- terraform import module.marketing-vm.yandex_compute_instance.vm[0] fhmqgh5o75iqhu036aqf

![state](/screenshots/7.png)

Terraform plan:

![state](/screenshots/8.png)





