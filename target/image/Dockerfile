
# This is a Dockerfile for the ubi9/openjdk-21:1.18 image.


## START target image ubi9/openjdk-21:1.18
## \
    FROM registry.access.redhat.com/ubi9/ubi-minimal


    USER root

###### START module 'jboss.container.util.pkg-update:1.0'
###### \
        # Copy 'jboss.container.util.pkg-update' module content
        COPY modules/jboss.container.util.pkg-update /tmp/scripts/jboss.container.util.pkg-update
        # Custom scripts from 'jboss.container.util.pkg-update' module
        USER root
        RUN [ "sh", "-x", "/tmp/scripts/jboss.container.util.pkg-update/execute.sh" ]
###### /
###### END module 'jboss.container.util.pkg-update:1.0'

###### START module 'jboss.container.user:2.0'
###### \
        # Copy 'jboss.container.user' module content
        COPY modules/jboss.container.user /tmp/scripts/jboss.container.user
        # Switch to 'root' user for package management for 'jboss.container.user' module defined packages
        USER root
        # Install packages defined in the 'jboss.container.user' module
        RUN microdnf --setopt=install_weak_deps=0 --setopt=tsflags=nodocs install -y shadow-utils \
            && microdnf clean all \
            && rpm -q shadow-utils
        # Set 'jboss.container.user' module defined environment variables
        ENV \
            GECOS="Default user" \
            HOME="/home/default" \
            UID="185" \
            USER="default"
        # Custom scripts from 'jboss.container.user' module
        USER root
        RUN [ "sh", "-x", "/tmp/scripts/jboss.container.user/configure.sh" ]
###### /
###### END module 'jboss.container.user:2.0'

###### START module 'jboss.container.openjdk:0'
###### \
###### /
###### END module 'jboss.container.openjdk:0'

###### START module 'jboss.container.openjdk.jdk:21'
###### \
        # Copy 'jboss.container.openjdk.jdk' module content
        COPY modules/jboss.container.openjdk.jdk /tmp/scripts/jboss.container.openjdk.jdk
        # Switch to 'root' user for package management for 'jboss.container.openjdk.jdk' module defined packages
        USER root
        # Install packages defined in the 'jboss.container.openjdk.jdk' module
        RUN microdnf --setopt=install_weak_deps=0 --setopt=tsflags=nodocs install -y java-21-openjdk-devel \
            && microdnf clean all \
            && rpm -q java-21-openjdk-devel
        # Set 'jboss.container.openjdk.jdk' module defined environment variables
        ENV \
            JAVA_HOME="/usr/lib/jvm/java-21" \
            JAVA_VENDOR="openjdk" \
            JAVA_VERSION="21" \
            JBOSS_CONTAINER_OPENJDK_JDK_MODULE="/opt/jboss/container/openjdk/jdk"
        # Set 'jboss.container.openjdk.jdk' module defined labels
        LABEL \
            org.jboss.product="openjdk" \
            org.jboss.product.openjdk.version="21" \
            org.jboss.product.version="21"
        # Custom scripts from 'jboss.container.openjdk.jdk' module
        USER root
        RUN [ "sh", "-x", "/tmp/scripts/jboss.container.openjdk.jdk/configure.sh" ]
###### /
###### END module 'jboss.container.openjdk.jdk:21'

###### START module 'jboss.container.maven.module:3.8'
###### \
        # Copy 'jboss.container.maven.module' module content
        COPY modules/jboss.container.maven.module /tmp/scripts/jboss.container.maven.module
        # Custom scripts from 'jboss.container.maven.module' module
        USER root
        RUN [ "sh", "-x", "/tmp/scripts/jboss.container.maven.module/configure.sh" ]
###### /
###### END module 'jboss.container.maven.module:3.8'

###### START module 'jboss.container.maven:3.8.17'
###### \
        # Copy 'jboss.container.maven' module content
        COPY modules/jboss.container.maven /tmp/scripts/jboss.container.maven
        # Switch to 'root' user for package management for 'jboss.container.maven' module defined packages
        USER root
        # Install packages defined in the 'jboss.container.maven' module
        RUN microdnf --setopt=install_weak_deps=0 --setopt=tsflags=nodocs install -y maven-openjdk17 \
            && microdnf clean all \
            && rpm -q maven-openjdk17
        # Set 'jboss.container.maven' module defined environment variables
        ENV \
            JBOSS_CONTAINER_MAVEN_38_MODULE="/opt/jboss/container/maven/38/" \
            MAVEN_VERSION="3.8"
        # Custom scripts from 'jboss.container.maven' module
        USER root
        RUN [ "sh", "-x", "/tmp/scripts/jboss.container.maven/configure.sh" ]
###### /
###### END module 'jboss.container.maven:3.8.17'

