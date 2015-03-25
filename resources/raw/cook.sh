#!/bin/bash

cp akasa.svg ../../public/

iconsrc="akasa.svg"
icondir="../icons/"

declare -A iconformats=( \
  [iphone]=60x60 \
  [iphone_2x]=120x120 \
  [iphone_3x]=180x180 \
  [ipad]=72x72 \
  [ipad_2x]=144x144 \
  [android_ldpi]=36x36 \
  [android_mdpi]=48x48 \
  [android_hdpi]=72x72 \
  [android_xhdpi]=96x96 \
)

for i in "${!iconformats[@]}"; do
  convert -background none ${iconsrc} -resize ${iconformats[$i]} ${icondir}$i.png
done

