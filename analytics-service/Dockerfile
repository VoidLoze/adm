# ===========================================
# Этап: Запуск (Runtime Stage)
# Требуется предварительная сборка JAR локально
# ===========================================
FROM eclipse-temurin:17-jre

WORKDIR /app

# Устанавливаем curl для healthcheck
RUN apt-get update && apt-get install -y --no-install-recommends curl && rm -rf /var/lib/apt/lists/*

# Создаем пользователя для безопасности
RUN groupadd -r javauser && useradd -r -g javauser javauser

# Копируем собранный JAR
ARG JAR_FILE=target/*.jar
COPY ${JAR_FILE} app.jar

# Меняем владельца
RUN chown javauser:javauser /app/app.jar

USER javauser

# gRPC порт
EXPOSE 9090
# HTTP порт для метрик
EXPOSE 8081

ENV JAVA_OPTS="-XX:+UseContainerSupport -XX:MaxRAMPercentage=75.0"

HEALTHCHECK --interval=30s --timeout=3s --start-period=60s --retries=3 \
    CMD curl -f http://localhost:8081/actuator/health || exit 1

ENTRYPOINT ["sh", "-c", "java $JAVA_OPTS -jar app.jar"]
