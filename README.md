## ansible

```
# Встроенная проверка 

## Проверка синтаксиса файла reactjs_playbook.yml
ansible-playbook reactjs_playbook.yml --syntax-check

## Проверка выполнения плейбука без выполнения изменений на сервере
ansible-playbook reactjs_playbook.yml --check

## Проверить доступность всех хостов из списка hosts
ansible -i hosts all -m ping

## To reboot all the servers in the [atlanta] group
ansible atlanta -a "/sbin/reboot"

## Выполнить shell команду
ansible raleigh -m shell -a 'echo $TERM'

```

```
# Установка ansible-lint
sudo apt install ansible-lint -y

# проверка с помощью Lint
ansible-lint -p main.yml



```
