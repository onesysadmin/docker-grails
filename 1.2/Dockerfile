FROM onesysadmin/tomcat8-gvm

ENTRYPOINT ["grails"]

# install newest version of grails 1.2.x
RUN gvm-wrapper.sh install grails 1.2.5 && gvm-wrapper.sh flush archives
