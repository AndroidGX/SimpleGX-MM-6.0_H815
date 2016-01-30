#!/system/bin/sh
# SimpleGX KERNEL init script


BB=/sbin/busybox

$BB mount -t rootfs -o remount,rw rootfs

sync


# -------------
# Cleaning part
# -------------
$BB rm -rf /cache/lost+found/* 2> /dev/null;
$BB rm -rf /data/lost+found/* 2> /dev/null;
$BB rm -rf /data/tombstones/* 2> /dev/null;


# ---------------
# Initialize root
# ---------------
/system/xbin/daemonsu --auto-daemon &


# -----------------
# Initialize init.d
# -----------------
if [ ! -e /system/etc/init.d ]; then
	mkdir /system/etc/init.d
	chown -R root.root /system/etc/init.d
	chmod -R 755 /system/etc/init.d
fi;

$BB run-parts /system/etc/init.d/


# ---------------------------------------------------
# Google Services battery drain fixer by Alcolawl@xda
# ---------------------------------------------------

	pm enable com.google.android.gms/.update.SystemUpdateActivity
	pm enable com.google.android.gms/.update.SystemUpdateService
	pm enable com.google.android.gms/.update.SystemUpdateService$ActiveReceiver
	pm enable com.google.android.gms/.update.SystemUpdateService$Receiver
	pm enable com.google.android.gms/.update.SystemUpdateService$SecretCodeReceiver
	pm enable com.google.android.gsf/.update.SystemUpdateActivity
	pm enable com.google.android.gsf/.update.SystemUpdatePanoActivity
	pm enable com.google.android.gsf/.update.SystemUpdateService
	pm enable com.google.android.gsf/.update.SystemUpdateService$Receiver
	pm enable com.google.android.gsf/.update.SystemUpdateService$SecretCodeReceiver


$BB mount -t rootfs -o remount,ro rootfs
$BB mount -o remount,rw /data

