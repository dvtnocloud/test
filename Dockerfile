FROM linuxserver/webtop:latest

USER root
RUN apk update && \
    apk add --no-cache curl wget grep && \
    wget -O /usr/local/bin/cloudflared https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-amd64 && \
    chmod +x /usr/local/bin/cloudflared

# giữ container sống (Railway/Render cần port)
RUN echo -e '#!/bin/sh\nwhile true; do sleep 30; done' > /keepalive.sh && chmod +x /keepalive.sh

ENV PUID=1000
ENV PGID=1000
ENV TZ=Asia/Ho_Chi_Minh

EXPOSE 3000 8080

# ⭐ CMD: webtop chạy nền, cloudflare là PID1 -> IN RA LOG TUNNEL CHẮC CHẮN
CMD /bin/sh -c "\
/init & \
/keepalive.sh & \
sleep 3; \
echo '⏳ Đang tạo Cloudflare tunnel, chờ link...'; \
cloudflared tunnel --no-autoupdate --url http://localhost:3000 2>&1 | \
grep -m1 -Eo 'https://[a-zA-Z0-9.-]+trycloudflare.com'"
