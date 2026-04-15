# Gagamit tayo ng mas bagong image para sa Java 21/25 compatibility
FROM tomcat:10.1-jdk21-openjdk-slim

RUN rm -rf /usr/local/tomcat/webapps/*

# I-copy ang web folder kasama ang classes
COPY web/ /usr/local/tomcat/webapps/ROOT/

EXPOSE 8080
CMD ["catalina.sh", "run"]
