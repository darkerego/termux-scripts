# Accessing Termux System via ADB

    export LD_LIBRARY_PATH=/data/data/com.termux/files/usr/lib
    export LANG=en_US.UTF-8
    export PREFIX=/data/data/com.termux/files/usr
    export HOME=/data/data/com.termux/files/home
    export TMPDIR=/data/data/com.termux/files/usr/tmp
    export SHELL=/data/data/com.termux/files/usr/bin/bash
    export TERM=xterm-256color
    export EXTERNAL_STORAGE=/sdcard
    export PATH=$PATH:/data/data/com.termux/files/usr/bin:/data/data/com.termux/files/usr/bin/applets:/data/com.termux/files/home/bin
    export LD_PRELOAD=/data/data/com.termux/files/usr/lib/libtermux-exec.so
    export _=/data/data/com.termux/files/usr/bin/env


Now you should be able to run commands like `htop` and `nano` from adb.

TODO: Get this working over Magisk sshd. Currently throws error:

    CANNOT LINK EXECUTABLE "nano": library "libandroid-support.so" not found
