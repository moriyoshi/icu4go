%module icu4go
%insert(gc_header) %{

struct FuncVal;

struct _icu4go__UConverterToUCallback_invoke_args {
    struct FuncVal *f;
    intgo a;
};

extern void runtime·cgocallback_gofunc(struct FuncVal *f, void *frame, intgo framesize);

#pragma cgo_export_static _icu4go__UConverterToUCallback_invoke
#pragma cgo_export_dynamic _icu4go__UConverterToUCallback_invoke
#pragma textflag NOSPLIT
void _icu4go__UConverterToUCallback_invoke(void *a, int32 n)
{
    struct _icu4go__UConverterToUCallback_invoke_args *_a = (struct _icu4go__UConverterToUCallback_invoke_args *)a;
    runtime·cgocallback_gofunc(_a->f, &_a->a, n);
}

struct _icu4go__UConverterFromUCallback_invoke_args {
    struct FuncVal *f;
    intgo a;
};

#pragma cgo_export_static _icu4go__UConverterFromUCallback_invoke
#pragma cgo_export_dynamic _icu4go__UConverterFromUCallback_invoke
#pragma textflag NOSPLIT
void _icu4go__UConverterFromUCallback_invoke(void *a, int32 n)
{
    struct _icu4go__UConverterFromUCallback_invoke_args *_a = (struct _icu4go__UConverterFromUCallback_invoke_args *)a;
    runtime·cgocallback_gofunc(_a->f, &_a->a, n);
}
%}
%{
#include <unicode/ucnv.h>
#include <unicode/uset.h>
#include <algorithm>

extern "C" {
extern void _icu4go__UConverterToUCallback_invoke(void *, int);
extern void _icu4go__UConverterFromUCallback_invoke(void *, int);
}

typedef _gofunc_ _gofunc_UConverterFromUCallback;
typedef _gofunc_ _gofunc_UConverterToUCallback;

struct UConverter {
    inline static UConverter* Open(const char* converterName, UErrorCode* err) {
        return ucnv_open(converterName, err);
    }

    inline static UConverter* OpenCCSID(int32_t codepage, UConverterPlatform platform, UErrorCode* err) {
        return ucnv_openCCSID(codepage, platform, err);
    }

    inline static UConverter* OpenPackage(const char *packageName, const char *converterName, UErrorCode *err) {
        return ucnv_openPackage(packageName, converterName, err);
    }

    inline UConverter* SafeClone(UErrorCode *err) const {
        int32_t t = 0;
        return ucnv_safeClone(this, 0, &t, err);
    }

    inline void Close() {
        ucnv_close(this);
    }

    inline _icu4go_gobyteslice_ GetSubstChars(UErrorCode *err) const {
        int8_t l = 127;
        _icu4go_gobyteslice_ retval = _icu4go_rawbyteslice(l);
        UErrorCode _err = U_ZERO_ERROR;
        ucnv_getSubstChars(this, (char *)retval.array, &l, &_err);
        if (U_SUCCESS(_err)) {
            retval.len = l;
        } else {
            retval.len = 0;
            *err = _err;
        }
        return retval;
    }

    inline void SetSubstChars(_icu4go_gobyteslice_ gs, UErrorCode *err) {
        ucnv_setSubstChars(this, (const char *)gs.array, gs.len, err);
    }

    inline void SetSubstString(const icu::UnicodeString& gs, UErrorCode *err) {
        ucnv_setSubstString(this, gs.getBuffer(), gs.length(), err);
    }

    inline _icu4go_gobyteslice_ GetInvalidChars(UErrorCode *err) const {
        int8_t l = 127;
        _icu4go_gobyteslice_ retval = _icu4go_rawbyteslice(l);
        UErrorCode _err = U_ZERO_ERROR;
        ucnv_getInvalidChars(this, (char *)retval.array, &l, &_err);
        if (U_SUCCESS(*err)) {
            retval.len = l;
        } else {
            retval.len = 0;
            *err = _err;
        }
        return retval;
    }

    inline icu::UnicodeString GetInvalidUChars(UErrorCode *err) const {
        icu::UnicodeString retval;
        int8_t l = 127;
        UChar *buf = retval.getBuffer(l);
        ucnv_getInvalidUChars(this, buf, &l, err);
        if (U_SUCCESS(*err))
            retval.releaseBuffer(l);
        else
            retval.releaseBuffer(0);
        return retval;
    }

    inline void Reset() {
        ucnv_reset(this);
    }

    inline void ResetToUnicode() {
        ucnv_resetToUnicode(this);
    }

    inline void ResetFromUnicode() {
        ucnv_resetFromUnicode(this);
    }

    inline int GetMaxCharSize() const {
        return ucnv_getMaxCharSize(this);
    }

    inline int GetMinCharSize() const {
        return ucnv_getMinCharSize(this);
    }

    inline const char *GetName(UErrorCode *err) const {
        return ucnv_getName(this, err);
    }

    inline UnicodeString GetDisplayName(const char *displayLocale, UErrorCode *err) const {
        UErrorCode _err = U_ZERO_ERROR;
        UnicodeString retval;
        UChar* buf(retval.getBuffer(256));
        int32_t l(ucnv_getDisplayName(this, displayLocale, buf, 256, &_err));
        if (U_SUCCESS(_err)) {
            retval.releaseBuffer(l);
        } else {
            retval.releaseBuffer(256);
            *err = _err;
        }
        return retval;
    }

    inline int GetCCSID(UErrorCode *err) const {
        return ucnv_getCCSID(this, err);
    }

    inline UConverterPlatform GetPlatform(UErrorCode *err) const {
        return ucnv_getPlatform(this, err);
    }

    inline UConverterType GetType() const {
        return ucnv_getType(this);
    }

    inline _icu4go_gointslice_ GetStarters(UErrorCode *err) const {
        UBool starters[256];
        UErrorCode _err = U_ZERO_ERROR;
        _icu4go_gointslice_ retval;
        ucnv_getStarters(this, starters, &_err);
        if (U_SUCCESS(_err)) {
            retval = _icu4go_makeintslice(256, 256);
            for (int i = 0; i < 256; i++)
                retval.array[i] = starters[i];
        } else {
            retval = _icu4go_makeintslice(0, 0);
            *err = _err;
        }
        return retval;
    }

    inline USet *GetUnicodeSet(UConverterUnicodeSet whichSet, UErrorCode *err) const {
        USet* retval(uset_openEmpty());
        ucnv_getUnicodeSet(this, retval, whichSet, err);
        if (!U_SUCCESS(*err)) {
            uset_close(retval);
            retval = 0;
        }
        return retval;
    }

    inline void SetFromUCallBack(_gofunc_ *newAction, UErrorCode *err) {
        ucnv_setFromUCallBack(this, &UConverterFromUCallback_invoke, (const void *)newAction, NULL, NULL, err);
    }

    inline void SetToUCallBack(_gofunc_ *newAction, UErrorCode *err) {
        ucnv_setToUCallBack(this, &UConverterToUCallback_invoke, (const void *)newAction, NULL, NULL, err);
    }

    inline void FromUnicode(_icu4go_gobyteslice_ *target, _icu4go_gouint16slice_ *source, _icu4go_goint32slice_ *offsets, bool flush, UErrorCode *err) {
        char *targetPtr((char *)target->array);
        const char *targetLimit((const char *)target->array + (offsets ? std::min(offsets->cap, target->len): target->len));
        const UChar *sourcePtr(source->array);
        const UChar *sourceLimit(source->array + source->len);
        ucnv_fromUnicode(this, &targetPtr, targetLimit, &sourcePtr, sourceLimit, (offsets ? offsets->array: NULL), flush, err);
        size_t targetAdvanced(targetPtr - (char *)target->array);
        size_t sourceAdvanced(sourcePtr - source->array);
        if (offsets)
            offsets->len = targetAdvanced;
        target->len -= targetAdvanced;
        target->cap -= targetAdvanced;
        target->array = (uint8_t *)targetPtr;
        source->len -= sourceAdvanced;
        source->cap -= sourceAdvanced;
        source->array = (UChar *)sourcePtr;
    }

    inline void ToUnicode(_icu4go_gouint16slice_ *target, _icu4go_gobyteslice_ *source, _icu4go_goint32slice_ *offsets, bool flush, UErrorCode *err) {
        UChar *targetPtr(target->array);
        const UChar *targetLimit(target->array + (offsets ? std::min(offsets->cap, target->len): target->len));
        const char *sourcePtr((const char *)source->array);
        const char *sourceLimit((const char *)source->array + source->len);
        ucnv_toUnicode(this, &targetPtr, targetLimit, &sourcePtr, sourceLimit, (offsets ? offsets->array: NULL), flush, err);
        size_t targetAdvanced(targetPtr - target->array);
        size_t sourceAdvanced(sourcePtr - (const char *)source->array);
        if (offsets)
            offsets->len = targetAdvanced;
        target->len -= targetAdvanced;
        target->cap -= targetAdvanced;
        target->array = (UChar *)targetPtr;
        source->len -= sourceAdvanced;
        source->cap -= sourceAdvanced;
        source->array = (uint8_t *)sourcePtr;
    }

    inline _icu4go_gobyteslice_ FromUChars(_icu4go_gouint16slice_ src, UErrorCode *err) {
        UErrorCode _err = U_ZERO_ERROR;
        _icu4go_gobyteslice_ retval(_icu4go_rawbyteslice(src.len));
        int32_t l(ucnv_fromUChars(this, (char *)retval.array, retval.len, src.array, src.len, &_err));
        if (U_SUCCESS(_err)) {
            retval.len = l;
        } else {
            retval.len = 0;
            *err = _err;
        }
        return retval;
    }

    inline _icu4go_gouint16slice_ ToUChars(_icu4go_gobyteslice_ src, UErrorCode *err) {
        UErrorCode _err = U_ZERO_ERROR;
        const int32_t cap(src.len * 2);
        _icu4go_gouint16slice_ retval(_icu4go_makeuint16slice(0, cap));
        int32_t l(ucnv_toUChars(this, retval.array, cap, (const char *)src.array, src.len, &_err));
        if (U_SUCCESS(_err)) {
            retval.len = l;
        } else {
            *err = _err;
        }
        return retval;
    }

    inline icu::UnicodeString ToUTF8(_icu4go_gobyteslice_ src, UErrorCode *err) {
        icu::UnicodeString retval;
        UErrorCode _err = U_ZERO_ERROR;
        const int32_t cap(src.len * 2);
        UChar* buf(retval.getBuffer(cap));
        int32_t l(ucnv_toUChars(this, buf, cap, (const char *)src.array, src.len, &_err));
        if (U_SUCCESS(_err)) {
            retval.releaseBuffer(l);
        } else {
            retval.releaseBuffer(0);
            *err = _err;
        }
        return retval;
    }

    inline UnicodeString FixFileSeparator(UnicodeString source) {
        UChar* buf(source.getBuffer(source.length()));
        ucnv_fixFileSeparator(this, buf, source.length());
        source.releaseBuffer(source.length());
        return source;
    }

    inline UBool IsAmbiguous() const {
        return ucnv_isAmbiguous(this);
    }

    inline void SetFallback(UBool usesFallback) {
        return ucnv_setFallback(this, usesFallback);
    }

    inline UBool UsesFallback() const {
        return ucnv_usesFallback(this);
    }

    inline int32_t FromUCountPending(UErrorCode *err) const {
        return ucnv_fromUCountPending(this, err);
    }

    inline int32_t ToUCountPending(UErrorCode *err) const {
        return ucnv_toUCountPending(this, err);
    }

    inline UBool IsFixedWidth(UErrorCode *err) const {
        return ucnv_isFixedWidth(const_cast<UConverter*>(this), err);
    }

    inline static int32_t FlushCache(void) {
        return ucnv_flushCache();
    }

    inline static const char *DetectUnicodeSignature(_icu4go_gobyteslice_ source, int32_t *signatureLength, UErrorCode *err) {
        return ucnv_detectUnicodeSignature((const char *)source.array, source.len, signatureLength, err);
    }

    inline static _icu4go_gostringslice_ GetAvailableNames() {
        int32_t n(ucnv_countAvailable());
        _icu4go_gostringslice_ retval(_icu4go_makestringslice(n, n));
        for (int i = 0; i < retval.len; ++i) {
            const char *name(ucnv_getAvailableName(i));
            retval.array[i] = _swig_makegostring(name, strlen(name));
        }
        return retval;
    }

    inline static UEnumeration* OpenAllNames(UErrorCode *err) {
        return ucnv_openAllNames(err);
    }

    inline static _icu4go_gostringslice_ GetAliases(const char *alias, UErrorCode *err) {
        UErrorCode _err = U_ZERO_ERROR;
        int l(ucnv_countAliases(alias, &_err));
        const char **b(new const char *[l]);
        _icu4go_gostringslice_ retval(_icu4go_makestringslice(0, l));
        ucnv_getAliases(alias, b, &_err);
        if (!U_SUCCESS(_err)) {
            delete[] b;
            *err = _err;
        } else {
            for (int i = 0; i < l; ++i)
                retval.array[i] = _swig_makegostring(b[i], strlen(b[i]));
            delete[] b;
            retval.len = l;
        }
        return retval;
    }

    inline static UEnumeration* OpenStandardNames(const char *convName, const char *standard, UErrorCode* err) {
        return ucnv_openStandardNames(convName, standard, err);
    }

    inline static const char* GetCanonicalName(const char *alias, const char *standard, UErrorCode *err) {
        return ucnv_getCanonicalName(alias, standard, err);
    }

private:
    static void UConverterFromUCallback_invoke(const void* context, UConverterFromUnicodeArgs* args, const UChar *codeUnits, int32_t length, UChar32 codePoint, UConverterCallbackReason reason, UErrorCode *err) {
        _icu4go_goint32slice_ offsets_slice;
        if (args->offsets) {
            offsets_slice.array = args->offsets;
            offsets_slice.len = offsets_slice.cap = args->targetLimit - args->target;
        } else {
            offsets_slice = _icu4go_makeint32slice(0, 0);
        }
        struct {
            const _gofunc_ *cb;
            struct {
                int flush;
                _goiface_ converter;
                _icu4go_gouint16slice_ source;
                _icu4go_gobyteslice_ target;
                _icu4go_goint32slice_ offsets;
                int reason;
                UErrorCode *err;
                void *retval;
            } a;
        } a = {
            (const _gofunc_ *)context,
            {
                args->flush,
                { NULL, NULL },
                { (uint16_t *)args->source, args->sourceLimit - args->source, args->sourceLimit - args->source },
                { (uint8_t *)args->target, args->targetLimit - args->target, args->targetLimit - args->target },
                offsets_slice,
                reason,
                err
            }
        };
        crosscall2(_icu4go__UConverterFromUCallback_invoke, &a, (int)sizeof(a));
    }

    static void UConverterToUCallback_invoke(const void* context, UConverterToUnicodeArgs* args, const char *codeUnits, int32_t length, UConverterCallbackReason reason, UErrorCode *err) {
        struct _icu4go_goint32slice_ offsets_slice;
        if (args->offsets) {
            offsets_slice.array = args->offsets;
            offsets_slice.len = offsets_slice.cap = args->targetLimit - args->target;
        } else {
            offsets_slice = _icu4go_makeint32slice(0, 0);
        }
        struct {
            const _gofunc_* cb;
            struct {
                int flush;
                _goiface_ converter;
                _icu4go_gobyteslice_ source;
                _icu4go_gouint16slice_ target;
                _icu4go_goint32slice_ offsets;
                int reason;
                UErrorCode *err;
                void *retval;
            } a;
        } a = {
            (const _gofunc_ *)context,
            {
                args->flush,
                { NULL, NULL },
                { (uint8_t *)args->source, args->sourceLimit - args->source, args->sourceLimit - args->source },
                { (uint16_t *)args->target, args->targetLimit - args->target, args->targetLimit - args->target },
                offsets_slice,
                reason,
                err
            }
        };
        crosscall2(_icu4go__UConverterToUCallback_invoke, &a, (int)sizeof(a));
    }
};
%}

