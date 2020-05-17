SOURCE="https://download1.rstudio.org/desktop/trusty/amd64/rstudio-1.2.5042-amd64-debian.tar.gz"
DESTINATION="build.tar.gz"
OUTPUT="RStudio.AppImage"


all:
	echo "Building: $(OUTPUT)"
	wget -O $(DESTINATION) -c $(SOURCE)
	
	tar -zxvf $(DESTINATION)
	rm -rf AppDir/opt
	
	wget --output-document=openssl-1.0.rpm --continue http://mirror.centos.org/centos/7/os/x86_64/Packages/openssl-libs-1.0.2k-19.el7.x86_64.rpm
	rpm2cpio openssl-libs-1.0.rpm | cpio -idmv
	
	mkdir --parents AppDir/rstudio
	mkdir --parents AppDir/lib
	cp -r rstudio-1.2.5042/* AppDir/rstudio
	cp -r usr/lib64/* AppDir/lib
	

	chmod +x AppDir/AppRun

	export ARCH=x86_64 && bin/appimagetool.AppImage AppDir $(OUTPUT)

	rm -f $(DESTINATION)
	rm -rf ./rstudio-1.2.5042
	rm -rf ./AppDir/rstudio
	rm -rf ./AppDir/lib
	rm -rf ./*.rpm
	rm -rf ./usr
