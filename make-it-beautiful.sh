#!/bin/bash

ttffont=$1

if [ -z "${ttffont}" ]; then
    echo "Usage: $0 path-to-ttf-font"
    exit 1
fi

APK_NAME="build/the-ugly-douban-read.apk"
URL="http://www.douban.com/j/app/apk?app_name=book_android"

mkdir -p build
wget -c ${URL} -O ${APK_NAME}

[ -d build/douban-read ] && rm -rf build/douban-read
java -jar utils/apktool.jar d ${APK_NAME} build/douban-read

cp ${ttffont} build/fzlth.ttf
cp ${ttffont} build/fzlthb.ttf
cd build
zip fzlth.jpg fzlth.ttf
zip fzlthb.jpg fzlthb.ttf

cp *jpg douban-read/assets/font

cd ..
cp pics/black.png build/douban-read/res/drawable-hdpi/bg_black.png
cp pics/white.png build/douban-read/res/drawable-hdpi/bg_white.png

java -jar utils/apktool.jar b build/douban-read build/douban-read_unsigned.apk >/dev/null
java -jar utils/signapk.jar utils/certificate.pem utils/key.pk8 build/douban-read_unsigned.apk build/douban-read_signed.apk

echo
if [ -f build/douban-read_signed.apk ]; then
    echo "The beautiful douban read is ready: build/douban-read_signed.apk"
else
    echo "Failed beautifying douban read"
fi
