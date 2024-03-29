FROM ubuntu:22.04

ENV JAVA_HOME=/usr/lib/jvm/java-1.11.0-openjdk-amd64
ENV GRADLE_HOME=/opt/gradle
ENV GRADLE_VERSION=8.7

RUN apt-get update && \
    apt-get -qq -y install curl wget unzip zip && \
    apt-get install -y default-jdk default-jre && \
    apt-get install -y cl-sql-sqlite3 sqlitebrowser
RUN wget https://services.gradle.org/distributions/gradle-${GRADLE_VERSION}-bin.zip -P /tmp && \
    unzip -d /opt/gradle /tmp/gradle-${GRADLE_VERSION}-bin.zip && \
    ln -s /opt/gradle/gradle-${GRADLE_VERSION} /opt/gradle/latest
RUN apt-get install -y kotlin

ENV PATH=$PATH:$JAVA_HOME/bin:$GRADLE_HOME/gradle-${GRADLE_VERSION}/bin

RUN mkdir /app
COPY . /app

WORKDIR /app

CMD [ "gradle clean && gradle build --scan" ]
