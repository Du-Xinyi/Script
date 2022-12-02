#!/bin/bash

# sudo输入免密码(用" "会导致不包含空格等)
sudo sed -i 's/%sudo   ALL=(ALL:ALL) ALL/%sudo   ALL=(ALL:ALL) NOPASSWD:ALL/' /etc/sudoers
echo 'sudo nopasswd set success'

# 翻墙环境配置
sudo echo " " >> /etc/environment
sudo echo "http_proxy=http://127.0.0.1:7890/" >> /etc/environment
sudo echo "https_proxy=http://127.0.0.1:7890/" >> /etc/environment
sudo echo "ftp_proxy=http://127.0.0.1:7890/" >> /etc/environment
sudo echo "HTTP_PROXY=http://127.0.0.1:7890/" >> /etc/environment
sudo echo "HTTPS_PROXY=http://127.0.0.1:7890/" >> /etc/environment
sudo echo "FTP_PROXY=http://127.0.0.1:7890/" >> /etc/environment
echo 'environment set success'

# 修改swap大小
sudo swapoff /swapfile
sudo rm /swapfile
sudo dd if=/dev/zero of=/swapfile bs=1G count=24
sudo chmod 0600 swapfile
sudo mkswap -f swapfile
sudo swapon /swapfile
echo 'swap expansion success'

# 搜狗拼音输入法
sudo apt install -y fcitx libqt5qml5 libqt5quick5 libqt5quickwidgets5 qml-module-qtquick2 libgsettings-qt1
sudo dpkg -i sogoupinyin.deb

# WPS
sudo dpkg -i wps-office.deb
unzip wps_symbol_fonts.zip
sudo mv mtextra.ttf /usr/share/fonts
sudo mv symbol.ttf /usr/share/fonts
sudo mv WEBDINGS.ttf /usr/share/fonts
sudo mv wingding.ttf /usr/share/fonts
sudo mv WINGDNG2.ttf /usr/share/fonts
sudo mv WINGDNG3.ttf /usr/share/fonts

# zsh(需要重新登入才能生效)
sudo apt install -y zsh
sh -c "$(wget https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O -)"
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
sed -i "s/robbyrussell/ys/" ~/.zshrc
sed -i 's/plugins=(git)/plugins=(git extract zsh-syntax-highlighting)/' ~/.zshrc
source ~/.zshrc

# 终端输入替换
echo " " >> ~/.zshrc
echo 'alias python="/usr/bin/python3"' >> ~/.zshrc
echo 'alias pip="/usr/bin/pip3"' >> ~/.zshrc

# 添加ROS2启动脚本
echo "source /opt/ros/foxy/setup.zsh" >> ~/.zshrc 
source ~/.zshrc

# 视频播放器及图片查看器
sudo apt install -y vlc gwenview

# 标题栏监控Indicator-sysmonitor
sudo add-apt-repository ppa:fossfreedom/indicator-sysmonitor
sudo apt-get update
sudo apt-get install -y indicator-sysmonitor

# 备份Timeshift
sudo apt-add-repository -y ppa:teejee2008/ppa
sudo apt-get update
sudo apt-get install -y timeshift

# 文档Typora
wget -qO - https://typoraio.cn/linux/public-key.asc | sudo tee /etc/apt/trusted.gpg.d/typora.asc
sudo add-apt-repository -y 'deb https://typoraio.cn/linux ./'
sudo apt-get update
sudo apt-get install typora

# 修正因为双系统导致的Windows时间错误
sudo apt install -y ntpdate
sudo ntpdate time.windows.com
sudo hwclock --localtime --systohc

# 改rEFInd引导后关闭ubuntu的grub引导界面
sudo sed -i 's/set timeout=10/set timeout=0/' /etc/grub.d/30_os-prober
sudo sed -i 's/GRUB_TIMEOUT=10/GRUB_TIMEOUT=0/' /etc/default/grub
sudo update-grub
echo 'grub-update success'
