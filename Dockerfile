# ===============================
#  WEBTOP + CLOUDFLARE QUICK TUNNEL
#  ONE FILE FOR RAILWAY DEPLOYMENT
# ===============================
FROM linuxserver/webtop:latest

# Fix user
USER root

# Install cloudflared
RUN apt update && apt install -y curl wget cloudflared && \
    rm -rf /var/lib/apt/lists/*

# Env for Webtop
ENV PUID=1000
ENV PGID=1000
ENV TZ=Asia/Ho_Chi_Minh

# Expose for local (Railway sẽ map)
EXPOSE 3000

# Start script → run Webtop + Tunnel
CMD /bin/bash -c "\
echo '🚀 Starting Webtop...' && \
/init & \
sleep 5 && \
echo '🌐 Creating Cloudflare Quick Tunnel (No Account Needed)...' && \
cloudflared tunnel --no-autoupdate --url http://localhost:3000"
