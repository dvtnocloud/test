FROM linuxserver/webtop:latest

# Cài ngrok
RUN apt update && apt install -y curl && \
    curl -s https://ngrok-agent.s3.amazonaws.com/ngrok.asc | \
    tee /etc/apt/trusted.gpg.d/ngrok.asc >/dev/null && \
    echo "deb https://ngrok-agent.s3.amazonaws.com buster main" | tee /etc/apt/sources.list.d/ngrok.list && \
    apt update && apt install -y ngrok

# Copy script start
COPY start.sh /start.sh
RUN chmod +x /start.sh

# Railway cần expose cổng chính
EXPOSE 3000

CMD ["/start.sh"]
