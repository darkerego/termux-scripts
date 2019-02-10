#!/usr/bin/env bash
PREFIX=/data/data/com.termux/files/usr
cat << _EOF_ > $PREFIX/etc/torrc
SocksPort 9050 # what port to advertise for application connections
SocksBindAddress 127.0.0.1 # accept connections only from localhost
#AllowUnverifiedNodes middle,rendezvous
DataDirectory $PREFIX/var/lib/tor
HiddenServiceDir $PREFIX/var/lib/tor
HiddenServicePort 8022 127.0.0.1:8022 # ssh
# HiddenServicePort 80 127.0.0.1:80
_EOF_
