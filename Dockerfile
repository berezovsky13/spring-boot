# Step 1: Build the application with Maven
FROM maven:3.8.1-openjdk-17 AS build
WORKDIR /app
COPY . .
RUN mvn clean package -DskipTests

# Step 2: Run the application
FROM openjdk:17-jdk-slim
WORKDIR /app
COPY --from=build /app/target/spring-boot-app-0.0.1-SNAPSHOT.jar /app/spring-boot-app.jar
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "/app/spring-boot-app.jar"]
