%module icu4go
%{
#include <unicode/uenum.h>

struct UEnumeration {
    inline void Close() {
        uenum_close(this);
    }
    
    inline int32_t Count(UErrorCode* err) {
        return uenum_count(this, err);
    }

    inline bool Next(_icu4go_gobyteslice_* result, UErrorCode* err) {
        UErrorCode _err = U_ZERO_ERROR;
        int32_t resultLength;
        const char* _result(uenum_next(this, &resultLength, &_err));
        if (U_SUCCESS(_err)) {
            if (!_result)
                return false;
            *result = _icu4go_rawbyteslice(resultLength);
            memcpy(result->array, _result, resultLength);
            return true;
        } else {
            *err = _err;
            return false; 
        }
    }

    inline bool UNext(_gostring_* result, UErrorCode* err) {
        UErrorCode _err = U_ZERO_ERROR;
        int32_t resultLength;
        const UChar* _result(uenum_unext(this, &resultLength, &_err));
        if (U_SUCCESS(_err)) {
            if (!_result)
                return false;
            int32_t l = _icu4go_utf8_len(_result, resultLength);
            result->p = (char *)_swig_goallocate(l + 1);
            result->n = l;
            u_strToUTF8(result->p, l, &l, _result, resultLength, &_err);
            return true;
        } else {
            *err = _err;
            return false; 
        }
    }

    inline void Reset(UErrorCode* err) {
        uenum_reset(this, err);
    }
};
%}

%rename(_UEnumeration) UEnumeration;
struct UEnumeration {
    void Close();
    int32_t Count(UErrorCode* err);
    bool Next(_icu4go_gobyteslice_* result, UErrorCode* err);
    bool UNext(_gostring_* result, UErrorCode* err);
    void Reset(UErrorCode* err);
};

%insert(go_wrapper) %{
type UEnumeration interface {
    Close() int;
    Count(err *UErrorCode) int32;
    Next(result *[]byte, err *UErrorCode) bool
    UNext(result *string, err *UErrorCode) bool;
    Reset(err *UErrorCode);
}
%}
