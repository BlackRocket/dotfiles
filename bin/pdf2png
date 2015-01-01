#!/bin/bash
 
# Colorprofile via http://download.adobe.com/pub/adobe/iccprofiles/win/AdobeICCProfilesWin_end-user.zip
# in ~/ICC
for f in `find . -name "*.pdf"`; do
echo $f
 
convert \
-profile ~/ICC/CMYK/USWebCoatedSWOP.icc \
-profile ~/ICC/RGB/AppleRGB.icc \
-density 480 ${f} -resize 25% \
-set filename:f '%t.%e' \
-flatten \
-colorspace rgb \
-background white \
-depth 8 \
-quality 84 \
PNG:'%[filename:f].png'
 
done;