## ansible

```
## How to install SSH server in Ubuntu

Type command:

sudo apt-get install openssh-server
```
```
# Installing Ansible on Ubuntu

$ sudo apt update
$ sudo apt install software-properties-common
$ sudo add-apt-repository --yes --update ppa:ansible/ansible
$ sudo apt install ansible


# Installing Ansible on RHEL, CentOS, or Fedora

On Fedora:
$ sudo dnf install ansible

On RHEL and CentOS:
$ sudo yum install ansible

```
```
# Встроенная проверка 

## Проверка синтаксиса файла reactjs_playbook.yml
ansible-playbook reactjs_playbook.yml --syntax-check

## Проверка выполнения плейбука без выполнения изменений на сервере
ansible-playbook reactjs_playbook.yml --check

## Проверить доступность всех хостов из списка hosts
ansible -i hosts all -m ping

## Проверить доступность gitlab-ost-prod-app01 хоста из инета
ansible all -i gitlab-ost-prod-app01, -m ping

## Проверить доступность gitlab-ost-prod-app01 и dockreg-ost-prod-app01 хостов из инета
ansible all -i gitlab-ost-prod-app01,dockreg-ost-prod-app01 -m ping

## Проверить доступность gitlab-ost-prod-app01 и dockreg-ost-prod-app01 хостов из списка hosts
ansible gitlab-ost-prod-app01,ntp-ost-prod-app03 -i hosts -m ping

## Увидить всё на всх машинах
ansible all -m setup

## Проверить что именно запуститься и на каких серверах. (Выполнения не будет, только инфа)
ansible-playbook -K -i consul.inv site.yml --list-tasks

## Проверить на каких серверах будет запуск. (Выполнения не будет, только инфа)
ansible-playbook -K -i consul.inv site.yml --list-hosts

## Проверить в каких тасках есть тэги на которых будет запуск.
ansible-playbook -K -i consul.inv site.yml --list-tasks --tags tagged

## Проверить в каких тасках нет тэгов и на которых не будет запуск.
ansible-playbook -K -i consul.inv site.yml --list-tasks --tags untagged

## Проверить, что запуститься только там где нет тэга nginx.
ansible-playbook -K -i consul.inv site.yml --list-tasks --skip-tags nginx

## To reboot all the servers in the [atlanta] group
ansible atlanta -a "/sbin/reboot"

## Выполнить shell команду
ansible raleigh -m shell -a 'echo $TERM'

## Copy a file directly to all servers in the [atlanta] group
ansible atlanta -m copy -a "src=/etc/hosts dest=/tmp/hosts"

## file module allows changing ownership and permissions on files.
ansible webservers -m file -a "dest=/srv/foo/b.txt mode=600 owner=mdehaan group=mdehaan"

## To ensure a specific version of a package is installed
ansible webservers -m yum -a "name=acme-1.5 state=present"

## Ensure a service is started on all webservers
ansible webservers -m service -a "name=httpd state=started"

## Запустить плайбук с интерпритатором python3
ansible-playbook -e 'ansible_python_interpreter=/usr/bin/python3' -i consul.inv site.yml

```

```
# Установка ansible-lint
sudo apt install ansible-lint -y

# проверка с помощью Lint
ansible-lint -p main.yml



```
