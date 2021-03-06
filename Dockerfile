FROM debian:stable

## Option to pass http and https proxy information into build
ENV http_proxy ${http_proxy}
RUN if [ ! -z "$http_proxy" ]; then sh -c "echo \"Acquire::HTTP {\n  Proxy \\\"${http_proxy}\\\"; \n  Retries 10;\n}\" > /etc/apt/apt.conf.d/proxy.conf"; fi

RUN cat /etc/apt/apt.conf.d/proxy.conf

## Somewhat randomly, the openjdk JDK is required for some functions to run...
RUN apt-get update && \
    apt-get install -y unzip wget openjdk-11-jdk && \
    rm -rf /var/lib/apt/lists/*

RUN mkdir /mcr-install
WORKDIR /mcr-install
RUN wget http://ssd.mathworks.com/supportfiles/downloads/R2020a/Release/0/deployment_files/installer/complete/glnxa64/MATLAB_Runtime_R2020a_glnxa64.zip && \
    unzip MATLAB_Runtime_R2020a_glnxa64.zip && \
    ./install -mode silent -agreeToLicense yes && \
    rm -Rf /mcr-install

## Unset http_proxy
RUN rm /etc/apt/apt.conf.d/proxy.conf
ENV http_proxy ""

## There are reports that forcing Matlab to use system libstdc++ fixes some problems
# RUN rm /usr/local/MATLAB/MATLAB_Runtime/v98/sys/os/glnxa64/libstdc++*

ENV MATLAB_INSTALL=/usr/local/MATLAB/MATLAB_Runtime/v98
ENV XAPPLRESDIR=$MATLAB_INSTALL/X11/app-defaults

ENV MATLAB_LD_LIBRARY_PATH=$MATLAB_INSTALL/runtime/glnxa64:$MATLAB_INSTALL/bin/glnxa64:$MATLAB_INSTALL/sys/os/glnxa64:$MATLAB_INSTALL/sys/java/jre/glnxa64/jre/lib/amd64/native_threads:$MATLAB_INSTALL/sys/java/jre/glnxa64/jre/lib/amd64/server:$MATLAB_INSTALL/sys/java/jre/glnxa64/jre/lib/amd64
ENV MCR_CACHE_ROOT=/tmp

ENV PATH=$PATH:$MATLAB_INSTALL/bin/glnx64
