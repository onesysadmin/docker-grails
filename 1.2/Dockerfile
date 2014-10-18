FROM onesysadmin/tomcat8-gvm

ENTRYPOINT ["gvm-exec.sh", "grails"]

# install newest version of grails 1.2.x
RUN gvm-wrapper.sh install grails 1.2.5 && gvm-wrapper.sh flush archives && gvm-exec.sh grails help
