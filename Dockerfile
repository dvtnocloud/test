# ===============================
#  WEBTOP + CLOUDFLARE QUICK TUNNEL (Railway/Render)
# ===============================
FROM linuxserver/webtop:latest

USER root

# Install cloudflared (Alpine)
RUN apk update && \
    apk add --no-cache curl wget netcat-openbsd && \
    wget -O /usr/local/bin/cloudflared https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-amd64 && \
    chmod +x /usr/local/bin/cloudflared

ENV PUID=1000
ENV PGID=1000
ENV TZ=Asia/Ho_Chi_Minh

EXPOSE 3000
EXPOSE 8080

# ENTRYPOINT giữ PID1 chuẩn cho webtop, tunnel chạy nền
CMD /bin/bash -c "\
echo '🚀 Starting Webtop...' && \
/init & \
sleep 5 && \
echo '🌐 Creating Cloudflare Quick Tunnel...' && \
cloudflared tunnel --no-autoupdate --url http://localhost:3000 2>&1 | grep 'https://' & \
echo '📡 Alive service on port 8080...' && \
while :; do echo 'OK'; nc -l -p 8080; done"
