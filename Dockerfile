# Use the official Tomcat 9 image as the base image
FROM tomcat:9.0

RUN mv webapps webappsSS
RUN mv webapps.dist webapps 

# Copy the artifact from the project directory to the Tomcat webapps directory
COPY ./target/javulna-1.0-SNAPSHOT.war /usr/local/tomcat/webapps/



# Expose the default Tomcat port (8080)
EXPOSE 8080

# Start Tomcat when the container starts
CMD ["catalina.sh", "run"]
