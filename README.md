## ansible

```
## Проверка синтаксиса файла reactjs_playbook.yml
ansible-playbook reactjs_playbook.yml --syntax-check

## Проверка выполнения плейбука без выполнения изменений на сервере
ansible-playbook reactjs_playbook.yml --check

## Проверить доступность всех хостов из списка hosts
ansible -i hosts all -m ping


```
