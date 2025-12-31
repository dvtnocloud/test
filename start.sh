#!/bin/sh

echo "===== 🚀 Khởi chạy Linux Webtop trên Railway ====="

if [ -n "$NGROK_AUTHTOKEN" ]; then
  ngrok config add-authtoken $NGROK_AUTHTOKEN
  echo "🔑 Đã cấu hình Ngrok token"
else
  echo "⚠️  CHƯA CÓ NGROK_AUTHTOKEN - thêm trong Railway Variables!"
fi

# Chạy ngrok nền, region ap (Asia)
ngrok http 3000 --region=ap > /ngrok.log 2>&1 &

sleep 3
echo "🌐 LINK TRUY CẬP NGROK:"
grep -o "https://[a-zA-Z0-9.-]*\.ngrok-free\.app" /ngrok.log || echo "⏳ Đang tạo link, chờ thêm 5-10s..."

echo "💻 Khởi chạy Webtop..."
/init
