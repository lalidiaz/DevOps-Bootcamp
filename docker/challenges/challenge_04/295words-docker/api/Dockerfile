# Use the Amazon Corretto 18 Java runtime as the base image
FROM amazoncorretto:18

# Copy the compiled Java application jar file from the ./target directory
# into the root directory of the container
COPY ./target .

# Expose port 8080 to allow incoming connections to the Java application
EXPOSE 8080

# When the container starts, run the Java application using the
# words.jar file that was copied into the container
CMD ["java", "-jar", "words.jar"]
   

