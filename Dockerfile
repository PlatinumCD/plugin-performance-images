FROM ubuntu:focal
LABEL description="Small performance image containing Python 3, pywaggle, and TAU."
LABEL maintainer="Cameron F Durbin <cfd@uoregon.edu>"
LABEL url="https://github.com/PlatinumCD/plugin-performance-images"

# setup timezone
RUN echo 'Etc/UTC' > /etc/timezone && \
    ln -s /usr/share/zoneinfo/Etc/UTC /etc/localtime

# install system packages
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    git \
    nano \
    python3-dev \
    python3-pip \
    python3-opencv \
    && rm -rf /var/lib/apt/lists/*

# install waggle packages
RUN pip3 install --no-cache-dir git+https://github.com/waggle-sensor/pywaggle

# install TAU packages
RUN git clone https://github.com/UO-OACISS/tau2.git /tau2
RUN cd /tau2 && \
    ./configure \
        -exec-prefix=waggle -prefix=/opt/tau -python3 \
        -pythonlib=/usr/lib/$(gcc -print-multiarch) && \
    make install

ENV PYTHONPATH=/opt/tau/waggle/lib
