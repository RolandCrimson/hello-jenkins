FROM maven:3.9.7-amazoncorretto-21-debian-bookworm AS builder

WORKDIR /usr/src/hello
COPY pom.xml .
RUN mvn -B dependency:go-offline

COPY . .
RUN mvn package -DskipTests

# app
FROM amazoncorretto:21.0.3

WORKDIR /app
COPY --from=builder /usr/src/hello/target/jenkinsProject-0.0.1.jar .

ENTRYPOINT ["java", "-jar", "/app/jenkinsProject-0.0.1.jar"]