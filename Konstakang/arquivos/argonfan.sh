#!/system/bin/sh
# Argon ONE V3 / Pi 5 / KonstaKANG Android 16
# Validado em 2026-11-08. Executar como serviço root do Android init.
# Sensor em milésimos de °C; barramento 1 / alvo I2C 0x1a.
# NÃO executar em paralelo com /data/local/tmp/argon-fan.sh.

TEMP_FILE="/sys/class/thermal/thermal_zone0/temp"
I2C="/vendor/bin/i2cset"
LAST_SPEED=""

while true; do
    TEMP=$(cat "$TEMP_FILE" 2>/dev/null)

    case "$TEMP" in
        ''|*[!0-9]*)
            SPEED="0x64"
            ;;
        *)
            if [ "$TEMP" -ge 65000 ]; then
                SPEED="0x64"
            elif [ "$TEMP" -ge 60000 ]; then
                SPEED="0x46"
            elif [ "$TEMP" -ge 55000 ]; then
                SPEED="0x28"
            else
                SPEED="0x14"
            fi
            ;;
    esac

    if [ "$SPEED" != "$LAST_SPEED" ]; then
        if "$I2C" -y 1 0x1a 0x80 "$SPEED" b; then
            LAST_SPEED="$SPEED"
            echo "CPU=$TEMP FAN=$SPEED" \
              > /data/local/tmp/argonfan.status
        else
            echo "ERRO I2C CPU=$TEMP" \
              > /data/local/tmp/argonfan.status
        fi
    fi

    sleep 10
done
