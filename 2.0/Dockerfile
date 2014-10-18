FROM onesysadmin/tomcat8-gvm

ENTRYPOINT ["grails"]

# install newest version of grails 2.0.x
RUN gvm-wrapper.sh install grails 2.0.4 && gvm-wrapper.sh flush archives
