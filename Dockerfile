FROM maven:3.9.11-eclipse-temurin-17 AS build
WORKDIR /app
ADD https://trialyb96rj.jfrog.io/artifactory/newrepo-libs-release-local/spring-petclinic-3.5.0-SNAPSHOT.jar /app/spring-petclinic.jar

FROM eclipse-temurin:17-jre-alpine AS run
WORKDIR /app
COPY --from=build /app/spring-petclinic.jar /app/spring-petclinic.jar
EXPOSE 8080
CMD ["java", "-jar", "/app/spring-petclinic.jar"]
