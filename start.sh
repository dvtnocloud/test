#!/bin/bash

# ====== CẤU HÌNH NGROK ======
if [ -z "$NGROK_TOKEN" ]; then
  echo "⚠️  Chưa có NGROK_TOKEN! Hãy chạy khi tạo container:"
  echo "   docker run -e NGROK_TOKEN=YOUR_TOKEN ..."
  sleep 3
fi

ngrok config add-authtoken "$NGROK_TOKEN"

# ====== CHẠY WEBTOP GUI ======
echo "🚀 Khởi động Linux Webtop (GUI + noVNC)"
/usr/bin/start.sh &

sleep 5

# ====== MỞ NGROK ======
echo "🌍 Đang mở Ngrok public..."
ngrok http http://localhost:3000 --log=stdout
