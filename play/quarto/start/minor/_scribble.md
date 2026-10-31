# 17435.notes
## KW43

- [https://ethnologue.com](https://ethnologue.com)
- <https://fsl-digital.de>
- <https://iso639-3.sil.org> : was ist :eine sprache:

## KW44
<https://wenker.online.uni-marburg.de/wenker>

location / {
                proxy_pass "https://127.0.0.1:7081";
                proxy_hide_header upgrade;
                proxy_ssl_server_name on;
                proxy_ssl_name $host;
                proxy_ssl_session_reuse off;
                proxy_set_header Host             $host;
                proxy_set_header X-Real-IP        $remote_addr;
                proxy_set_header X-Forwarded-For  $proxy_add_x_forwarded_for;
                proxy_set_header X-Accel-Internal /internal-nginx-static-location;