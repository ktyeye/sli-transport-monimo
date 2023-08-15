
SOURCE_FILE_CONVENTION='monimo_mart_{SPECIFY}_monthly_{YYMM}.csv'
TARGET_FILE_CONVENTION='monimo_mart_{SPECIFY}_monthly_utf8_{YYMM}.csv'
YYMM=${DATE: 2: 6}
SPECIFY=("card" "fire" "sec" "life")

    
for SPEC in "${SPECIFY[@]}"; do
    SOURCE_TEMP=$(echo $SOURCE_PATH | sed s/{SPECIFY}/$SPEC/g)
    TARGET_TEMP=$(echo $TARGET_PATH | sed s/{SPECIFY}/$SPEC/g)
    SOURCE_FILE_NAME=$(echo $SOURCE_FILE_CONVENTION |
                    sed s/{SPECIFY}/$SPEC/g |
                    sed s/{YYMM}/$YYMM/g
                )
    
    TARGET_FILE_NAME=$(echo $TARGET_FILE_CONVENTION |
                    sed s/{SPECIFY}/$SPEC/g |
                    sed s/{YYMM}/$YYMM/g
                )
    SOURCE_LOCATION=$SOURCE_TEMP/$SOURCE_FILE_NAME
    TARGET_LOCATION=$TARGET_TEMP/$TARGET_FILE_NAME
    if [ ! -f $SOURCE_LOCATION ]; then
        echo 'SOURCE FILE NOT EXIST!'
        echo 'FILE_NAME : '$SOURCE_FILE_NAME
        # test code
        # touch "test, 1" > $SOURCE_LOCATION
        exit
    fi

    echo "CONVERT SOURCE FILE..\n"
    echo -n $SOURCE_FILE_NAME': '
    file -bi $SOURCE_LOCATION
    iconv -c -f euc-kr -t utf8 $SOURCE_LOCATION > $TARGET_LOCATION
    echo -n $TARGET_FILE_CONVENTION': '
    file -bi $TARGET_LOCATION

    # line count
    echo "COUNT LINE .."
    wc -l $SOURCE_LOCATION
    wc -l $TARGET_LOCATION
done

tree $SOURCE_HOME
tree $TARGET_HOME