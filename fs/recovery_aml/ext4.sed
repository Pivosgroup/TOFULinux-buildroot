/##Compiler will insert mount commands##/c\
  #\
  echo "S10setup: moving /media"\
  # /media is where usb drives mount, move it to /tmp and bind\
  if [ ! -d /tmp/media ]; then\
    mkdir -p /tmp/media\
    cp -a /media /tmp/\
    mount -o bind /tmp/media /media\
  fi\
  #\
\
  echo "S10setup: moving /etc"\
  # /etc must be rw, move it to /tmp and bind\
  mkdir -p /tmp/etc\
  cp -a /etc /tmp/\
  mount -o bind /tmp/etc /etc\
  #\
\
  # Check if sdcard mount point exists\
  echo "S10setup: Setting up Sdcard"\
  if [ ! -d /media/sdcard ] ; then\
    mkdir -p /media/sdcard\
  fi\
  # Check if sdcard or usb mounted, if not try to mount it\
  if ! grep -qs '/media/sdcard/' /proc/mounts; then\
    if [ -e "/dev/cardblksd1" ]; then\
      echo "S10setup: SDCard /dev/cardblksd1 mounted as /media/sdcard"\
      /bin/mount -o rw,sync,noatime /dev/cardblksd1 /media/sdcard\
      echo "/dev/cardblksd1	/media/sdcard	vfat	rw,sync	0	0" >> /etc/fstab\
    elif [ -e "/dev/cardblksd" ]; then\
      echo "S10setup: SDCard /dev/cardblksd mounted as /media/sdcard"\
      /bin/mount -o rw,sync,noatime /dev/cardblksd /media/sdcard\
      echo "/dev/cardblksd	/media/sdcard	vfat	rw,sync	0	0" >> /etc/fstab\
    else\
      echo "S10setup:  No SDCard found"\
      sleep 2\
      if [ -e "/dev/sda1" ]; then\
	    echo "S10setup: USB /dev/sda1 mounted as /media/sdcard"\
	    /bin/mount -o rw,sync,noatime /dev/sda1 /media/sdcard\
	    echo "/dev/sda1	/media/sdcard	vfat	rw,sync	0	0" >> /etc/fstab\
      else\
	    echo "S10setup:  No USB found"\
	  fi\
    fi\
  fi\
\
  # Test if SDCard is mounted\
  if grep -qs '/media/sdcard' /proc/mounts; then\
    # Check if we should keep running S94kodi-pre mount scripts\
    SDCARD_MOUNTED=1\
  else\
    SDCARD_MOUNTED=0\
  fi\
\
  USERDATA=/dev/data\
  e2fsck -y $USERDATA\
\
  # Make /tmp/userdata mount point\
  mkdir -p /tmp/userdata\
\
  echo "S10Setup: checking for kodi-data"\
  # Check if kodi-data exists on sdcard\
  # this is an horrible way to this, but only way to do case insensitve match in this shell\
  if [ $SDCARD_MOUNTED -eq 1 ]; then\
    # do directory list to see if it exists\
    KODI_DATA_PATH="`ls -dp /media/sdcard/* | fgrep -i "/media/sdcard/kodi-data/"`"\
    # if not equal zero then set userdata path variable\
    if [[ ! -z $KODI_DATA_PATH ]]; then\
      SDCARD_KODI_DATA=1\
      KODI_USERDATA_PATH=$KODI_DATA_PATH"userdata"\
    else\
      SDCARD_KODI_DATA=0\
    fi\
  else\
    SDCARD_KODI_DATA=0\
  fi\
\
  # Check if user-data on sdcard\
  if [[ $SDCARD_KODI_DATA -eq 1 && -d $KODI_USERDATA_PATH ]]; then\
    echo "S10Setup: Found userdata directory on sdcard"\
    SDCARD_USERDATA=1\
  else\
    SDCARD_USERDATA=0\
  fi\
\
  # if kodi-data exists on sdcard\
  # but userdata doesn't exist, then copy data to sdcard\
  echo "S10Setup: Checking if should copy userdata"\
  if [[ $SDCARD_KODI_DATA -eq 1 && $SDCARD_USERDATA -eq 0 ]]; then\
    # Temporarily mount userdata\
    mount -t ext4 $USERDATA /tmp/userdata\
    if [ -f /usr/share/splash/copying.fb.lzo ]; then\
      lzopcat /usr/share/splash/copying.fb.lzo > /dev/fb0\
    fi\
    echo "S10Setup: Copying userdata"\
    # turn cache back on speed this up\
    mount -o remount,async /media/sdcard\
    cp -rp /tmp/userdata $KODI_USERDATA_PATH\
    if [ $? -neq 0 ] ; then\
      echo "S10setup: Copying Error"\
    else\
      echo "S10setup: Data Copied to card"\
      SDCARD_USERDATA=1\
    fi\
    sync\
    # turn cache back off for safety\
    mount -o remount,sync /media/sdcard\
    umount /tmp/userdata\
  fi\
\
  if [ $SDCARD_USERDATA -eq 1 ]; then\
    echo "S10setup: Found userdata on sdcard, mounting"\
    mount -o bind $KODI_USERDATA_PATH /tmp/userdata\
    mkdir -p /tmp/userdata.internal\
    mount -t ext4 $USERDATA /tmp/userdata.internal\
    # fix tmp directory, needs to be on ext for sockets\
    if [ ! -d "/tmp/userdata.internal/xios/root/.kodi/temp" ]; then\
      mkdir -p /tmp/userdata.internal/xios/root/.kodi/temp\
    fi\
    # bind tmp on mtd to temp on sdcard to account for sockets on fs\
    mount -o bind /tmp/userdata.internal/xios/root/.kodi/temp /tmp/userdata/xios/root/.kodi/temp\
  else\
    echo "S10setup: mounting userdata"\
    mount -t ext4 $USERDATA /tmp/userdata\
  fi\
\
  # if root dir doesn't exist then make it\
  if [ ! -d "/tmp/userdata/xios/root" ]; then\
    mkdir -p /tmp/userdata/xios/root\
  fi\
\
  # Make sure temp directory is created\
  if [ ! -d "/tmp/userdata/xios/root/.kodi/temp" ]; then\
    mkdir -p /tmp/userdata/xios/root/.kodi/temp\
  fi\
\
  # setup root dir\
  mount -o bind /tmp/userdata/xios/root /root\
\
  if [ $SDCARD_USERDATA -eq 1 ]; then\
    mount -o bind /tmp/userdata.internal/xios/root/.kodi/temp /root/.kodi/temp\
  fi\
  #\
  echo "S10setup: remount / ro"\
  mount -o remount,ro /
