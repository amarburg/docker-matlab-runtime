FROM debian:stretch

RUN apt-get update && apt-get install -y unzip wget

RUN mkdir /mcr-install
WORKDIR /mcr-install
RUN wget http://ssd.mathworks.com/supportfiles/downloads/R2018a/deployment_files/R2018a/installers/glnxa64/MCR_R2018a_glnxa64_installer.zip && \
    unzip MCR_R2018a_glnxa64_installer.zip && \
    ./install -mode silent -agreeToLicense yes && \
    rm -Rf /mcr-install

ENV MATLAB_INSTALL=/usr/local/MATLAB/MATLAB_Runtime/v93
ENV XAPPLRESDIR=$MATLAB_INSTALL/X11/app-defaults

ENV MATLAB_LD_LIBRARY_PATH=$MATLAB_INSTALL/runtime/glnxa64:$MATLAB_INSTALL/bin/glnxa64:$MATLAB_INSTALL/sys/os/glnxa64:$MATLAB_INSTALL/sys/java/jre/glnxa64/jre/lib/amd64/native_threads:$MATLAB_INSTALL/sys/java/jre/glnxa64/jre/lib/amd64/server:$MATLAB_INSTALL/sys/java/jre/glnxa64/jre/lib/amd64

ENV MCR_CACHE_VERBOSE=true
ENV MCR_CACHE_ROOT=/tmp
