---

http://84.201.156.172:5601/app/discover#/

Проверка elastic index

# Если используем ssl 
Добавляем index
- curl -XPOST -k --user elastic:'relQHu64lxX+ILNZRoU9' -H "Content-Type: application/json" 'http://localhost:9200/tutorial/_doc/' -d '{ "message": "Hello World!" }'

Сторим таблицу индексов
- curl XGET -k --user elastic:'relQHu64lxX+ILNZRoU9' 'localhost:9200/_cat/indices?v'


# Если НЕ используем ssl 
Добавляем index
- curl -XPOST -H "Content-Type: application/json" 'http://localhost:9200/tutorial/_doc/' -d '{ "message": "Hello World!" }'

Сторим таблицу индексов
curl -X GET 'http://localhost:9200'

```
sudo /usr/share/elasticsearch/bin/elasticsearch-reset-password -u elastic
ответ 
Password for the [elastic] user successfully reset.
New value: relQHu64lxX+ILNZRoU9

sudo /usr/share/elasticsearch/bin/elasticsearch-create-enrollment-token -s kibana
ответ
eyJ2ZXIiOiI4LjExLjAiLCJhZHIiOlsiMTAuMTI4LjAuMjM6OTIwMCJdLCJmZ3IiOiIwNDhkNzE2ZGExYWJkMTg4YzlmNGU1YzVhMzYxMGZjMTVmMzJjYzlkNTgzMTRjYWUzOTE3ZGFmMmYyZmFkNWJkIiwia2V5IjoiT0J4XzU0c0JESDh1WkxrVmR6eFY6UGVTTUxpRjVRNnloNGZzNGxLWThnZyJ9

sudo /usr/share/elasticsearch/bin/elasticsearch-reset-password -u kibana_system
ответ
Password for the [kibana_system] user successfully reset.
New value: d4k6cg4Ul5+W8O-_Yj*N
```

### Проверить конфигурацию Logstash можно командой:
```
sudo /usr/share/logstash/bin/logstash --path.settings /etc/logstash -t
Мы должны увидеть:
...
Configuration OK
```
https://www.dmosk.ru/instruktions.php?object=elk-ubuntu#logstash

### Смотреть журнал например filebeat

journalctl -u filebeat.service

### Filebeat quick start: installation and configuration

https://www.elastic.co/guide/en/beats/filebeat/current/filebeat-installation-configuration.html

### Загрузить GeoLite2-City.mmdb можно (но из-за санкций может не получится):

https://dev.maxmind.com/geoip/geolite2-free-geolocation-data#Download_Access

### Установку и настройку можно посмотреть тут:

https://www.dmosk.ru/instruktions.php?object=elk-ubuntu#logstash

https://serveradmin.ru/ustanovka-i-nastroyka-elasticsearch-logstash-kibana-elk-stack/#Proksirovanie_podklucenij_k_Kibana_cerez_Nginx

