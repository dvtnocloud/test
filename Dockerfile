FROM linuxserver/webtop:latest

USER root
RUN apk update && \
    apk add --no-cache curl wget grep && \
    wget -O /usr/local/bin/cloudflared https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-amd64 && \
    chmod +x /usr/local/bin/cloudflared

# Fake service giữ container sống
RUN echo -e '#!/bin/sh\nwhile true; do echo ok >/dev/null; sleep 30; done' > /keepalive.sh \
    && chmod +x /keepalive.sh

ENV PUID=1000
ENV PGID=1000
ENV TZ=Asia/Ho_Chi_Minh

EXPOSE 3000 8080

# CHẠY TẤT CẢ + LỌC LOG CHẮC CHẮN IN RA LINK
CMD /bin/sh -c "\
/init & \
/keepalive.sh & \
sleep 5; \
echo '🔍 Đang tạo Cloudflare Tunnel, chờ lấy link...' >&2; \
cloudflared tunnel --no-autoupdate --url http://localhost:3000 2>&1 | \
while read line; do \
    echo \"$line\" | grep -Eo 'https://[a-zA-Z0-9.-]+trycloudflare.com' && break; \
done"
