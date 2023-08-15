#!/bin/bash

# SOURCE_HOME='/home/bdaadm/{COMPANY_NUM}'
# TARGET_HOME='/DATA/monimo'

# TEST PATH
export SOURCE_HOME='/Users/ktyeye/Desktop/sslife/ADW/scripts/source_dir'
export TARGET_HOME='/Users/ktyeye/Desktop/sslife/ADW/scripts/dest_dir'

export CONVENTION_PATH='{SPECIFY}/{GRADE}/{YEAR}/{MONTH}'

SPECIFY=("card" "fire" "sec" "life")
export GRADE='first_grade'
export DATE='202306'
export COMPANY_NUM='1000031586'

# 정합성 검증
YEAR=${DATE: 0: 4}
MONTH=${DATE: 4}
# make SOURCE_PATH & TARGET_PATH
export SOURCE_PATH=$(echo $SOURCE_HOME/$CONVENTION_PATH | 
                sed s/{COMPANY_NUM}/$COMPANY_NUM/g |
                sed s/{GRADE}/$GRADE/g |
                sed s/{YEAR}/$YEAR/g   |
                sed s/{MONTH}/$MONTH/g
            )

export TARGET_PATH=$(echo $TARGET_HOME/$CONVENTION_PATH | 
                sed s/{GRADE}/$GRADE/g |
                sed s/{YEAR}/$YEAR/g   |
                sed s/{MONTH}/$MONTH/g 
            )
# echo $SOURCE_PATH
# echo $TARGET_PATH


# convention
# monimo/업권/first_grade/$YEAR/$MONTH/monimo_mart_업권_monthly_yymm.csv
for SPEC in "${SPECIFY[@]}"; do
    S_TEMP=$(echo $SOURCE_PATH | sed s/{SPECIFY}/$SPEC/g)
    T_TEMP=$(echo $TARGET_PATH | sed s/{SPECIFY}/$SPEC/g)

    if [ ! -d $S_TEMP ]; then
        echo 'SOURCE_PATH NOT EXIST mkdir '$S_TEMP
        mkdir -p $S_TEMP
    fi
    
    if [ ! -d $T_TEMP ]; then
        echo 'TARGET_PATH NOT EXIST mkdir '$T_TEMP
        mkdir -p $T_TEMP
    fi
done

tree $SOURCE_HOME
tree $TARGET_HOME

./transport_file.sh