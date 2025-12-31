FROM ubuntu:22.04

# Cài đặt curl
RUN apt update && apt install -y curl

# Chạy sshx khi container start
CMD ["sh", "-c", "curl -sSf https://sshx.io/get | sh -s run"]
