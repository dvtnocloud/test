FROM linuxserver/webtop:latest

# Cài ngrok cho Alpine (apk)
RUN apk update && apk add --no-cache curl unzip
RUN curl -s https://bin.equinox.io/c/4VmDzA7iaHb/ngrok-stable-linux-amd64.zip -o ngrok.zip && \
    unzip ngrok.zip && mv ngrok /usr/local/bin/ && rm -f ngrok.zip

# Copy script start
COPY start.sh /start.sh
RUN chmod +x /start.sh

EXPOSE 3000
CMD ["/start.sh"]
