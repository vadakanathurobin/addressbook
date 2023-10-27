# Stage 1 : Build stage
From maven:3.8.4-openjdk-11-slim as build-stage

WORKDIR /app

copy ./pom.xml ./pom.xml
copy ./src ./src

Run mvn package

# Stage 2 : Production Stage

From tomcat:8.5.78-jdk11-openjdk-slim

copy --from=build-stage /app/target/*.war /user/local/tomcat/webapps/

expose 8080

cmd ["catalina.sh","run"]

