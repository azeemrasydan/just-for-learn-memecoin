# Stage 1: Build and Test the application
FROM gradle:8.14-jdk-lts-and-current AS builder

WORKDIR /app

# Copy only build files first to leverage Docker cache
COPY build.gradle settings.gradle /app/
COPY gradle /app/gradle

# Pre-fetch dependencies
RUN gradle dependencies

# Copy the full source code
COPY . /app/

# Run unit tests
RUN gradle test --no-daemon

# Build the application JAR
RUN gradle bootJar --no-daemon

# Stage 2: Run the application
FROM eclipse-temurin:21-jre-alpine

VOLUME /tmp
WORKDIR /app

# Copy the built JAR from the builder stage
COPY --from=builder /app/build/libs/*.jar app.jar

# Run the Spring Boot application
ENTRYPOINT ["java", "-jar", "/app/app.jar"]
