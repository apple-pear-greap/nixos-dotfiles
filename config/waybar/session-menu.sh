#!/bin/sh
set -e

# Enhanced session menu using fuzzel with Nerd Font icons
choice=$(printf "%s\n" \
  " 锁屏" \
  " 挂起" \
  " 休眠" \
  " 关机" \
  " 重启" \
  | fuzzel -d -p " 会话 " -w 30 -l 5) || exit 0

lock_cmd="swaylock -f -c 1e1e2e --ring-color 89b4fa --key-hl-color cba6f7 --text-color cdd6f4"

case "$choice" in
  " 锁屏")
    exec $lock_cmd
    ;;
  " 挂起")
    $lock_cmd && systemctl suspend
    ;;
  " 休眠")
    $lock_cmd && systemctl hibernate
    ;;
  " 关机")
    systemctl poweroff
    ;;
  " 重启")
    systemctl reboot
    ;;
  *)
    exit 0
    ;;
esac
