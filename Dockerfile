#define base Docker image
FROM openjdk:17
LABEL maintainer="M B"
ADD /target/ksfinalb-0.0.1-SNAPSHOT.jar ksfinalb.jar
ENTRYPOINT ["java","-jar","ksfinalb.jar"]
