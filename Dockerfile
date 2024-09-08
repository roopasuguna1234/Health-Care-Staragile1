FROM openjdk:11-jre-slim
COPY target/*.jar /app/app.jar
WORKDIR /app
EXPOSE 8082
CMD ["java", "-jar", "app.jar"]
