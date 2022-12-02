#!/bin/bash

# 换源
sudo sed -i "s@http://.*archive.ubuntu.com@https://mirrors.tuna.tsinghua.edu.cn@g" /etc/apt/sources.list
sudo sed -i "s@http://.*security.ubuntu.com@https://mirrors.tuna.tsinghua.edu.cn@g" /etc/apt/sources.list
sudo apt update
echo 'update success'

# 安装其他工具及框架
sudo apt install -y vim net-tools git cmake make gcc python3-pip openssl libssl-dev libfreeimage3 libfreeimage-dev

# OpenCV依赖大全
sudo apt-get install -y build-essential cmake git unzip pkg-config zlib1g-dev
sudo apt-get install -y libjpeg-dev libjpeg8-dev libjpeg-turbo8-dev
sudo apt-get install -y libpng-dev libtiff-dev libglew-dev
sudo apt-get install -y libavcodec-dev libavformat-dev libswscale-dev
sudo apt-get install -y libgtk2.0-dev libgtk-3-dev libcanberra-gtk-dev
sudo apt-get install -y python-all-dev python-setuptools python-wheel
sudo apt-get install -y python3-dev python3-numpy python3-pip
sudo apt-get install -y libxvidcore-dev libx264-dev libgtk-3-dev
sudo apt-get install -y libtbb2 libtbb-dev libdc1394-22-dev libxine2-dev
sudo apt-get install -y gstreamer1.0-tools libgstreamer-plugins-base1.0-dev
sudo apt-get install -y libgstreamer-plugins-good1.0-dev
sudo apt-get install -y libqt5core5a libqt5gui5 libqt5opengl5 libqt5widgets5 
sudo apt-get install -y libv4l-dev v4l-utils qv4l2
sudo apt-get install -y libtesseract-dev libxine2-dev libpostproc-dev
sudo apt-get install -y libavresample-dev libvorbis-dev
sudo apt-get install -y libfaac-dev libmp3lame-dev libtheora-dev
sudo apt-get install -y libopencore-amrnb-dev libopencore-amrwb-dev
sudo apt-get install -y libopenblas-dev libatlas-base-dev libblas-dev
sudo apt-get install -y liblapack-dev liblapacke-dev libeigen3-dev gfortran
sudo apt-get install -y libhdf5-dev libprotobuf-dev protobuf-compiler
sudo apt-get install -y libgoogle-glog-dev libgflags-dev
sudo apt-get install -y libgphoto2-dev

# 终端输入替换
echo " " >> /home/duxinyi/.bashrc
echo 'alias python="/usr/bin/python3"' >> ~/.bashrc
echo 'alias pip="/usr/bin/pip3"' >> ~/.bashrc

# pip换源
python -m pip install --upgrade pip
pip config set global.index-url https://pypi.tuna.tsinghua.edu.cn/simple

# ROS2
sudo apt install -y curl gnupg2 lsb-release
curl http://repo.ros2.org/repos.key | sudo apt-key add -
sudo sh -c 'echo "deb http://packages.ros.org/ros2/ubuntu `lsb_release -cs` main" > /etc/apt/sources.list.d/ros2-latest.list'
sudo sed -i 's/deb /deb [arch=amd64] /' /etc/apt/sources.list.d
sudo apt install -y ros-foxy-desktop
echo "source /opt/ros/foxy/setup.bash" >> ~/.bashrc
