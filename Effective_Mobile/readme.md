### Установка и запуск:
```
# Делаем скрипт исполняемым
sudo chmod +x /usr/local/bin/monitor_test.sh

# Добавляем юниты и обновляем Systemd
sudo systemctl daemon-reload

# Включаем и запускаем таймер
sudo systemctl enable monitor_test.timer
sudo systemctl start monitor_test.timer

# Проверяем работу
systemctl status monitor_test.timer
```
