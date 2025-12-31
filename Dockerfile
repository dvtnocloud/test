# ===============================
#  WEBTOP + CLOUDFLARE QUICK TUNNEL
#  RAILWAY DEPLOY 1 FILE
# ===============================
FROM linuxserver/webtop:latest

USER root

# Install cloudflared & tools (Alpine uses apk, NOT apt)
RUN apk update && \
    apk add --no-cache curl wget && \
    wget -O /usr/local/bin/cloudflared https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-amd64 && \
    chmod +x /usr/local/bin/cloudflared

# Env for Webtop
ENV PUID=1000
ENV PGID=1000
ENV TZ=Asia/Ho_Chi_Minh

# Port expose
EXPOSE 3000

# CMD start webtop and auto cloudflare tunnel
CMD /bin/bash -c "\
echo '🚀 Starting Webtop...' && \
/init & \
sleep 5 && \
echo '🌐 Creating Cloudflare Quick Tunnel (NO ACCOUNT REQUIRED)...' && \
cloudflared tunnel --no-autoupdate --url http://localhost:3000"
