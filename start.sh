#!/bin/bash

# ====== NHẬN TOKEN ======
if [ -z "$NGROK_TOKEN" ]; then
  echo "⚠️  CHƯA CÓ TOKEN!"
  echo "👉 Chạy: docker run -e NGROK_TOKEN=xxxxx ..."
else
  ngrok config add-authtoken "$NGROK_TOKEN"
fi

# ====== KHỞI CHẠY WEBTOP ======
/usr/bin/start.sh &
sleep 5

# ====== MỞ NGROK WEB ======
ngrok http http://localhost:3000 --log=stdout
