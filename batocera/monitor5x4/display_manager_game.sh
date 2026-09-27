#!/bin/bash

export DISPLAY=:0.0

TARGET_HASH="9f48548fb72095984c204928a4fa9e80"
HDMI_DRM="/sys/class/drm/card0-HDMI-A-1"
HDMI_OUTPUT="HDMI-1"

is_target_monitor() {
    [ -r "$HDMI_DRM/status" ] || return 1
    [ "$(cat "$HDMI_DRM/status")" = "connected" ] || return 1

    EDID_HASH="$(md5sum "$HDMI_DRM/edid" 2>/dev/null | awk '{print $1}')"

    [ "$EDID_HASH" = "$TARGET_HASH" ]
}

case "$1" in
    gameStart)
        if is_target_monitor; then
            xrandr \
                --output "$HDMI_OUTPUT" \
                --mode 1280x1024 \
                --rate 60.02
        fi
        ;;

    gameStop)
        if is_target_monitor; then
            xrandr \
                --output "$HDMI_OUTPUT" \
                --mode 1280x1024 \
                --rate 75.02
        fi
        ;;
esac

exit 0
