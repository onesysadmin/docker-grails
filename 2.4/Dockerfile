FROM onesysadmin/gvm

RUN mkdir /app
WORKDIR /app
CMD ["grails"]

# Set default Grails Java Runtime env
ENV JAVA_OPTS -Xms256m -Xmx512m -XX:MaxPermSize=256m -Djetty.serverHost=0.0.0.0

ADD settings.groovy /root/.grails/settings.groovy

# install newest version of the 2.4.x branch
RUN gvm-wrapper.sh install grails 2.4.5 && gvm-wrapper.sh flush archives && gvm-exec.sh grails help
