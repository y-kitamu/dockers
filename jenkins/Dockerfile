FROM jenkinsci:blueocean

USER root

# Android
RUN apt-get update && apt-get upgrade -y
RUN apt-get install openjdk8 wget

ENV JAVA_HOME /usr/lib/jvm/java-1.8-openjdk
ENV SDK_TOOL_VERSION=sdk-tools-linux-6609375
ENV ANDROID_HOME=/usr/local/android-sdk-linux
ENV BUILD_TOOLS_VERSION=28.0.3
ENV PLATFORMS_VERSION=android-28
ENV PATH=$PATH:$ANDROID_HOME/tools:$ANDROID_HOME/tools/bin

RUN mkdir $ANDROID_HOME && \
    wget "https://dl.google.com/android/repository/${SDK_TOOL_VERSION}.zip" && \
    unzip -d $ANDROID_HOME $SDK_TOOL_VERSION.zip &&\
    rm -rf $SDK_TOOL_VERSION.zip

nUSER jenkins
RUN mkdir ~/.android &&\
    touch ~/.android/repositories.cfg
RUN yes | sdkmanager --licenses
RUN sdkmanager "tools" "build-tools;${BUILD_TOOLS_VERSION}" "platforms;${PLATFORMS_VERSION}" "platform-tools" "extras;android;m2repository"
