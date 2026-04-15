FROM tomcat:9.0-jdk17-openjdk-slim
RUN rm -rf /usr/local/tomcat/webapps/*
COPY web/ /usr/local/tomcat/webapps/ROOT/
EXPOSE 8080
CMD ["catalina.sh", "run"]