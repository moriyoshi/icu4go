%module icu4go
%{
#include <unicode/normalizer2.h>
%}

%rename(Normalizer2) icu::Normalizer2;
%nodefaultctor Normalizer2;
%nodefaultdtor Normalizer2;
struct Normalizer2 {
    static const Normalizer2 *getNFCInstance(UErrorCode &errorCode);
    static const Normalizer2 *getNFDInstance(UErrorCode &errorCode);
    static const Normalizer2 *getNFKCInstance(UErrorCode &errorCode);
    static const Normalizer2 *getNFKDInstance(UErrorCode &errorCode);
    static const Normalizer2 *getNFKCCasefoldInstance(UErrorCode &errorCode);
    static const Normalizer2 *getInstance(const char *packageName, const char *name, UNormalization2Mode mode, UErrorCode &errorCode);
    icu::UnicodeString normalize(const icu::UnicodeString &src, UErrorCode &errorCode) const;
    UBool getDecomposition(UChar32 c, icu::UnicodeString &decomposition) const;
    UBool getRawDecomposition(UChar32 c, icu::UnicodeString &decomposition) const;
    UChar32 composePair(UChar32 a, UChar32 b) const;
    uint8_t getCombiningClass(UChar32 c) const;
    UBool isNormalized(const icu::UnicodeString &s, UErrorCode &errorCode) const;
    virtual UNormalizationCheckResult quickCheck(const icu::UnicodeString &s, UErrorCode &errorCode) const;
    int32_t spanQuickCheckYes(const icu::UnicodeString &s, UErrorCode &errorCode) const;
    UBool hasBoundaryBefore(UChar32 c) const;
    UBool hasBoundaryAfter(UChar32 c) const;
    UBool isInert(UChar32 c) const;
};
