#!/bin/sh

#Changes necessary for building webkit
export RICHMOND_ROOT=$HOME/Coding/browser
export QCONF_OVERRIDE=$RICHMOND_ROOT/qconf-override.mk
export BINDING_CMAKE_ARGS="-DQT_QMAKE_EXECUTABLE=/opt/local/bin/qmake"

# WebKit Tools and Scripts
export PATH=$PATH:$RICHMOND_ROOT/webkit/WebKitTools/Scripts:$RICHMOND_ROOT/webkit/Tools/Scripts:$RICHMOND_ROOT/platform/tools/pb

#Adds SVN information for building webkit
export SVN_HOSTNAME=http://svnmirror.rim.net/svn/deckard-65x
export SVN_USERNAME=jheifetz@blackberry.com

#Ice-Cream Compiling for WebKit
#    export USE_ICECC=yes
#    export ICECC_CC=qcc
#    export ICECC_CXX=qcc
#    ICECC_VERSION=i686:$RICHMOND_ROOT/platform/tools/qnx-sdk-linux-universal-thumb-fix.tar.bz2,x86_64
#    ICECC_VERSION=$ICECC_VERSION:$RICHMOND_ROOT/platform/tools/qnx-sdk-linux-universal-thumb-fix.tar.bz2,Darwin10_i386
#    ICECC_VERSION=$ICECC_VERSION:$RICHMOND_ROOT/platform/tools/qnx-sdk-mac-universal-thumb-fix.tar.bz2,Darwin10_x86_64
#    ICECC_VERSION=$ICECC_VERSION:$RICHMOND_ROOT/platform/tools/qnx-sdk-mac-universal-thumb-fix.tar.bz2
#    export ICECC_VERSION
#    export USE_SCHEDULER=icecreambox.rim.net
#    export PATH=/opt/icecream/bin:/opt/icecream/sbin:$PATH
