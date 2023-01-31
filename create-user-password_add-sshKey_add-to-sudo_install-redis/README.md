### 3.7-skillbox

### Чтобы сгенерировать хеш пароля запустить команду
```
python3 -c 'import crypt,getpass;pw=getpass.getpass();print(crypt.crypt(pw) if (pw==getpass.getpass("Confirm: ")) else exit())'
```
### Для создания шифрования пароля в ansible-vault запускаем
```
sergey@sbnk ~/TEMP/3.7-skillbox $ ansible-vault encrypt_string
New Vault password: 
Confirm New Vault password: 
Reading plaintext input from stdin. (ctrl-d to end input)
$6$hu5BDUhpHT4BBSKT$N/jFcsdoAV/jhHp2ao.a37XeKiADZj6C0K9eShLKYD3fR1SA61Gz2.di59FPWB8z/X2yRO9axz3WrHpBP/IZW1  <-- (Это сам пароль)
```

### Запуск
ansible-playbook -K -i host.inv playbook.yml --ask-vault-pass

### Проверка
ansible-playbook -K -i host.inv playbook.yml --ask-vault-pass --list-tasks --skip-tags nginx

ansible-playbook -K -i host.inv playbook.yml --ask-vault-pass --list-tasks --tags tagged

ansible-playbook -K -i host.inv playbook.yml --ask-vault-pass --list-tasks --skip-tags print

ansible-playbook -K -i host.inv playbook.yml --ask-vault-pass --list-tasks --tags print

#############

Что нужно сделать

У нас есть две машины с пустой ОС, с последней версией Ubuntu. Создайте playbook верхнего уровня и Ansible- роль с необходимыми тасками, переменными и тегами для настройки сервера по разным сценариям и возможностями переиспользования.

1. Создайте Ansible-роль. Роль должна выполнять следующее:
- создавать пользователя Ansible,
- добавлять открытый SSH-ключ,
- добавлять пользователя Ansible в группу sudo,
- задавать пароль пользователя Ansible,
- устанавливать пакеты python3, pip3.
2. Убедитесь в том, что:
- созданная роль имеет таск для установки nginx с тегом nginx;
- созданная роль имеет таск для создания виртуального хоста в nginx с использованием шаблона с переменной domain_name;
- по умолчанию имя домена — example.com, его следует установить в defaults/main.yml;
- созданная роль имеет имя виртуального хоста, которое взято извне и задано динамически, это могут быть:
- --extra-vars в командной строке,
- consul(redis),
- env-переменная.
3. Создайте таск (или роль) для редактирования SSHD с тегом SSHD, а именно:
- запретите аутентификацию по паролю,
- включите вход только по ключу,
- запретите вход под root.
4. Создайте playbook.yml, в котором будут использоваться роли (или таски), созданные выше.
5. Используя модуль debug, добавьте таск в playbook.yml, чтобы напечатать внешний IP-адрес машины.
6. Используя модуль shell, добавьте таск в playbook.yml с запуском команды uname -a, зарегистрируйте переменную и напечатайте в выводе Ansible.
7. Для тасков из пунктов 5 и 6 установите тег print.
8. Запустите playbook:
- первый раз на машинах 1, 2 — таски с пропуском тегов nginx, print;
- второй раз на машине 2 — все таски, кроме print; 
- третий раз на всех машинах —  только таски с тегом print.


https://webdevblog.ru/redis-dlya-nachinajushhij/

https://citizix.com/how-to-using-ansible-to-install-and-configure-redis-6-on-rocky-linux-8/

https://github.com/geerlingguy/ansible-role-redis/blob/master/defaults/main.yml

https://relativkreativ.at/articles/how-to-install-python-with-ansible



