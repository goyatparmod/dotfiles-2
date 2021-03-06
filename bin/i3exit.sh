#!/usr/bin/env zsh

before_lock() {
  ~/bin/change-keyboard-layout.sh reset
  killall -u "$USER" -USR1 dunst
  killall compton
}

lock() {
  i3lock -efnc 000000
}

after_lock() {
  compton &!
  killall -u "$USER" -USR2 dunst
}

stop_vpn() {
  nmcli con show --active | grep vpn | cut -d' ' -f1 | xargs -n1 nmcli con down
}

case "$1" in
  lock)
    before_lock
    lock
    after_lock
    ;;
  logout)
    stop_vpn
    i3-msg exit
    ;;
  suspend)
    before_lock
    stop_vpn
    systemctl suspend
    lock
    after_lock
    ;;
  reboot)
    stop_vpn
    systemctl reboot
    ;;
  shutdown)
    stop_vpn
    systemctl poweroff
    ;;
  *)
    echo "Usage: $0 {lock|logout|suspend|reboot|shutdown}"
    exit 2
esac

exit 0
