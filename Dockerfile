# Stage 1: Build the Spring Boot application
FROM maven:3.8.1-openjdk-17 AS build
WORKDIR /app
COPY . .
RUN mvn clean package -DskipTests

# Stage 2: Run the Spring Boot application
FROM openjdk:17-jdk-slim
WORKDIR /app
COPY --from=build /app/target/hello-daniel-0.0.1-SNAPSHOT.jar /app/hello-daniel.jar
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "/app/hello-daniel.jar"]
