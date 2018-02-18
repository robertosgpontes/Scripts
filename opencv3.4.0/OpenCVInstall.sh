#!/bin/bash

###########################################################################################################
###                       		OpenCV3 Installation Script                                     ###
###                                                                          				###
###                                                                         				###
### Created By: Roberto Pontes                                               				###
### Tested in Ubuntu 17.10 and OpenCV3.4.0 maker with Python3.6              				###
### References: 											###
###	https://docs.opencv.org/3.4.0/d7/d9f/tutorial_linux_install.html				###
###     https://www.pyimagesearch.com/2015/07/20/install-opencv-3-0-and-python-3-4-on-ubuntu/		###
### 	https://www.learnopencv.com/install-opencv3-on-ubuntu/			  	             	###
###########################################################################################################

cd ~/Downloads

##################### Dependencies

sudo add-apt-repository "deb http://security.ubuntu.com/ubuntu xenial-security main"
sudo apt-get -y update
sudo apt-get -y upgrade
sudo apt-get -y dist-upgrade
sudo apt-get -y autoremove

sudo apt-get remove x264 libx264-dev

wget http://mirrors.kernel.org/ubuntu/pool/main/libp/libpng/libpng12-0_1.2.54-1ubuntu1_amd64.deb

sudo dpkg -i libpng12-0_1.2.54-1ubuntu1_amd64.deb

rm -Rf libpng12-0_1.2.54-1ubuntu1_amd64.deb

sudo apt-get install -y build-essential cmake qt5-default \
	libvtk6-dev zlib1g-dev libwebp-dev libopenexr-dev \
	libgdal-dev libjpeg8-dev libjasper-dev libtiff5-dev \
	libtbb2 libdc1394-22-dev libgtk2.0-dev libavcodec-dev \
        libavformat-dev libswscale-dev libatlas-base-dev \
	gfortran libxine2-dev libv4l-dev libgstreamer1.0-0 \
	gstreamer1.0-plugins-base gstreamer1.0-plugins-good \
	gstreamer1.0-plugins-bad gstreamer1.0-plugins-ugly \
	gstreamer1.0-libav gstreamer1.0-doc gstreamer1.0-tools \
	git pkg-config checkinstall yasm libqt5gstreamer-1.0-0 \
	libtbb-dev libgtk-3-dev libfaac-dev libmp3lame-dev \
	libtheora-dev libvorbis-dev libxvidcore-dev \
	libopencore-amrnb-dev libopencore-amrwb-dev \
	libprotobuf-dev protobuf-compiler libgoogle-glog-dev \
	libgflags-dev libgphoto2-dev libeigen3-dev libhdf5-dev \
	doxygen libopencv-dev x264 v4l-utils python3-dev python3-tk 


wget https://bootstrap.pypa.io/get-pip.py

sudo -H python3 get-pip.py

rm -Rf get-pip.py

sudo -H pip3 install --upgrade pip

sudo -H pip3 install dev

sudo -H pip3 install numpy 

sudo -H pip3 install jinja2


##################### Download OpenCV

wget https://github.com/opencv/opencv/archive/3.4.0.zip

unzip 3.4.0.zip

git clone https://github.com/opencv/opencv_contrib.git

cd opencv_contrib/

git checkout 3.4.0

cd ../opencv-3.4.0/


##################### Compile and install

mkdir build

cd build

cmake -D CMAKE_BUILD_TYPE=RELEASE \
      -D CMAKE_INSTALL_PREFIX=/usr/local \
      -D INSTALL_C_EXAMPLES=ON \
      -D INSTALL_PYTHON_EXAMPLES=ON \
      -D WITH_TBB=ON \
      -D WITH_V4L=ON \
      -D WITH_QT=ON \
      -D WITH_OPENGL=ON \
      -D WITH_GSTREAMER=ON \
      -D FORCE_VTK=ON \
      -D WITH_GDAL=ON \
      -D WITH_XINE=ON \
      -D INSTALL_TESTS=ON \
      -D ENABLE_FAST_MATH=ON \
      -D WITH_IMAGEIO=ON \
      -D OPENCV_EXTRA_MODULES_PATH=../../opencv_contrib/modules \
      -D BUILD_EXAMPLES=ON \
      -D BUILD_DOCS=ON \
      -D BUILD_opencv_python3=ON \
      -D PYTHON_DEFAULT_EXECUTABLE=/usr/bin/python3 \
      -D PYTHON3_EXECUTABLE=/usr/bin/python3 \
      -D PYTHON3_INCLUDE_DIR=/usr/include/python3.6 \
      -D PYTHON3_INCLUDE_DIR2=/usr/include/x86_64-linux-gnu/python3.6m \
      -D PYTHON3_LIBRARY=/usr/lib/x86_64-linux-gnu/libpython3.6m.so \
      -D PYTHON3_NUMPY_INCLUDE_DIRS=/usr/local/lib/python3.6/dist-packages/numpy/core/include/ ..

make -j$(nproc)

cd doc

make -j$(nproc) doxygen

cd ..

sudo make install

sudo ldconfig

cd ~/Downloads

rm -Rf opencv-3.4.0
rm -Rf opencv_contrib
rm -Rf 3.4.0.zip

### Echo OpenCV installed version if installation process was successful
echo -e "OpenCV version:"
pkg-config --modversion opencv




