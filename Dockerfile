# Base từ Webtop (không cài gì thêm)
FROM lscr.io/linuxserver/webtop:latest

USER root

# Chỉ thêm ngrok (không đụng gì vào hệ thống GUI)
RUN curl -s https://ngrok-agent.s3.amazonaws.com/ngrok.asc \
 | gpg --dearmor -o /usr/share/keyrings/ngrok-archive-keyring.gpg && \
 echo "deb [signed-by=/usr/share/keyrings/ngrok-archive-keyring.gpg] \
 https://ngrok-agent.s3.amazonaws.com buster main" \
 > /etc/apt/sources.list.d/ngrok.list && \
 apt update && apt install -y ngrok && \
 mkdir -p /root/.config/ngrok

# Port của webtop (noVNC)
EXPOSE 3000

# Copy script start
COPY start.sh /start.sh
RUN chmod +x /start.sh

CMD ["/start.sh"]
