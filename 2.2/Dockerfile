FROM onesysadmin/tomcat8-gvm

ENTRYPOINT ["gvm-exec.sh", "grails"]

# install 2.2.4 as 2.2.5 contains missing dependencies
RUN gvm-wrapper.sh install grails 2.2.4 && gvm-wrapper.sh flush archives && gvm-exec.sh grails help
