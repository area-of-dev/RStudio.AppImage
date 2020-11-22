# Copyright 2020 Alex Woroschilow (alex.woroschilow@gmail.com)
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
SOURCE="https://download1.rstudio.org/desktop/trusty/amd64/rstudio-1.2.5042-amd64-debian.tar.gz"
DESTINATION="build.tar.gz"
OUTPUT="RStudio.AppImage"


all: clean
	echo "Building: $(OUTPUT)"
	wget -O $(DESTINATION) -c $(SOURCE)
	
	tar -zxvf $(DESTINATION)
	rm -rf AppDir/opt
	
	wget --output-document=build.rpm http://mirror.centos.org/centos/7/os/x86_64/Packages/openssl-libs-1.0.2k-19.el7.x86_64.rpm
	rpm2cpio build.rpm | cpio -idmv

	wget --output-document=build.rpm https://ftp.nluug.nl/pub/os/Linux/distr/pclinuxos/pclinuxos/apt/pclinuxos/64bit/RPMS.x86_64/lib64openssl1.0.0-1.1.0j-2pclos2019.x86_64.rpm
	rpm2cpio build.rpm | cpio -idmv




	mkdir --parents AppDir/rstudio
	mkdir --parents AppDir/lib
	cp -r rstudio-*/* AppDir/rstudio
	cp -r usr/lib64/* AppDir/lib
	

	chmod +x AppDir/AppRun

	export ARCH=x86_64 && bin/appimagetool.AppImage AppDir $(OUTPUT)

clean:
	rm -f $(DESTINATION)
	rm -rf ./rstudio-1.2.5042
	rm -rf ./AppDir/rstudio
	rm -rf ./AppDir/lib
	rm -rf ./*.rpm
	rm -rf ./usr
