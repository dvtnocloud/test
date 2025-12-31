#!/bin/bash

echo "===== 🚀 Khởi chạy Linux Webtop trên Railway ====="

# login ngrok nếu có token
if [ -n "$NGROK_AUTHTOKEN" ]; then
  ngrok config add-authtoken $NGROK_AUTHTOKEN
  echo "🔑 Đã cấu hình Ngrok token"
else
  echo "⚠️  CHƯA CÓ NGROK_AUTHTOKEN - hãy thêm trong Railway Variables!"
fi

# chạy ngrok nền
ngrok http 3000 --region=ap > /ngrok.log 2>&1 &

echo "🌐 Đang tạo link Ngrok..."
sleep 3
grep -o "https://[a-zA-Z0-9.-]*\.ngrok-free\.app" /ngrok.log

echo "💻 Khởi động Webtop..."
/init
