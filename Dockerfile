# FROM maven:3.9.11-eclipse-temurin-17 AS build
# WORKDIR /app
# ADD https://trialyb96rj.jfrog.io/artifactory/newrepo-libs-release-local/spring-petclinic-3.5.0-SNAPSHOT.jar /app/spring-petclinic.jar

# FROM eclipse-temurin:17-jre-alpine AS run
# WORKDIR /app
# COPY --from=build /app/spring-petclinic.jar /app/spring-petclinic.jar
# EXPOSE 8080
# CMD ["java", "-jar", "/app/spring-petclinic.jar"]


FROM maven:3.9.11-ibm-semeru-17-noble AS build
RUN git clone git@github.com:21a31a4351/spring-petclinic.git && \
    cd spring-petclinic &&  ./mvnw package
FROM openjdk:26-trixie AS runtime
RUN adduser -m -d /usr/share/demo -s /bin/bash testuser
USER testuser
WORKDIR /usr/share/demo
copy --from=build /spring-petclinic/target/spring-petclinic.jar  kishore .jar
EXPOSE 8080/tcp
CMD ["java","-jar","kishore.jar"]