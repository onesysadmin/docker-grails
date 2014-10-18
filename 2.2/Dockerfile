FROM onesysadmin/tomcat8-gvm

ENTRYPOINT ["gvm-exec.sh", "grails"]

# install newest version of grails 2.2.x
RUN gvm-wrapper.sh install grails 2.2.5 && gvm-wrapper.sh flush archives
