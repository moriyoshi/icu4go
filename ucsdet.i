%module icu4go
%{
#include <unicode/ucsdet.h>

extern "C" {
extern void _icu4go__makeUCharsetMatchSlice(void *a, int n);

typedef _goslice_ _icu4go_UCharsetMatch_slice_;

static _icu4go_UCharsetMatch_slice_ _icu4go_makeUCharsetMatchSlice(int len, int cap)
{
    struct {
        intgo len;
        intgo cap;
        _goslice_ ret;
    } a = { len, cap };
    crosscall2(_icu4go__makeUCharsetMatchSlice, &a, (int)sizeof(a));
    return a.ret;
}
}

struct UCharsetDetector {
    inline static UCharsetDetector* Open(UErrorCode *err) {
        return ucsdet_open(err);
    }

    inline void Close() {
        ucsdet_close(this);
    }

    inline void SetText(_icu4go_gobyteslice_ text, UErrorCode *err) {
        ucsdet_setText(this, (char *)text.array, text.len, err);
    }

    inline void SetDeclaredEncoding(_icu4go_gobyteslice_ encoding, UErrorCode *err) {
        ucsdet_setDeclaredEncoding(this, (char *)encoding.array, encoding.len, err);
    }

    inline const UCharsetMatch *Detect(UErrorCode *err) {
        return ucsdet_detect(this, err);
    }

    inline _icu4go_UCharsetMatch_slice_ DetectAll(UErrorCode *err) {
        UErrorCode _err = U_ZERO_ERROR;
        int32_t matchesFound;
        const UCharsetMatch **result(ucsdet_detectAll(this, &matchesFound, &_err));
        if (U_SUCCESS(_err)) {
            _icu4go_UCharsetMatch_slice_ retval(_icu4go_makeUCharsetMatchSlice(matchesFound, matchesFound));
            for (int32_t i = 0; i < matchesFound; i++)
                ((const UCharsetMatch **)retval.array)[i] = result[i];
            return retval;
        } else {
            *err = _err;
            return _icu4go_makeUCharsetMatchSlice(0, 0);
        }
    }

    inline UEnumeration *GetAllDetectableCharsets(UErrorCode *err) const {
        return ucsdet_getAllDetectableCharsets(this, err);
    }

    inline bool IsInputFilterEnabled() const {
        return ucsdet_isInputFilterEnabled(this);
    }

    inline void EnableInputFilter(bool filter) {
        ucsdet_enableInputFilter(this, filter);
    }
};

struct UCharsetMatch {
    inline const char *GetName(UErrorCode *err) const {
        return ucsdet_getName(this, err);
    }

    inline int32_t GetConfidence(UErrorCode *err) const {
        return ucsdet_getConfidence(this, err);
    }

    inline const char *GetLanguage(UErrorCode *err) const {
        return ucsdet_getLanguage(this, err);
    }
};

%}

%insert(gc_header) %{
extern void ·makeUCharsetMatchSlice(void);

#pragma cgo_export_static _icu4go__makeUCharsetMatchSlice
#pragma textflag NOSPLIT
void _icu4go__makeUCharsetMatchSlice(void *a, int32 n)
{
    runtime·cgocallback(·makeUCharsetMatchSlice, a, n);
}
%}

%insert(go_wrapper) %{
func makeUCharsetMatchSlice(l int, c int) []SwigcptrUCharsetMatch {
    return make([]SwigcptrUCharsetMatch, l, c)
}
%}

%typemap(gotype) _icu4go_UCharsetMatch_slice_ %{[]SwigcptrUCharsetMatch%}
%typemap(in) _icu4go_UCharsetMatch_slice_ %{
    $1 = $input;
%}
%typemap(out) _icu4go_UCharsetMatch_slice_ %{
    $result = $1;
%}

%nodefaultctor UCharsetDetector;
%nodefaultdtor UCharsetDetector;
struct UCharsetDetector {
    static UCharsetDetector* Open(UErrorCode *err);
    void Close();
    void SetText(_icu4go_gobyteslice_ text, UErrorCode *err);
    void SetDeclaredEncoding(_icu4go_gobyteslice_ encoding, UErrorCode *err);
    const UCharsetMatch *Detect(UErrorCode *err);
    _icu4go_UCharsetMatch_slice_ DetectAll(UErrorCode *err);
    UEnumeration *GetAllDetectableCharsets(UErrorCode *err) const;
    bool IsInputFilterEnabled() const;
    void EnableInputFilter(bool filter);
};

%nodefaultctor UCharsetMatch;
struct UCharsetMatch {
    const char *GetName(UErrorCode *err) const;
    int32_t GetConfidence(UErrorCode *err) const;
    const char *GetLanguage(UErrorCode *err) const;
};
