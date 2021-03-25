FROM i2incommon/grouper:2.5.42
 
# 5005 is for JVM debugger
EXPOSE 8080
 
# Copy in customizations as needed
# COPY files/etc/ /etc/
# COPY files/grouperWebapp/ /opt/grouper/grouperWebapp/
 
# TEMPFIX: Grouper issue
#grouperContainer; INFO: (librarySetupFilesTomcat.sh-setupFilesTomcat_loggingSlf4j) rm -f /opt/grouper/grouperWebapp/WEB-INF/lib/slf4j-jdk*.jar , result: 1
RUN cd /opt/grouper/grouperWebapp/WEB-INF/ && chgrp 0 lib lib/slf4j-jdk14-1.7.21.jar && chmod g+rws ./lib && chmod g+rw ./lib/slf4j-jdk14-1.7.21.jar
 
# TEMPFIX: Grouper UI startup issue
#java.lang.RuntimeException: Cant make dir: /opt/grouper/grouperWebapp/WEB-INF/ddlScripts
RUN cd /opt/grouper/grouperWebapp/WEB-INF && mkdir ddlScripts && chgrp 0 ddlScripts && chmod g+rws ddlScripts
 
# TEMPFIX: Grouper gsh issue with unwritable WEB-INF/.groovy (defaults to current directory if user has no home directory?)
RUN chgrp 0 /opt/grouper/grouperWebapp/WEB-INF && chmod g+ws /opt/grouper/grouperWebapp/WEB-INF