%include <typemaps.i>

%typemap(gotype) _gofunc_UConverterToUCallback* %{func(bool, UConverter, []byte, []uint16, []int32, UConverterCallbackReason, *UErrorCode)%}
%typemap(in) _gofunc_UConverterToUCallback* %{
    $1 = $input;
%}

%typemap(out) _gofunc_UConverterToUCallback* %{
    $result = $1;
%}


%typemap(gotype) _gofunc_UConverterFromUCallback* %{func(bool, UConverter, []uint16, []byte, []int32, UConverterCallbackReason, *UErrorCode)%}
%typemap(in) _gofunc_UConverterFromUCallback* %{
    $1 = $input;
%}

%typemap(out) _gofunc_UConverterFromUCallback* %{
    $result = $1;
%}



enum UConverterType {
    UCNV_UNSUPPORTED_CONVERTER,
    UCNV_SBCS,
    UCNV_DBCS,
    UCNV_MBCS,
    UCNV_LATIN_1,
    UCNV_UTF8,
    UCNV_UTF16_BigEndian,
    UCNV_UTF16_LittleEndian,
    UCNV_UTF32_BigEndian,
    UCNV_UTF32_LittleEndian,
    UCNV_EBCDIC_STATEFUL,
    UCNV_ISO_2022,
    UCNV_LMBCS_1,
    UCNV_LMBCS_2, 
    UCNV_LMBCS_3,
    UCNV_LMBCS_4,
    UCNV_LMBCS_5,
    UCNV_LMBCS_6,
    UCNV_LMBCS_8,
    UCNV_LMBCS_11,
    UCNV_LMBCS_16,
    UCNV_LMBCS_17,
    UCNV_LMBCS_18,
    UCNV_LMBCS_19,
    UCNV_LMBCS_LAST,
    UCNV_HZ,
    UCNV_SCSU,
    UCNV_ISCII,
    UCNV_US_ASCII,
    UCNV_UTF7,
    UCNV_BOCU1,
    UCNV_UTF16,
    UCNV_UTF32,
    UCNV_CESU8,
    UCNV_IMAP_MAILBOX,
    UCNV_COMPOUND_TEXT,
    UCNV_NUMBER_OF_SUPPORTED_CONVERTER_TYPES
};

