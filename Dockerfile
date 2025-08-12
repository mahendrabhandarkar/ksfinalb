#define base Docker image
# postman build -t ksfinalb:latest . 
# postman run -p 9091:8080 ksfinalb:latest
FROM openjdk:17
LABEL maintainer="M B"
ADD /target/ksfinalb-0.0.1-SNAPSHOT.jar ksfinalb.jar
ENTRYPOINT ["java","-jar","ksfinalb.jar"]
