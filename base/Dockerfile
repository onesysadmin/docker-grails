FROM tutum/tomcat:8.0

# Java JDK 7 already installed

# Set default Grails Java Runtime env
ENV JAVA_OPTS -Xmx512m -XX:MaxPermSize=256m -Djetty.serverHost=0.0.0.0

RUN mkdir /app
WORKDIR /app

# install curl so we can install gvm
RUN apt-get update && \
    apt-get install -yqq --no-install-recommends curl unzip && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# install gvm
RUN curl -s get.gvmtool.net | bash
ADD gvm.config /.gvm/etc/config
