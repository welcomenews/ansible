> **To install the latest OSS release:**

- $ sudo apt-get install -y apt-transport-https
- $ sudo apt-get install -y software-properties-common wget
- $ sudo wget -q -O /usr/share/keyrings/grafana.key https://packages.grafana.com/gpg.key

> **Add this repository for stable releases:**

- $ echo "deb [signed-by=/usr/share/keyrings/grafana.key] https://packages.grafana.com/oss/deb stable main" | sudo tee -a /etc/apt/sources.list.d/grafana.list

> **Add this repository if you want beta releases:**

- $ echo "deb [signed-by=/usr/share/keyrings/grafana.key] https://packages.grafana.com/oss/deb beta main" | sudo tee -a /etc/apt/sources.list.d/grafana.list

> **After you add the repository:**

- $ sudo apt-get update
- $ sudo apt-get install grafana


https://grafana.com/docs/grafana/next/setup-grafana/installation/debian/
