# Stage 1: Build the application
FROM gradle:8.7.0-jdk21 AS builder

WORKDIR /app

# Copy build files and dependencies first to cache layer
COPY build.gradle settings.gradle /app/
COPY gradle /app/gradle

# Run dependency resolution separately for caching
RUN gradle dependencies

# Copy the rest of the source code
COPY . /app/

# Build the application
RUN gradle bootJar --no-daemon

# Stage 2: Run the application
FROM eclipse-temurin:21-jre-alpine

VOLUME /tmp
WORKDIR /app

# Copy built JAR from builder
COPY --from=builder /app/build/libs/*.jar app.jar

# Run the Spring Boot application
ENTRYPOINT ["java", "-jar", "/app/app.jar"]
