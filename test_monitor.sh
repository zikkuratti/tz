#!/bin/bash

# Параметры
PROCESS_NAME="test"
LOG_FILE="/var/log/monitoring.log"
MONITORING_URL="https://test.com/monitoring/test/api"

# Проверка, запущен ли процесс
pid=$(pgrep -x $PROCESS_NAME)

# Если процесс не запущен, ничего не делаем
if [[ -z "$pid" ]]; then
  exit 0
fi

# Если процесс запущен, стучимся на сервер
response=$(curl -s -o /dev/null -w "%{http_code}" $MONITORING_URL)

if [[ "$response" -ne 200 ]]; then
  echo "$(date '+%Y-%m-%d %H:%M:%S') - Monitoring server unavailable: $MONITORING_URL (HTTP $response)" >> $LOG_FILE
fi

# Проверка перезапуска процесса
PREV_PID_FILE="/var/run/test_monitor.pid"
if [[ -f $PREV_PID_FILE ]]; then
  prev_pid=$(cat $PREV_PID_FILE)
  if [[ "$pid" -ne "$prev_pid" ]]; then
    echo "$(date '+%Y-%m-%d %H:%M:%S') - Process '$PROCESS_NAME' restarted (old PID: $prev_pid, new PID: $pid)" >> $LOG_FILE
  fi
fi

# Сохраняем текущий PID
echo "$pid" > $PREV_PID_FILE
