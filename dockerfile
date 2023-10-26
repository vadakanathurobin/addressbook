# Stage 1: Build stage
From tomcat:8.5.72-jdk8-openjdk-buster

WORKDIR /app

RUN     apt-get update && \
        apt-get install -y curl && \
        curl -fsSL https://archive.apache.org/dist/maven/maven-3/$MAVEN_VERSION/binaries/apache-maven-$MAVEN_VERSION-bin.tar.gz | tar xzf - -C /usr/share && \
        mv usr/share/apache-maven-$MAVEN_VERSION /usr/share/maven && \
        ln -s /usr/share/maven/bin/mvn /usr/bin/mvn && \
        apt-get clearn && \
        rm -rf /var/lib/apt/lists/*

copy ./pom.xml ./pom.xml
copy ./src ./src

Run mvn package

Run rm -rf /usr/local/tomacat/webapps/*

Run cp /app/target/addressbook.war /usr/local/tomcat/webapps

expose 8080

cmd ["catalina.sh","run"]

