FROM onesysadmin/tomcat8-gvm

ENTRYPOINT ["gvm-exec.sh", "grails"]

# install newest version of the 2.4.x branch
RUN gvm-wrapper.sh install grails 2.4.3 && gvm-wrapper.sh flush archives && gvm-exec.sh grails help
