listen {
  port = 4040
  address = "0.0.0.0"
}

namespace "api_srwx_nginxlog" {
  format = "$remote_addr - $remote_user [$time_local] \"$request\" $status $body_bytes_sent \"$http_referer\" \"$http_user_agent\" \"$http_x_forwarded_for\" $upstream_response_time $request_time"
  source_files = ["/var/log/nginx/api.srwx.net.access.log"]
  labels {
    host = "api.srwx.net"
    node = "{{ ansible_fqdn }}"
    cluster = "brand"
  }
}

namespace "test_api_srwx_nginxlog" {
  format = "$remote_addr - $remote_user [$time_local] \"$request\" $status $body_bytes_sent \"$http_referer\" \"$http_user_agent\" \"$http_x_forwarded_for\" $upstream_response_time $request_time"
  source_files = ["/var/log/nginx/test.api.srwx.net.access.log"]
  labels {
    host = "test.api.srwx.net"
    node = "{{ ansible_fqdn }}"
    cluster = "brand"
  }
}
