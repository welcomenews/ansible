---

http://84.201.156.172:5601/app/discover#/

Проверка elastic index

Добавляем index
- curl -XPOST -k --user elastic:'relQHu64lxX+ILNZRoU9' -H "Content-Type: application/json" 'http://localhost:9200/tutorial/_doc/' -d '{ "message": "Hello World!" }'

Сторим таблицу индексов
- curl XGET -k --user elastic:'relQHu64lxX+ILNZRoU9' 'localhost:9200/_cat/indices?v'

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


