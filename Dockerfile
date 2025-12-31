# ==========================================
#  WEBTOP + CLOUDFLARE QUICK TUNNEL (FIXED)
#  Railway / Render / Fly.io Compatible
# ==========================================
FROM linuxserver/webtop:latest
USER root

RUN apk update && \
    apk add --no-cache curl wget netcat-openbsd bash && \
    wget -O /usr/local/bin/cloudflared https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-amd64 && \
    chmod +x /usr/local/bin/cloudflared

ENV PUID=1000
ENV PGID=1000
ENV TZ=Asia/Ho_Chi_Minh

EXPOSE 3000
EXPOSE 8080

CMD /bin/bash -c "\
echo '🚀 Starting Webtop...' ; \
echo '----------------------------------------' ; \
/init & \
sleep 5 ; \
echo '🌐 Starting Cloudflare Tunnel...' ; \
# chạy tunnel không lọc đầu ra sớm
cloudflared tunnel --no-autoupdate --url http://localhost:3000 2>&1 | tee /tmp/cf.log & \
sleep 8 ; \
# in đúng link nếu nó xuất hiện trong log
LINK=\$(grep -o 'https://.*trycloudflare.com' /tmp/cf.log | head -n1) ; \
echo '----------------------------------------' ; \
echo '🔗 TUNNEL LINK:' ; \
echo \"\$LINK\" ; \
echo '----------------------------------------' ; \
# keepalive để Railway không tắt
while true; do echo OK | nc -l -p 8080 ; done"