enum UConverterPlatform {
    UCNV_UNKNOWN,
    UCNV_IBM
};

enum UConverterCallbackReason {
    UCNV_UNASSIGNED,
    UCNV_ILLEGAL,
    UCNV_IRREGULAR,
    UCNV_RESET,
    UCNV_CLOSE,
    UCNV_CLONE,
};


#define UCNV_OPTION_SEP_CHAR
#define UCNV_OPTION_SEP_STRING
#define UCNV_VALUE_SEP_CHAR
#define UCNV_VALUE_SEP_STRING
#define UCNV_LOCALE_OPTION_STRING
#define UCNV_VERSION_OPTION_STRING
#define UCNV_SWAP_LFNL_OPTION_STRING

enum UConverterUnicodeSet {
    UCNV_ROUNDTRIP_SET,
    UCNV_ROUNDTRIP_AND_FALLBACK_SET,
    UCNV_SET_COUNT
};

%nodefaultctor UConverter;
%nodefaultdtor UConverter;
struct UConverter {
    static UConverter* Open(const char *converterName, UErrorCode *err);
    static UConverter* OpenCCSID(int32_t codepage, UConverterPlatform platform, UErrorCode *err);
    static UConverter* OpenPackage(const char *packageName, const char *converterName, UErrorCode *err);
    UConverter* SafeClone(UErrorCode *err) const;
    void Close();
    _icu4go_gobyteslice_ GetSubstChars(UErrorCode *err) const;
    void SetSubstChars(_icu4go_gobyteslice_ gs, UErrorCode *err);
    void SetSubstString(const icu::UnicodeString& gs, UErrorCode *err);
    _icu4go_gobyteslice_ GetInvalidChars(UErrorCode *err) const;
    icu::UnicodeString GetInvalidUChars(UErrorCode *err) const;
    void Reset();
    void ResetToUnicode();
    void ResetFromUnicode();
    int GetMaxCharSize() const;
    int GetMinCharSize() const;
    const char *GetName(UErrorCode *err) const;
    UnicodeString GetDisplayName(const char *displayLocale, UErrorCode *err) const;
    int GetCCSID(UErrorCode *err) const;
    UConverterPlatform GetPlatform(UErrorCode *err) const;
    UConverterType GetType() const;
    _icu4go_gointslice_ GetStarters(UErrorCode *err) const;
    USet *GetUnicodeSet(UConverterUnicodeSet whichSet, UErrorCode *err) const;
    void SetToUCallBack(_gofunc_UConverterToUCallback *newAction, UErrorCode *err);
    void SetFromUCallBack(_gofunc_UConverterFromUCallback *newAction, UErrorCode *err);
    void FromUnicode(_icu4go_gobyteslice_ *target, _icu4go_gouint16slice_ *source, _icu4go_goint32slice_ *offsets, bool flush, UErrorCode *err);
    void ToUnicode(_icu4go_gouint16slice_ *target, _icu4go_gobyteslice_ *source, _icu4go_goint32slice_ *offsets, bool flush, UErrorCode *err);
    _icu4go_gobyteslice_ FromUChars(_icu4go_gouint16slice_ src, UErrorCode *err);
    _icu4go_gouint16slice_ ToUChars(_icu4go_gobyteslice_ src, UErrorCode *err);
    icu::UnicodeString ToUTF8(_icu4go_gobyteslice_ src, UErrorCode *err);
    UnicodeString FixFileSeparator(UnicodeString source);
    UBool IsAmbiguous() const;
    void SetFallback(UBool usesFallback);
    UBool UsesFallback() const;
    int32_t FromUCountPending(UErrorCode *err) const;
    int32_t ToUCountPending(UErrorCode *err) const;
    UBool IsFixedWidth(UErrorCode *err) const;
    static int32_t FlushCache(void);
    static const char *DetectUnicodeSignature(_icu4go_gobyteslice_ source, int32_t *signatureLength, UErrorCode *err);
    static _icu4go_gostringslice_ GetAvailableNames();
    static UEnumeration* OpenAllNames(UErrorCode *err);
    static _icu4go_gostringslice_ GetAliases(const char *alias, UErrorCode *err);
    static UEnumeration* OpenStandardNames(const char *convName, const char *standard, UErrorCode* err);
    static const char* GetCanonicalName(const char *alias, const char *standard, UErrorCode *err);
};

int ucnv_compareNames(const char *name1, const char *name2);
int UCNV_GET_MAX_BYTES_FOR_STRING(int, int);

/*
UChar32 ucnv_getNextUChar(UConverter * converter, const char **source, const char * sourceLimit, UErrorCode *err); 

int32_t ucnv_toAlgorithmic(UConverterType algorithmicType, UConverter *cnv, char *target, int32_t targetCapacity, const char *source, int32_t sourceLength, UErrorCode *err);

int32_t ucnv_fromAlgorithmic(UConverter *cnv, UConverterType algorithmicType, char *target, int32_t targetCapacity, const char *source, int32_t sourceLength, UErrorCode *err);

const char * ucnv_getDefaultName(void);

void ucnv_setDefaultName(const char *name);
*/
