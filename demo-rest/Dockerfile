# ===========================================
# Этап: Запуск (Runtime Stage)
# Требуется предварительная сборка JAR локально
# ===========================================
FROM eclipse-temurin:17-jre

WORKDIR /app

# Устанавливаем curl для healthcheck
RUN apt-get update && apt-get install -y --no-install-recommends curl && rm -rf /var/lib/apt/lists/*

# Создаем пользователя для безопасности (не запускаем от root)
RUN groupadd -r javauser && useradd -r -g javauser javauser

# Копируем собранный JAR
ARG JAR_FILE=target/*.jar
COPY ${JAR_FILE} app.jar

# Меняем владельца файла
RUN chown javauser:javauser /app/app.jar

# Переключаемся на непривилегированного пользователя
USER javauser

# Документируем порт
EXPOSE 8080

# Настройки JVM для контейнера
ENV JAVA_OPTS="-XX:+UseContainerSupport -XX:MaxRAMPercentage=75.0"

# Health check
HEALTHCHECK --interval=30s --timeout=3s --start-period=60s --retries=3 \
    CMD curl -f http://localhost:8080/actuator/health || exit 1

# Запускаем приложение
ENTRYPOINT ["sh", "-c", "java $JAVA_OPTS -jar app.jar"]
