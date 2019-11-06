#################################
#Notes
#################################
#1. This script will install
#	- ACE
#	- KINC

#################################
#update the system, get it ready to install
#################################
sudo apt-get update -y
sudo apt-get upgrade -y

#################################
#ACE prereqs
#################################
sudo apt-get install gcc -y
sudo apt-get install g++ -y
sudo apt-get install mpic++ -y
sudo apt-get install make -y
sudo apt-get install qt5-default -y

#################################
#KINC prereqs
#################################
sudo apt-get install libgsl-dev -y
sudo apt-get install libopenblas-dev -y
sudo apt-get install libopenmpi-dev -y
sudo apt-get install ocl-icd-opencl-dev -y
sudo apt-get install liblapacke-dev -y
sudo apt-get install nvidia-cuda-dev -y

#################################
#repo prereqs for KINC
#################################
git clone -b master --single-branch https://github.com/kthohr/stats ~/stats
sudo cp -R ~/stats/include/* /usr/local/include

git clone https://github.com/kthohr/gcem.git ~/gcem
sudo cp -R ~/gcem/include/* /usr/local/include

#################################
#ACE install (develop branch)
#################################
#clone ACE repo
git clone https://github.com/SystemsGenetics/ACE.git ~/ACE
cd ~/ACE/build
git checkout develop

#set up for build
export ACE_VERSION=v3.1.0
export INSTALL_PREFIX="~/software"
qmake ../src/ACE.pro PREFIX=$INSTALL_PREFIX/ACE-$ACE_VERSION

#build ACE
make qmake_all
make
make qmake_all
sudo make install

#append to .bashrc
echo "" >> ~/.bashrc
echo "#ACE include paths" >> ~/.bashrc
echo "export PATH=$INSTALL_PREFIX/ACE-$ACE_VERSION/bin:\$PATH" >> ~/.bashrc
echo "export CPLUS_INCLUDE_PATH=$INSTALL_PREFIX/ACE-$ACE_VERSION/include:\$CPLUS_INCLUDE_PATH" >> ~/.bashrc
echo "export LIBRARY_PATH=$INSTALL_PREFIX/ACE-$ACE_VERSION/lib:\$LIBRARY_PATH" >> ~/.bashrc
echo "export LD_LIBRARY_PATH=$INSTALL_PREFIX/ACE-$ACE_VERSION/lib:\$LD_LIBRARY_PATH" >> ~/.bashrc
echo "export CPATH=$INSTALL_PREFIX/ACE-$ACE_VERSION/include:\$CPATH" >> ~/.bashrc
echo "export C_INCLUDE_PATH=$INSTALL_PREFIX/ACE-$ACE_VERSION/include:\$C_INCLUDE_PATH" >> ~/.bashrc
echo "export OBJC_INCLUDE_PATH=$INSTALL_PREFIX/ACE-$ACE_VERSION/include:\$OBJC_INCLUDE_PATH" >> ~/.bashrc

#append to .profile
echo "" >> ~/.bashrc
echo "#ACE include paths" >> ~/.profile
echo "export PATH=$INSTALL_PREFIX/ACE-$ACE_VERSION/bin:\$PATH" >> ~/.profile
echo "export CPLUS_INCLUDE_PATH=$INSTALL_PREFIX/ACE-$ACE_VERSION/include:\$CPLUS_INCLUDE_PATH" >> ~/.profile
echo "export LIBRARY_PATH=$INSTALL_PREFIX/ACE-$ACE_VERSION/lib:\$LIBRARY_PATH" >> ~/.profile
echo "export LD_LIBRARY_PATH=$INSTALL_PREFIX/ACE-$ACE_VERSION/lib:\$LD_LIBRARY_PATH" >> ~/.profile
echo "export CPATH=$INSTALL_PREFIX/ACE-$ACE_VERSION/include:\$CPATH" >> ~/.profile
echo "export C_INCLUDE_PATH=$INSTALL_PREFIX/ACE-$ACE_VERSION/include:\$C_INCLUDE_PATH" >> ~/.profile
echo "export OBJC_INCLUDE_PATH=$INSTALL_PREFIX/ACE-$ACE_VERSION/include:\$OBJC_INCLUDE_PATH" >> ~/.profile

#set env to see ACE libs
export PATH=$INSTALL_PREFIX/ACE-$ACE_VERSION/bin:$PATH
export CPLUS_INCLUDE_PATH=$INSTALL_PREFIX/ACE-$ACE_VERSION/include:$CPLUS_INCLUDE_PATH
export LIBRARY_PATH=$INSTALL_PREFIX/ACE-$ACE_VERSION/lib:$LIBRARY_PATH
export LD_LIBRARY_PATH=$INSTALL_PREFIX/ACE-$ACE_VERSION/lib:$LD_LIBRARY_PATH
export CPATH=$INSTALL_PREFIX/ACE-$ACE_VERSION/include:$CPATH
export C_INCLUDE_PATH=$INSTALL_PREFIX/ACE-$ACE_VERSION/include:$C_INCLUDE_PATH
export OBJC_INCLUDE_PATH=$INSTALL_PREFIX/ACE-$ACE_VERSION/include:$OBJC_INCLUDE_PATH

cd ~/

#################################
#KINC install
#################################
export KINC_VERSION=v3.3.0

#clone repo
git clone https://github.com/SystemsGenetics/KINC.git ~/KINC
cd ~/KINC/build
git checkout $KINC_VERSION

#build KINC
qmake ../src/KINC.pro PREFIX=$INSTALL_PREFIX/KINC-$KINC_VERSION
make qmake_all
make
make qmake_all
sudo make install

#append to .bashrc
echo "" >> ~/.bashrc
echo "#KINC include paths" >> ~/.bashrc
echo "export LD_LIBRARY_PATH=$INSTALL_PREFIX/KINC-$KINC_VERSION/lib:\$LD_LIBRARY_PATH" >> ~/.bashrc
echo "export PATH=$INSTALL_PREFIX/KINC-$KINC_VERSION/bin:\$PATH" >> ~/.bashrc

#append to .profile
echo "" >> ~/.profile
echo "#KINC include paths" >> ~/.profile
echo "export LD_LIBRARY_PATH=$INSTALL_PREFIX/KINC-$KINC_VERSION/lib:\$LD_LIBRARY_PATH" >> ~/.profile
echo "export PATH=$INSTALL_PREFIX/KINC-$KINC_VERSION/bin:\$PATH" >> ~/.profile

#set env to see KINC
export LD_LIBRARY_PATH=$INSTALL_PREFIX/KINC-$KINC_VERSION/lib:$LD_LIBRARY_PATH >> ~/.bashrc
export PATH=$INSTALL_PREFIX/KINC-$KINC_VERSION/bin:$PATH >> ~/.bashrc

cd ~/
