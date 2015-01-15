%module icu4go
%{
#include <unicode/strenum.h>

struct _StringEnumeration {
    _StringEnumeration(StringEnumeration* impl = 0): impl_(impl) {}

    inline void Close() {
        delete impl_;
    }

    inline int32_t Count(UErrorCode* err) {
        return impl_->count(*err);
    }

    inline _StringEnumeration Clone() const {
        return _StringEnumeration(impl_->clone());
    }

    inline bool Next(_icu4go_gobyteslice_* result, UErrorCode* err) {
        UErrorCode _err = U_ZERO_ERROR;
        int32_t resultLength;
        const char* _result(impl_->next(&resultLength, _err));
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
        const UChar* _result(impl_->unext(&resultLength, _err));
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
        impl_->reset(*err);
    }

    inline bool Equals(_StringEnumeration that) const {
        return (*that.impl_) == (*that.impl_);
    }

    inline operator StringEnumeration*() const {
        return impl_;
    }
private:
    StringEnumeration* impl_;
};

%}

%nodefaultctor _StringEnumeration;
struct _StringEnumeration {
    void Close();
    _StringEnumeration Clone() const;
    int32_t Count(UErrorCode* err);
    bool Next(_icu4go_gobyteslice_* result, UErrorCode* err);
    bool UNext(_gostring_* result, UErrorCode* err);
    void Reset(UErrorCode* err);
    bool Equals(_StringEnumeration that) const;
};
