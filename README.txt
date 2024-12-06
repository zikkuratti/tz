Попросили папу кашу есть)

Распространить файлы по системе:
Скрипт мониторинга (/usr/local/bin/test_monitor.sh
Unit-файл systemd (/etc/systemd/system/test-monitor.service)
Таймер для запуска каждую минуту (/etc/systemd/system/test-monitor.timer)

Команды для настройки

Сделать скрипт исполняемым:
chmod +x /usr/local/bin/test_monitor.sh

Настроить права на лог:
touch /var/log/monitoring.log
chmod 644 /var/log/monitoring.log

Перезагрузить systemd:
systemctl daemon-reload

Включить таймер:
systemctl enable --now test-monitor.timer
