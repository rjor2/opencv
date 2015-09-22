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
RUN mkdir /usr/src/opencv
ADD . /usr/src/opencv

# Pull from main opencv repo in case we're behind.
# Needs git config user.name and user.password set?? so leaving out for now
# WORKDIR /usr/src/opencv
# RUN git pull https://github.com/Itseez/opencv

# Build source code
RUN mkdir /usr/src/opencv/release
WORKDIR /usr/src/opencv/release
RUN cmake -D CMAKE_BUILD_TYPE=RELEASE -D CMAKE_INSTALL_PREFIX=/usr/local ..
RUN make
RUN make install

