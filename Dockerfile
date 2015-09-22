FROM ubuntu

# Update
RUN apt-get update
RUN apt-get -y upgrade
RUN apt-get -y dist-upgrade
RUN apt-get -y autoremove

# Install build tools
RUN apt-get install -y build-essential
RUN apt-get install -y cmake git libgtk2.0-dev pkg-config libavcodec-dev libavformat-dev libswscale-dev
RUN apt-get install -y python-dev python-numpy libtbb2 libtbb-dev libjpeg-dev libpng-dev libtiff-dev libjasper-dev libdc1394-22-dev

# Add source code
WORKDIR /usr/src
ADD . /usr/src

# Pull from main opencv repo in case we're behind.
RUN git pull https://github.com/Itseez/opencv

# Build source code
RUN mkdir release
WORKDIR /usr/src/release
RUN cmake -D CMAKE_BUILD_TYPE=RELEASE -D CMAKE_INSTALL_PREFIX=/usr/local ..
RUN make
RUN make install

