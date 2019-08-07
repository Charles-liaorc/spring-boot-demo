FROM maven:3.3-jdk-8

VOLUME /tmp

WORKDIR /code

# Prepare by downloading dependencies
ADD pom.xml /code/pom.xml  
#RUN ["mvn", "dependency:resolve"]
#RUN ["mvn", "verify"]

# Adding source, compile and package into a fat jar
ADD src /code/src
RUN ["mvn", "clean", "install"]

RUN ["ls", "/code/target"]
RUN ["pwd"]
RUN ["ls", "-ltrh", "/code/target/demo-0.0.1-SNAPSHOT.jar"]

EXPOSE 8080

ENV TZ=Asia/Shanghai
Run ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

ENTRYPOINT [ "java", "-jar", "/code/target/demo-0.0.1-SNAPSHOT.jar" ]