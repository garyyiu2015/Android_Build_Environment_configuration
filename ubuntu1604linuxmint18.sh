#!/bin/bash
#
# Copyright (C) 2017 The LineageOS Project
#
clear
echo “安装编译环境需要的依赖库”
sudo apt update -y
sudo apt install bc bison build-essential curl flex g++-multilib gcc-multilib git gnupg gperf imagemagick lib32ncurses5-dev lib32readline-dev lib32z1-dev libesd0-dev liblz4-tool libncurses5-dev libsdl1.2-dev libssl-dev libwxgtk3.0-dev libxml2 libxml2-utils lzop pngcrush rsync schedtool squashfs-tools xsltproc zip zlib1g-dev openjdk-8-jdk android-tools-adb android-tools-fastboot -y
echo “依赖库安装完毕”
echo “安装额外的工具”
sudo apt install p7zip-full tree -y
echo “工具安装完毕”

if [ ! "$(which adb)" == "" ];
then
echo “配置adb”
sudo curl --create-dirs -L -o /etc/udev/rules.d/51-android.rules -O -L https://raw.githubusercontent.com/snowdream/51-android/master/51-android.rules
sudo chmod 644   /etc/udev/rules.d/51-android.rules
sudo chown root /etc/udev/rules.d/51-android.rules
sudo service udev restart
adb kill-server
sudo killall adb
fi

if [ ! "$(which fastboot)" == "/usr/bin/fastboot" ];
then
echo “修复fastboot权限”
sudo chown root:root /usr/bin/fastboot
sudo chmod +s /usr/bin/fastboot
fi

if [ -d $HOME/bin ];
then
echo “安装repo”
curl https://raw.githubusercontent.com/akhilnarang/scripts/master/utils/repo > $HOME/bin/repo
chmod a+x $HOME/bin/repo
else
mkdir -p $HOME/bin
curl https://raw.githubusercontent.com/akhilnarang/scripts/master/utils/repo > $HOME/bin/repo
chmod a+x $HOME/bin/repo
fi

echo “修复Linux Mint18.1下搜狗输入法的正常使用”
sudo apt install fcitx-config-gtk fcitx-config-gtk2 fcitx-frontend-all fcitx-frontend-fbterm fcitx-libs-gclient fcitx-libs-qt5 fcitx-module-lua fcitx-tools fcitx-ui-light gir1.2-fcitx-1.0 -y

