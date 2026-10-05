# =========================
# Stage 1: Build
# =========================
FROM maven:3.9-eclipse-temurin-17 AS build

WORKDIR /build

# Copy Maven project
COPY pom.xml .

# Download dependencies
RUN mvn -q -DskipTests dependency:go-offline

# Copy source
COPY src src

# Copy database files if present
COPY database database

# Build WAR
RUN mvn -q -DskipTests clean package

# Verify MySQL JDBC driver is packaged inside WAR
RUN echo "=== Checking WAR for MySQL JDBC driver ===" && \
    jar tf target/ClassVoice.war | grep -i "mysql-connector"

# =========================
# Stage 2: Tomcat
# =========================
FROM tomcat:10.1-jdk17-temurin

# Remove default Tomcat application
RUN rm -rf /usr/local/tomcat/webapps/ROOT \
           /usr/local/tomcat/webapps/ROOT.war

# Copy our application
COPY --from=build /build/target/ClassVoice.war \
                  /usr/local/tomcat/webapps/ClassVoice.war

EXPOSE 8080

CMD ["catalina.sh", "run"]