###### START module 'jboss.container.s2i.core:9.0'
###### \
        # Copy 'jboss.container.s2i.core' module content
        COPY modules/jboss.container.s2i.core /tmp/scripts/jboss.container.s2i.core
        # Switch to 'root' user for package management for 'jboss.container.s2i.core' module defined packages
        USER root
        # Install packages defined in the 'jboss.container.s2i.core' module
        RUN microdnf --setopt=install_weak_deps=0 --setopt=tsflags=nodocs install -y findutils rsync \
            && microdnf clean all \
            && rpm -q findutils rsync
        # Set 'jboss.container.s2i.core' module defined environment variables
        ENV \
            JBOSS_CONTAINER_S2I_CORE_MODULE="/opt/jboss/container/s2i/core/" \
            S2I_SOURCE_DEPLOYMENTS_FILTER="*.jar quarkus-app"
        # Set 'jboss.container.s2i.core' module defined labels
        LABEL \
            io.openshift.s2i.destination="/tmp" \
            io.openshift.s2i.scripts-url="image:///usr/local/s2i" \
            org.jboss.container.deployments-dir="/deployments"
        # Custom scripts from 'jboss.container.s2i.core' module
        USER root
        RUN [ "sh", "-x", "/tmp/scripts/jboss.container.s2i.core/configure.sh" ]
###### /
###### END module 'jboss.container.s2i.core:9.0'

###### START module 'jboss.container.java.proxy:2.0'
###### \
        # Copy 'jboss.container.java.proxy' module content
        COPY modules/jboss.container.java.proxy /tmp/scripts/jboss.container.java.proxy
        # Set 'jboss.container.java.proxy' module defined environment variables
        ENV \
            JBOSS_CONTAINER_JAVA_PROXY_MODULE="/opt/jboss/container/java/proxy"
        # Custom scripts from 'jboss.container.java.proxy' module
        USER root
        RUN [ "sh", "-x", "/tmp/scripts/jboss.container.java.proxy/configure.sh" ]
###### /
###### END module 'jboss.container.java.proxy:2.0'

###### START module 'jboss.container.java.jvm:1.0'
###### \
        # Copy 'jboss.container.java.jvm' module content
        COPY modules/jboss.container.java.jvm /tmp/scripts/jboss.container.java.jvm
        # Set 'jboss.container.java.jvm' module defined environment variables
        ENV \
            JBOSS_CONTAINER_JAVA_JVM_MODULE="/opt/jboss/container/java/jvm"
        # Custom scripts from 'jboss.container.java.jvm' module
        USER root
        RUN [ "sh", "-x", "/tmp/scripts/jboss.container.java.jvm/configure.sh" ]
###### /
###### END module 'jboss.container.java.jvm:1.0'

###### START module 'jboss.container.util.logging:1.0'
###### \
        # Copy 'jboss.container.util.logging' module content
        COPY modules/jboss.container.util.logging /tmp/scripts/jboss.container.util.logging
        # Set 'jboss.container.util.logging' module defined environment variables
        ENV \
            JBOSS_CONTAINER_UTIL_LOGGING_MODULE="/opt/jboss/container/util/logging/"
        # Custom scripts from 'jboss.container.util.logging' module
        USER root
        RUN [ "sh", "-x", "/tmp/scripts/jboss.container.util.logging/configure.sh" ]
###### /
###### END module 'jboss.container.util.logging:1.0'

###### START module 'jboss.container.maven.default:1.0'
###### \
        # Copy 'jboss.container.maven.default' module content
        COPY modules/jboss.container.maven.default /tmp/scripts/jboss.container.maven.default
        # Switch to 'root' user for package management for 'jboss.container.maven.default' module defined packages
        USER root
        # Install packages defined in the 'jboss.container.maven.default' module
        RUN microdnf --setopt=install_weak_deps=0 --setopt=tsflags=nodocs install -y findutils \
            && microdnf clean all \
            && rpm -q findutils
        # Set 'jboss.container.maven.default' module defined environment variables
        ENV \
            JBOSS_CONTAINER_MAVEN_DEFAULT_MODULE="/opt/jboss/container/maven/default/"
        # Custom scripts from 'jboss.container.maven.default' module
        USER root
        RUN [ "sh", "-x", "/tmp/scripts/jboss.container.maven.default/configure.sh" ]
###### /
###### END module 'jboss.container.maven.default:1.0'

###### START module 'jboss.container.maven.s2i:1.0'
###### \
        # Copy 'jboss.container.maven.s2i' module content
        COPY modules/jboss.container.maven.s2i /tmp/scripts/jboss.container.maven.s2i
        # Switch to 'root' user for package management for 'jboss.container.maven.s2i' module defined packages
        USER root
        # Install packages defined in the 'jboss.container.maven.s2i' module
        RUN microdnf --setopt=install_weak_deps=0 --setopt=tsflags=nodocs install -y tar \
            && microdnf clean all \
            && rpm -q tar
        # Set 'jboss.container.maven.s2i' module defined environment variables
        ENV \
            JBOSS_CONTAINER_MAVEN_S2I_MODULE="/opt/jboss/container/maven/s2i"
        # Custom scripts from 'jboss.container.maven.s2i' module
        USER root
        RUN [ "sh", "-x", "/tmp/scripts/jboss.container.maven.s2i/configure.sh" ]
