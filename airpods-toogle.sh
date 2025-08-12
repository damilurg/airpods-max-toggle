#!/bin/zsh

export PATH="/opt/homebrew/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin"

DEVICE_MAC="<YOUR_BLUETOOTH_MAC>"

CONNECTED=$(/opt/homebrew/bin/blueutil --is-connected "$DEVICE_MAC")

echo "CONNECTED = $CONNECTED"

if [ "$CONNECTED" = "1" ]; then
  echo "❌ Disconnecting..."
  /opt/homebrew/bin/blueutil --disconnect "$DEVICE_MAC"
  /opt/homebrew/bin/SwitchAudioSource -s "AirPods Max"
  osascript -e 'display notification "🛑 Disconnected" with title "AirPods Max"'
elif [ "$CONNECTED" = "0" ]; then
  echo "🔌 Connecting..."
  sleep 2
  /opt/homebrew/bin/blueutil --connect "$DEVICE_MAC"
  osascript -e 'display notification "✅ Connected" with title "AirPods Max"'
else
  echo "⚠️ Unexpected response: $CONNECTED"
fi
