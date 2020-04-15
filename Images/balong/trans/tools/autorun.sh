#!/system/bin/busybox sh

mkdir bin
ln -s /system/bin/sh /bin/sh

busybox echo 0 > /proc/sys/net/netfilter/nf_conntrack_checksum

/app/webroot/webui_init1.sh

insmod /system/xbin/kpatch.ko addr=g_bAtDataLocked data=0,0,0,0 2> /dev/null

insmod /system/xbin/kpatch.ko addr=nv_readEx off=0x154 data=0xBF,0xFF,0xFF,0xEA 2> /dev/null
insmod /system/xbin/kpatch.ko addr=nv_writeEx off=0x54 data=0x00,0x00,0xA0,0xE1 2> /dev/null

/system/etc/fix_ttl.sh

/etc/huawei_process_start

grep -q "root::" /system/etc/passwd
if [ $? -eq 1 ]; then
	if [ ! -d /data/root-home ]; then
		mkdir /data/root-home
	fi
	if [ ! -f /data/root-home/.profile ]; then
		echo "cd /" > /data/root-home/.profile
	fi
	echo -e "#!/bin/sh\n\nbusybox login -p" > /sbin/login.sh
	chmod 777 /sbin/login.sh
	busybox telnetd -l /sbin/login.sh
else
	busybox telnetd -l /bin/sh
	adbd &
fi

uid=`busybox cut -d : -f3 /system/etc/passwd`
if [ $? -eq 0 ]; then
	if [ $uid != "0" ]; then
		mount -o remount,rw /system
		busybox sed -i "s/$uid/0/" /system/etc/passwd
		mount -o remount,ro /system
	fi
fi

/app/webroot/webui_init2.sh
/app/webroot/webui_init.sh
atc "AT^NVWREX=8268,0,12,1,0,0,0,2,0,0,0,A,0,0,0"