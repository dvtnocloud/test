FROM lscr.io/linuxserver/webtop:ubuntu-xfce

# Cài đặt ngrok + browser + âm thanh + clipboard
USER root
RUN apt update && apt install -y \
    curl wget nano pulseaudio firefox-esr xclip && \
    curl -s https://ngrok-agent.s3.amazonaws.com/ngrok.asc | gpg --dearmor -o /usr/share/keyrings/ngrok-archive-keyring.gpg && \
    echo "deb [signed-by=/usr/share/keyrings/ngrok-archive-keyring.gpg] https://ngrok-agent.s3.amazonaws.com buster main" > /etc/apt/sources.list.d/ngrok.list && \
    apt update && apt install -y ngrok

# Tự tạo thư mục ngrok config
RUN mkdir -p /root/.config/ngrok

# Mặc định mở cổng noVNC 3000
ENV WEBTOP_PORT=3000
EXPOSE 3000

# Chạy script khi container start
COPY start.sh /start.sh
RUN chmod +x /start.sh

CMD ["/start.sh"]
