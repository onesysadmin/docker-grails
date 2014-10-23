FROM onesysadmin/gvm

RUN mkdir /app
WORKDIR /app

CMD ["grails"]

# Set default Grails Java Runtime env
ENV JAVA_OPTS -Xms256m -Xmx512m -XX:MaxPermSize=256m -Djetty.serverHost=0.0.0.0

# install 2.2.4 as 2.2.5 contains missing dependencies
RUN gvm-wrapper.sh install grails 2.2.4 && gvm-wrapper.sh flush archives && gvm-exec.sh grails help
