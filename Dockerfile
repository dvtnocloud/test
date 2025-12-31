# ===============================
#  WEBTOP + CLOUDFLARE QUICK TUNNEL
#  Railway / Render / Fly.io / Docker
# ===============================
FROM linuxserver/webtop:latest

USER root

# Install cloudflared + tools (Alpine base)
RUN apk update && \
    apk add --no-cache curl wget netcat-openbsd bash && \
    wget -O /usr/local/bin/cloudflared https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-amd64 && \
    chmod +x /usr/local/bin/cloudflared

# ENV for Webtop
ENV PUID=1000
ENV PGID=1000
ENV TZ=Asia/Ho_Chi_Minh

# Expose ports: Webtop UI + Keepalive service
EXPOSE 3000
EXPOSE 8080

# ===============================
# STARTUP COMMAND
# ===============================
CMD /bin/bash -c "\
echo '--------------------------------------------------'; \
echo '🚀 Starting Webtop Desktop...'; \
echo '--------------------------------------------------'; \
/init & \
sleep 5 && \
echo ''; \
echo '🌐 Creating Cloudflare Quick Tunnel...'; \
cloudflared tunnel --no-autoupdate --url http://localhost:3000 2>&1 | grep -m1 'trycloudflare\\.com' & \
echo ''; \
echo '📡 Keepalive Service Running on :8080 (for Railway/Render)'; \
while :; do echo OK | nc -l -p 8080; done"
