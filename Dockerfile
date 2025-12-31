# ==========================================
#     🚀 WEBTOP + CLOUDFLARE QUICK TUNNEL
#           ✨ VPS ON RAILWAY ✨
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

CMD ["bash","-c","\
echo ''; \
echo '🖥️  WEBTOP ĐANG KHỞI ĐỘNG...'; \
/init & sleep 5; \
echo ''; \
echo '🌐 TẠO CLOUDFLARE TUNNEL...'; \
cloudflared tunnel --no-autoupdate --url http://localhost:3000 2>&1 | tee /tmp/cf.log & \
sleep 8; \
LINK=$(grep -o 'https://.*trycloudflare.com' /tmp/cf.log | head -n1); \
echo ''; \
echo '=========================================='; \
echo '🔗  LINK TRUY CẬP VNC/WEBTOP:'; \
echo \"👉  $LINK\"; \
echo '=========================================='; \
echo ''; \
while true; do echo OK | nc -l -p 8080; done"]
