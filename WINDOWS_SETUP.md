# Инструкция по запуску проекта на Windows

## Требования

1. **Docker Desktop для Windows**
   - Скачайте и установите с официального сайта: https://www.docker.com/products/docker-desktop
   - Убедитесь, что Docker Desktop запущен перед началом работы

2. **Java 17 JDK** (опционально, если хотите собирать локально)
   - Скачайте с https://adoptium.net/
   - Или используйте Maven Wrapper (mvnw), который уже включен в проект

3. **Git** (опционально, для клонирования репозитория)

## Быстрый старт

### Вариант 1: Автоматическая сборка и запуск (рекомендуется)

1. Откройте командную строку (CMD) или PowerShell в корне проекта

2. Запустите сборку всех сервисов:
   ```cmd
   build.bat
   ```
   Это займет несколько минут при первом запуске.

3. После успешной сборки запустите все сервисы:
   ```cmd
   start.bat
   ```

### Вариант 2: Ручной запуск через Docker Compose

1. Соберите все JAR файлы (если еще не собраны):
   ```cmd
   build.bat
   ```

2. Запустите через Docker Compose:
   ```cmd
   docker-compose up --build
   ```

   Или в фоновом режиме:
   ```cmd
   docker-compose up -d
   ```

## Проверка работы сервисов

После запуска проверьте доступность сервисов:

- **Demo REST API**: http://localhost:8084
- **Swagger UI**: http://localhost:8084/swagger-ui.html
- **Analytics Service**: http://localhost:8081/actuator/health
- **Audit Service**: http://localhost:8082/actuator/health
- **Notification WebSocket**: http://localhost:8083
- **RabbitMQ Management**: http://localhost:15672 (логин: guest, пароль: guest)
- **Zipkin Tracing**: http://localhost:9411
- **Prometheus**: http://localhost:9090
- **Grafana**: http://localhost:3000 (логин: admin, пароль: admin)
- **Jenkins**: http://localhost:8085

## Остановка сервисов

```cmd
docker-compose down
```

Или используйте скрипт:
```cmd
stop.bat
```

## Решение проблем

### Порт 8080 занят
Если порт 8080 занят другим приложением (например, VPN туннелем), проект автоматически использует порт 8084 для demo-rest сервиса.

### Docker не запускается
- Убедитесь, что Docker Desktop запущен
- Проверьте, что виртуализация включена в BIOS/UEFI
- Перезапустите Docker Desktop

### Ошибки при сборке
- Убедитесь, что все порты свободны
- Проверьте, что Docker Desktop имеет достаточно ресурсов (минимум 4GB RAM)
- Попробуйте очистить Docker кэш: `docker system prune -a`

### Проблемы с путями в Windows
Все пути в `docker-compose.yml` используют относительные пути (`./`), что должно работать на Windows. Если возникают проблемы:
- Используйте PowerShell вместо CMD
- Убедитесь, что вы находитесь в корне проекта

## Структура проекта

```
AdmZachet/
├── analytics-service/     # gRPC сервис аналитики
├── audit-service/         # Сервис аудита
├── demo-rest/            # Основной REST API сервис
├── ws/                   # WebSocket сервис уведомлений
├── events-contract/      # Общие события
├── books-api-contract/   # API контракты
├── docker-compose.yml   # Конфигурация Docker Compose
├── prometheus.yml        # Конфигурация Prometheus
├── build.bat            # Скрипт сборки для Windows
├── start.bat            # Скрипт запуска для Windows
└── stop.bat             # Скрипт остановки для Windows
```

## Дополнительная информация

- Все сервисы используют Java 17
- Метрики доступны через Prometheus на всех сервисах
- Трассировка настроена через Zipkin
- Все сервисы автоматически переподключаются к RabbitMQ при сбоях

## Поддержка

При возникновении проблем проверьте логи:
```cmd
docker-compose logs [service-name]
```

Например:
```cmd
docker-compose logs audit-service
docker-compose logs demo-rest
```

