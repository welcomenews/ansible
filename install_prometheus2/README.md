```
## Выставить временной интервал в 1 мин.
rate(prometheus_http_requests_total[1m]) 

node_cpu_seconds_total{mode="iowait"}

## загрузка проца в процентах (floor округляет до целого значения)
floor(100 - (avg by (instance) (rate (node_cpu_seconds_total{mode="idle"}[1m])) * 100))

## доступно места на жёстком диске в директории /  в MB
node_filesystem_avail_bytes{mountpoint="/", device!="tmpfs"} / 1024 / 1024

## Общий размер диска
sum(node_filesystem_size_bytes) / 1024 / 1024 / 1024

## загрузка системы за последние 15 минут
node_load15

## Disk read and write
Graph old
irate(windows_logical_disk_read_bytes_total{job=~"$job",instance=~"$instance"}[5m])   Legend: read {{volume}}
irate(windows_logical_disk_write_bytes_total{job=~"$job",instance=~"$instance"}[5m])  Legend: write {{volume}}


## 
Disk IO 
Graph old
irate(windows_logical_disk_reads_total{job=~"$job",instance=~"$instance"}[5m])  Legend: read {{volume}}
irate(windows_logical_disk_writes_total{job=~"$job",instance=~"$instance"}[5m]) Legend: write {{volume}}
или linux
avg by (device) (irate(node_disk_read_bytes_total{device!="sr0", job="$job"}[5m]))      read
avg by (device) (irate(node_disk_written_bytes_total{device!="sr0", job="$job"}[5m]))   write

## Network usage 
Graph old
(irate(windows_net_bytes_total{job=~"$job",instance=~"$instance",nic!~'isatap.*|VPN.*'}[5m]) * 8 / windows_net_current_bandwidth{job=~"$job",instance=~"$instance",nic!~'isatap.*|VPN.*'}) * 100          Legend: {{nic}}

## Free disk space
Graph old
windows_logical_disk_free_bytes{job=~"$job",instance=~"$instance"}   Legend: Remaining space {{volume}}
windows_logical_disk_size_bytes{job=~"$job",instance=~"$instance"}   Legend: Total space {{volume}}

## Memory Details
Graph old
windows_cs_physical_memory_bytes{job=~"$job",instance=~"$instance"}  Legend: Total physical memory
windows_os_physical_memory_free_bytes{job=~"$job",instance=~"$instance"}  Legend: Remaining physical memory
windows_os_virtual_memory_bytes{job=~"$job",instance=~"$instance"}    Legend: Virtual memory
windows_os_virtual_memory_free_bytes{job=~"$job",instance=~"$instance"}  Legend: Free virtual memory

## Network Details
Graph old
irate(windows_net_bytes_sent_total{job=~"$job",instance=~"$instance",nic!~'isatap.*|VPN.*'}[5m])*8>0  Legend: {{nic}}-Sent-Upload
irate(windows_net_bytes_received_total{job=~"$job",instance=~"$instance",nic!~'isatap.*|VPN.*'}[5m])*8  Legend: {{nic}}-Received-Download

## Number of Processes
Graph old
windows_os_processes{job=~"$job",instance=~"$instance"}  Legend: Number of Processes
или linux
count without(cpu, mode) (node_cpu_seconds_total{mode="idle"})

## Service Status
Graph old
sum(windows_service_state{job=~"$job",instance=~"$instance"}) by (state)  Legend: {{state}}

## CPU коэффициент использования
Graph old
100 - avg(irate(windows_cpu_time_total{job=~"$job",instance=~"$instance",mode="idle"}[5m]))*100  Legend: CPU коэффиц. использования

## Details of the maximum disk IO of each host
Graph old
-max by (instance) (irate(windows_logical_disk_reads_total[2m]))  Legend: {{instance}}_Read
max by (instance) (irate(windows_logical_disk_writes_total[2m]))  Legend: {{instance}}_write

## The maximum disk read and write details of each host
Graph old
-max by (instance) (irate(windows_logical_disk_read_bytes_total[2m]))  Legend: {{instance}}_Read
max by (instance) (irate(windows_logical_disk_write_bytes_total[2m]))  Legend: {{instance}}_write

## The network details of the maximum traffic network card of each host
Graph old
max by (instance) (irate(windows_net_bytes_sent_total{job=~"$job",nic!~'isatap.*|VPN.*'}[2m]))*8  Legend: {{instance}}_Upload
-max by (instance) (irate(windows_net_bytes_received_total{job=~"$job",nic!~'isatap.*|VPN.*'}[2m]))*8  Legend: {{instance}}_download
или linux
irate(node_network_receive_bytes_total{device="enp0s3", job="$job"}[5m])*8     download
irate(node_network_transmit_bytes_total{device="enp0s3", job="$job"}[5m])*8>0  upload

## Memory usage of each host
Graph old
100.0-100 * windows_os_physical_memory_free_bytes{job=~"$job"} / windows_cs_physical_memory_bytes{job=~"$job"}  Legend: {{instance}}

## CPU usage of each host
Graph old
100-(avg by (instance) (irate(windows_cpu_time_total{job=~"$job",mode="idle"}[2m])) * 100)   Legend: {{instance}}

## Global view
Table
up

## Utilization rate of each partition
Bar gauge
100-(windows_logical_disk_free_bytes{job=~"$job",instance=~"$instance"} / windows_logical_disk_size_bytes{job=~"$job",instance=~"$instance"})*100  Legend: {{volume}}
или linux
100-(node_filesystem_avail_bytes / node_filesystem_size_bytes)*100

## Total drives
Stat
windows_logical_disk_size_bytes{job=~"$job",instance=~"$instance"}

## Memory Usage
Gauge
100-(windows_os_physical_memory_free_bytes{job=~"$job",instance=~"$instance"} / windows_cs_physical_memory_bytes{job=~"$job",instance=~"$instance"})*100
или linux
100-((node_memory_MemFree_bytes + node_memory_MemAvailable_bytes) / node_memory_MemTotal_bytes)*100

## SWAP Used
Gauge
((windows_os_virtual_memory_bytes{job=~"$job",instance=~"$instance"} - windows_os_virtual_memory_free_bytes{job=~"$job",instance=~"$instance"}) / (windows_os_virtual_memory_bytes{job=~"$job",instance=~"$instance"})) * 100

## CPU Usage
Gauge
100-(avg(irate(windows_cpu_time_total{job=~"$job",instance=~"$instance",mode="idle"}[2m])))*100
или linux
100-(avg(irate(node_cpu_seconds_total{mode="idle"}[30s])))*100

## CPU core number
Stat
windows_cs_logical_processors{job=~"$job",instance=~"$instance"}
в Linux
count without(cpu, mode) (node_cpu_seconds_total{mode="idle"})

## Startup time
Stat
time()-windows_system_system_up_time{job=~"$job",instance=~"$instance"}

## Total Memory
Stat
windows_cs_physical_memory_bytes{job=~"$job",instance=~"$instance"}
или linux
floor(node_memory_MemTotal_bytes / 1024 / 1024 / 1024)

## $job: Server Resource Overview
Table old
windows_os_info{job=~"$job"} * on(instance) group_right(product) windows_cs_hostname
time()-windows_system_system_up_time{job=~"$job"}
windows_cs_logical_processors{job=~"$job"}-0
avg by (instance) (windows_cpu_core_frequency_mhz{job=~"$job"})
100-(avg by (instance) (irate(windows_cpu_time_total{job=~"$job",mode="idle"}[2m])) * 100)
windows_cs_physical_memory_bytes{job=~"$job"}-0
100-100 * windows_os_physical_memory_free_bytes{job=~"$job"} / windows_cs_physical_memory_bytes{job=~"$job"}
1-(windows_logical_disk_free_bytes{job=~"$job",volume=~"C:"}/windows_logical_disk_size_bytes{job=~"$job",volume=~"C: "})
max by (instance) (1-windows_logical_disk_free_bytes{job=~"$job"}/windows_logical_disk_size_bytes{job=~"$job"})
windows_os_processes{job=~"$job"}
sum by (instance) (windows_service_state{job=~"$job",state=~"running"})

## system_threads
Graph old
windows_system_threads{job=~"$job",instance=~"$instance"}  Legend: system_threads

```


#### Правила.
https://awesome-prometheus-alerts.grep.to/rules.html
