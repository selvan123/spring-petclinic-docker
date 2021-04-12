FROM maven:3.6.3-jdk-8 AS build-env 
WORKDIR /app 
COPY pom.xml ./ 
RUN mvn dependency:go-offline 
RUN mvn spring-javaformat:help 
COPY . ./ 
RUN mvn spring-javaformat:apply 
RUN mvn package 
FROM openjdk:8-jre-alpine 
EXPOSE 8080 
WORKDIR /app 
COPY --from=build-env /app/target/spring-petclinic-2.4.2.jar ./spring-petclinic-2.4.2.jar
CMD ["/usr/bin/java", "-jar", "/app/spring-petclinic-2.4.2.jar"] 