###### /
###### END module 'jboss.container.maven.s2i:1.0'

###### START module 'jboss.container.java.run:1.0'
###### \
        # Copy 'jboss.container.java.run' module content
        COPY modules/jboss.container.java.run /tmp/scripts/jboss.container.java.run
        # Set 'jboss.container.java.run' module defined environment variables
        ENV \
            JAVA_DATA_DIR="/deployments/data" \
            JBOSS_CONTAINER_JAVA_RUN_MODULE="/opt/jboss/container/java/run"
        # Custom scripts from 'jboss.container.java.run' module
        USER root
        RUN [ "sh", "-x", "/tmp/scripts/jboss.container.java.run/configure.sh" ]
###### /
###### END module 'jboss.container.java.run:1.0'

###### START module 'jboss.container.java.s2i.bash:1.0'
###### \
        # Copy 'jboss.container.java.s2i.bash' module content
        COPY modules/jboss.container.java.s2i.bash /tmp/scripts/jboss.container.java.s2i.bash
        # Switch to 'root' user for package management for 'jboss.container.java.s2i.bash' module defined packages
        USER root
        # Install packages defined in the 'jboss.container.java.s2i.bash' module
        RUN microdnf --setopt=install_weak_deps=0 --setopt=tsflags=nodocs install -y rsync \
            && microdnf clean all \
            && rpm -q rsync
        # Set 'jboss.container.java.s2i.bash' module defined environment variables
        ENV \
            JBOSS_CONTAINER_JAVA_S2I_MODULE="/opt/jboss/container/java/s2i"
        # Custom scripts from 'jboss.container.java.s2i.bash' module
        USER root
        RUN [ "sh", "-x", "/tmp/scripts/jboss.container.java.s2i.bash/configure.sh" ]
###### /
###### END module 'jboss.container.java.s2i.bash:1.0'

###### START module 'jboss.container.util.tzdata:1.0'
###### \
        # Copy 'jboss.container.util.tzdata' module content
        COPY modules/jboss.container.util.tzdata /tmp/scripts/jboss.container.util.tzdata
        # Custom scripts from 'jboss.container.util.tzdata' module
        USER root
        RUN [ "sh", "-x", "/tmp/scripts/jboss.container.util.tzdata/execute.sh" ]
###### /
###### END module 'jboss.container.util.tzdata:1.0'

###### START module 'jboss.container.java.singleton-jdk:1.0'
###### \
        # Copy 'jboss.container.java.singleton-jdk' module content
        COPY modules/jboss.container.java.singleton-jdk /tmp/scripts/jboss.container.java.singleton-jdk
        # Custom scripts from 'jboss.container.java.singleton-jdk' module
        USER root
        RUN [ "sh", "-x", "/tmp/scripts/jboss.container.java.singleton-jdk/configure.sh" ]
###### /
###### END module 'jboss.container.java.singleton-jdk:1.0'

###### START image 'ubi9/openjdk-21:1.18'
###### \
        # Set 'ubi9/openjdk-21' image defined environment variables
        ENV \
            JBOSS_IMAGE_NAME="ubi9/openjdk-21" \
            JBOSS_IMAGE_VERSION="1.18" \
            LANG="C.utf8" \
            PATH="$PATH:"/usr/local/s2i""
        # Set 'ubi9/openjdk-21' image defined labels
        LABEL \
            com.redhat.component="openjdk-21-ubi9-container" \
            com.redhat.license_terms="https://www.redhat.com/en/about/red-hat-end-user-license-agreements#UBI" \
            description="Source To Image (S2I) image for Red Hat OpenShift providing OpenJDK 21" \
            io.cekit.version="4.9.1" \
            io.k8s.description="Platform for building and running plain Java applications (fat-jar and flat classpath)" \
            io.k8s.display-name="Java Applications" \
            io.openshift.tags="builder,java" \
            maintainer="Red Hat OpenJDK <openjdk@redhat.com>" \
            name="ubi9/openjdk-21" \
            org.opencontainers.image.documentation="https://jboss-container-images.github.io/openjdk/" \
            summary="Source To Image (S2I) image for Red Hat OpenShift providing OpenJDK 21" \
            usage="https://jboss-container-images.github.io/openjdk/" \
            version="1.18"
        # Exposed ports in 'ubi9/openjdk-21' image
        EXPOSE 8080 8443
###### /
###### END image 'ubi9/openjdk-21:1.18'



    # Switch to 'root' user and remove artifacts and modules
    USER root
    RUN [ ! -d /tmp/scripts ] || rm -rf /tmp/scripts
    RUN [ ! -d /tmp/artifacts ] || rm -rf /tmp/artifacts
    # Clear package manager metadata
    RUN microdnf clean all && [ ! -d /var/cache/yum ] || rm -rf /var/cache/yum

    # Define the user
    USER 185
    # Define the working directory
    WORKDIR /home/default
    # Define run cmd
    CMD ["/usr/local/s2i/run"]
## /
## END target image