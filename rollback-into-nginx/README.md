### Как настроить автоматический откат в Ansible

:white_check_mark: 1.
Чтобы Ansible сам справлялся с ошибками, задачу нужно обернуть в `block`, а в `rescue` — прописать действия на случай ошибки.
#### `rescue` ловит только ошибки задач.

:white_check_mark: 2.
`meta: flush_handlers`
- По умолчанию Ansible запускает хендлеры в конце плейбука. Чтобы перезапустить сервис сразу после изменения, нужно добавить `meta: flush_handlers`

:white_check_mark: 3. 
`backup: true`
- backup: true, чтобы Ansible сохранял старую конфигурацию рядом. Бэкап создаётся только если файл изменился:

:white_check_mark: 4.
Задачи внутри `always` выполняются всегда — даже если раньше произошла ошибка. Но если сама задача внутри always завершится с ошибкой, Ansible сразу остановит плейбук. Поэтому в always лучше использовать только простые и надёжные операции.
