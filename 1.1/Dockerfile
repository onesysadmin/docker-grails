FROM onesysadmin/tomcat8-gvm

ENTRYPOINT ["gvm-exec.sh", "grails"]

# install newest version of grails 1.1.x
RUN gvm-wrapper.sh install grails 1.1.2 && gvm-wrapper.sh flush archives && gvm-exec.sh grails help
