#!/bin/sh
U_ICU_VERSION_MAJOR_NUM=$(
(g++ -E - | grep -v '^#') <<HERE
#include <unicode/uvernum.h>
U_ICU_VERSION_MAJOR_NUM
HERE
)

echo -n > icu_version.i
echo -n > buildtags
if [ $U_ICU_VERSION_MAJOR_NUM -ge 44 ]; then
    echo "#define ICU4GO_FEATURE_NORMALIZER2 1" >> icu_version.i
    echo "normalizer2" >> buildtags
fi
