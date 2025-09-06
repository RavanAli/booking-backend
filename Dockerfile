FROM maven:3.9.4-eclipse-temurin-17 AS build

WORKDIR /workspace
COPY pom.xml .
RUN mvn dependency:go-offline -B

COPY src ./src
RUN mvn clean package -DskipTests -B

FROM eclipse-temurin:17-jre

WORKDIR /app

COPY --from=build /workspace/target/*.jar ./app.jar

EXPOSE 8080

ENTRYPOINT ["java","-jar","app.jar"]
