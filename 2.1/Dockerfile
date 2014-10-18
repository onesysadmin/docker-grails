FROM onesysadmin/tomcat8-gvm

ENTRYPOINT ["gvm-exec.sh", "grails"]

# install newest version of grails 2.1.x
RUN gvm-wrapper.sh install grails 2.1.5 && gvm-wrapper.sh flush archives
