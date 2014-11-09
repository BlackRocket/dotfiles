#!/bin/bash
#ocrpdftotext
# Simplified implementation of http://ubuntuforums.org/showthread.php?t=880471
# http://fransdejonge.com/2012/04/ocr-text-in-pdf-with-tesseract/

# Might consider doing something with getopts here, see http://wiki.bash-hackers.org/howto/getopts_tutorial
DPI=300
TESS_LANG=deu

FILENAME=${@%.pdf}
SCRIPT_NAME=`basename "$0" .sh`
TMP_DIR=${SCRIPT_NAME}-tmp
OUTPUT_FILENAME=${FILENAME}-output@DPI${DPI}

mkdir ${TMP_DIR}
cp ${@} ${TMP_DIR}
cd ${TMP_DIR}

convert -density ${DPI} -depth 8 ${@} "${FILENAME}.tif"
tesseract "${FILENAME}.tif" "${OUTPUT_FILENAME}" -l ${TESS_LANG}

mv ${OUTPUT_FILENAME}.txt ..
rm *
cd ..
rmdir ${TMP_DIR}