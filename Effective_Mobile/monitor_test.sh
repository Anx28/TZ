#!/bin/bash
# Переменные
PROCESS_NAME="test"
LOG_FILE="/var/log/monitoring.log"
URL="https://test.com/monitoring/test/api"

# Проверяем, запущен ли процесс
if pgrep -x "$PROCESS_NAME" > /dev/null; then
    # Пингуем сервер мониторинга
    if curl -s --connect-timeout 5 -o /dev/null "$URL"; then
        echo "$(date) - Мониторинг: Процесс $PROCESS_NAME работает, сервер мониторинга доступен" >> "$LOG_FILE"
    else
        echo "$(date) - Ошибка: Сервер мониторинга недоступен ($URL)" >> "$LOG_FILE"
    fi

    # Проверяем, был ли процесс перезапущен и записываем пид
    if [ -f "/tmp/${PROCESS_NAME}_pid" ]; then
        OLD_PID=$(cat "/tmp/${PROCESS_NAME}_pid")
        CURRENT_PID=$(pgrep -x "$PROCESS_NAME")
        if [ "$OLD_PID" != "$CURRENT_PID" ]; then
            echo "$(date) - Процесс $PROCESS_NAME был перезапущен (PID изменился: $OLD_PID -> $CURRENT_PID)" >> "$LOG_FILE"
        fi
    fi

    # Запоминаем текущий PID
    pgrep -x "$PROCESS_NAME" > "/tmp/${PROCESS_NAME}_pid"
fi
