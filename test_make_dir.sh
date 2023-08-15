#!/bin/bash

# Source File Convention : [monimo_mart]_06.csv
# Convert File Convention : [monimo_mart]_utf8_06.csv


# convention Dir struct
# $MONTH
#  $MONTH/dir:
#   [monimo_mart]_$MONTH.csv

echo -n '사번 : '
read C_NUM

SOURCE_PATH='/Users/ktyeye/Desktop/sslife/ADW/scripts/source_dir'
DEST_PATH='/Users/ktyeye/Desktop/sslife/ADW/scripts/dest_dir'

echo -n 'MONTH : '
read MONTH

SOURCE_DIR=$SOURCE_PATH/$C_NUM/$MONTH

if [ ! -d $SOURCE_DIR ]; then
    echo $SOURCE_DIR
    echo "\n======SOURCE_DIR IS NOT EXIST======"
    mkdir -p $SOURCE_DIR:
    exit 
fi

echo "Make DEST_DIR .."
DEST_DIR=$DEST_PATH/$MONTH
if [ ! -d $DEST_DIR ]; then
    mkdir -p $DEST_DIR
fi


FILE_DIR=$SOURCE_DIR
TARGET_DIR=$DEST_DIR
for VAR in $(ls -RF $SOURCE_DIR)
do
    # Type Check
    # : is DIRECTORY -> inside
    # / is DIRECTORY -> continue
    # else is FILE
    LAST_CHAR=${VAR: -1}
    if [ ':' == $LAST_CHAR ]; then
        echo $VAR' is Directory'
        FILE_DIR=$(echo $VAR | sed 's/.$//')
        echo 'file : '$FILE_DIR
        TARGET_DIR=$DEST_DIR/$(echo $FILE_DIR | sed s@.*/$MONTH/@@)
        echo 'target : '$TARGET_DIR
        mkdir -p $TARGET_DIR

    elif [ '/' == $LAST_CHAR ]; then
        echo $VAR' is DIR.. SKIP'
        continue

    else
        echo $VAR' is File .. Convert..'
        echo 'file DIR: '$FILE_DIR
        VAR_PATH=$FILE_DIR/$VAR
        echo 'VAR_PATH: '$VAR_PATH
        if [ ! -f $VAR_PATH ]; then
            echo '=======NO FILE EXIST======'
            continue
        fi
        file -bi $VAR_PATH
        echo $VAR_PATH ' to ' $TARGET_DIR
        cp $VAR_PATH $TARGET_DIR

        FILE_NAME=$(echo $VAR | sed s/_$MONTH/_utf8_$MONTH/g)
        iconv -c -f euc-kr -t utf8 $TARGET_DIR/$VAR > $TARGET_DIR/$FILE_NAME
        e -n 'Changed Encoding : '
        file -bi $TARGET_DIR/$FILE_NAME
    fi
done



