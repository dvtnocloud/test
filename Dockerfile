# ===============================
#  WEBTOP + CLOUDFLARE QUICK TUNNEL
#  RAILWAY DEPLOY 1 FILE
# ===============================
FROM linuxserver/webtop:latest

USER root

# Install cloudflared (Alpine uses apk)
RUN apk update && \
    apk add --no-cache curl wget && \
    wget -O /usr/local/bin/cloudflared https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-amd64 && \
    chmod +x /usr/local/bin/cloudflared

# Env for Webtop
ENV PUID=1000
ENV PGID=1000
ENV TZ=Asia/Ho_Chi_Minh

# Expose ports: Webtop UI & giữ container sống
EXPOSE 3000
EXPOSE 8080

# CMD start webtop + tunnel + web service ảo
CMD /bin/bash -c "\
echo '🚀 Starting Webtop...' && \
/init & \
sleep 5 && \
echo '🌐 Creating Cloudflare Quick Tunnel...' && \
cloudflared tunnel --no-autoupdate --url http://localhost:3000 2>&1 | grep --line-buffered 'https' & \
echo '📡 Starting virtual web service on port 8080 to keep container alive...' && \
while true; do echo 'OK - Webtop alive' | nc -l -p 8080; done"
