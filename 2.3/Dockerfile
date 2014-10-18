FROM onesysadmin/tomcat8-gvm

ENTRYPOINT ["gvm-exec.sh", "grails"]

# install newest version of grails 2.3.x
RUN gvm-wrapper.sh install grails 2.3.11 && gvm-wrapper.sh flush archives
