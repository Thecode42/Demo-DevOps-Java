# Etapa de construcción
FROM maven:3.9.4-eclipse-temurin-17 AS build

WORKDIR /app
COPY . .
RUN mvn clean package -DskipTests

# Etapa de creacion de imagen con JDK 17
FROM eclipse-temurin:17-jdk-alpine

RUN apk add --no-cache curl
WORKDIR /app
COPY --from=build /app/target/*.jar application.jar
EXPOSE 8000

ENTRYPOINT ["java", "-jar", "application.jar"]
