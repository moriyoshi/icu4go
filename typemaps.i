%insert(gc_header) %{
#include "textflag.h"

#define KindSlice 0x17 // XXX: may change in the future!

void runtime·rawbyteslice(void);
void runtime·makeslice(struct SliceType*, int64, int64);

#pragma cgo_export_static _icu4go__rawbyteslice
#pragma cgo_export_dynamic _icu4go__rawbyteslice
#pragma textflag NOSPLIT
void _icu4go__rawbyteslice(void *a, int32 n)
{
    runtime·cgocallback((void(*)(void))runtime·rawbyteslice, a, n);
}

// XXX: may change in the future!
struct Type {
    uintptr size;
    uint32 hash;
    uint8 _unused;
    uint8 align;
    uint8 fieldAlign;
    uint8 kind;
    void* alg;
    uintptr gc[2];
    String *string;
    void *x;
    Type *ptrto;
    byte *zero;
};

struct SliceType {
    Type b;
    Type *elem;
};

extern Type type·int;

#pragma dataflag RODATA
static struct SliceType _icu4go_int_slice_type = {
    {
        sizeof(Slice), // size
        0x1bf9668e, // hash
        0, // unused
        sizeof(intgo), // align
        sizeof(intgo), // fieldAlign
        KindSlice, // kind
        nil, // alg
        { 0, 0 }, // gc
        nil, // string
        nil, // x
        nil, // ptrto
        nil, // zero
    },
    &type·int
};

struct _icu4go__makeintslice_args {
    intgo n;
    intgo cap;
    Slice ret;
};

#pragma cgo_export_static _icu4go__makeintslice
#pragma cgo_export_dynamic _icu4go__makeintslice
#pragma textflag NOSPLIT
void _icu4go__makeintslice(struct _icu4go__makeintslice_args *a, int32 n)
{
    struct _icu4go__makeintslice_makeslice_args {
        Type *typ;
        int64 len;
        int64 cap;
        Slice ret;
    } msa = { (Type *)&_icu4go_int_slice_type, a->n, a->cap };
    runtime·cgocallback((void(*)(void))runtime·makeslice, &msa, sizeof(msa));
    a->ret = msa.ret;
}

extern Type type·int32;

#pragma dataflag RODATA
static struct SliceType _icu4go_int32_slice_type = {
    {
        sizeof(Slice), // size
        0x1bf9668e, // hash
        0, // unused
        sizeof(intgo), // align
        sizeof(intgo), // fieldAlign
        KindSlice, // kind
        nil, // alg
        { 0, 0 }, // gc
        nil, // string
        nil, // x
        nil, // ptrto
        nil, // zero
    },
    &type·int32
};

struct _icu4go__makeint32slice_args {
    intgo n;
    intgo cap;
    Slice ret;
};

#pragma cgo_export_static _icu4go__makeint32slice
#pragma cgo_export_dynamic _icu4go__makeint32slice
#pragma textflag NOSPLIT
void _icu4go__makeint32slice(struct _icu4go__makeint32slice_args *a, int32 n)
{
    struct _icu4go__makeint32slice_makeslice_args {
        Type *typ;
        int64 len;
        int64 cap;
        Slice ret;
    } msa = { (Type *)&_icu4go_int32_slice_type, a->n, a->cap };
    runtime·cgocallback((void(*)(void))runtime·makeslice, &msa, sizeof(msa));
    a->ret = msa.ret;
}

extern Type type·uint16;

#pragma dataflag RODATA
static struct SliceType _icu4go_uint16_slice_type = {
    {
        sizeof(Slice), // size
        0x1bf9668e, // hash
        0, // unused
        sizeof(intgo), // align
        sizeof(intgo), // fieldAlign
        KindSlice, // kind
        nil, // alg
        { 0, 0 }, // gc
        nil, // string
        nil, // x
        nil, // ptrto
        nil, // zero
    },
    &type·uint16
};

struct _icu4go__makeuint16slice_args {
    intgo n;
    intgo cap;
    Slice ret;
};

#pragma cgo_export_static _icu4go__makeuint16slice
#pragma cgo_export_dynamic _icu4go__makeuint16slice
#pragma textflag NOSPLIT
void _icu4go__makeuint16slice(struct _icu4go__makeuint16slice_args *a, uint16 n)
{
    struct _icu4go__makeuint16slice_makeslice_args {
        Type *typ;
        int64 len;
        int64 cap;
        Slice ret;
    } msa = { (Type *)&_icu4go_uint16_slice_type, a->n, a->cap };
    runtime·cgocallback((void(*)(void))runtime·makeslice, &msa, sizeof(msa));
    a->ret = msa.ret;
}

extern void ·makestringslice(void);

#pragma cgo_export_static _icu4go__makestringslice
#pragma textflag NOSPLIT
void _icu4go__makestringslice(void *a, int32 n)
{
    runtime·cgocallback(·makestringslice, a, n);
}
%}

%insert(go_wrapper) %{
func makestringslice(l int, c int) []string {
    return make([]string, l, c)
}
%}

%{
#include <unicode/ustring.h>
#include <unicode/utf8.h>

extern "C" {

struct _icu4go_gobyteslice_ {
    uint8_t* array;
    intgo len;
    intgo cap;
};

struct _icu4go_gointslice_ {
    intgo* array;
    intgo len;
    intgo cap;
};

struct _icu4go_goint32slice_ {
    int32_t* array;
    intgo len;
    intgo cap;
};

struct _icu4go_gouint16slice_ {
    uint16_t* array;
    intgo len;
    intgo cap;
};

struct _icu4go_gostringslice_ {
    _gostring_* array;
    intgo len;
    intgo cap;
};

struct _goiface_ {
    void *tab;
    void *data;
};

struct _gofunc_ {
    void (*fn)();
};

extern void _icu4go__rawbyteslice(void *a, int n);
extern void _icu4go__makeintslice(void *a, int n);
extern void _icu4go__makeint32slice(void *a, int n);
extern void _icu4go__makeuint16slice(void *a, int n);
extern void _icu4go__makestringslice(void *a, int n);

static int _icu4go_utf8_len(const UChar *s, int32_t l)
{
    int retval = 0;
    int i = 0;
    while (i < l) {
        UChar32 c;
        U16_NEXT(s, i, l, c);
        retval += U8_LENGTH(c);
    }
    return retval;
}

static struct _icu4go_gobyteslice_ _icu4go_rawbyteslice(intgo t)
{
    struct {
        intgo s;
        struct _icu4go_gobyteslice_ ret;
    } a = { t };
    crosscall2(_icu4go__rawbyteslice, &a, (int)sizeof(a));
    return a.ret;
}

static struct _icu4go_gointslice_ _icu4go_makeintslice(intgo n, intgo cap)
{
    struct {
        intgo n;
        intgo cap;
        struct _icu4go_gointslice_ ret;
    } a = { n, cap };
    crosscall2(_icu4go__makeintslice, &a, (int)sizeof(a));
    return a.ret;
}

static struct _icu4go_goint32slice_ _icu4go_makeint32slice(intgo n, intgo cap)
{
    struct {
        intgo n;
        intgo cap;
        struct _icu4go_goint32slice_ ret;
    } a = { n, cap };
    crosscall2(_icu4go__makeint32slice, &a, (int)sizeof(a));
    return a.ret;
}

static struct _icu4go_gouint16slice_ _icu4go_makeuint16slice(intgo n, intgo cap)
{
    struct {
        intgo n;
        intgo cap;
        struct _icu4go_gouint16slice_ ret;
    } a = { n, cap };
    crosscall2(_icu4go__makeuint16slice, &a, (int)sizeof(a));
    return a.ret;
}

static _icu4go_gostringslice_ _icu4go_makestringslice(int len, int cap)
{
    struct {
        intgo len;
        intgo cap;
        _icu4go_gostringslice_ ret;
    } a = { len, cap };
    crosscall2(_icu4go__makestringslice, &a, (int)sizeof(a));
    return a.ret;
}
}
%}

%typemap(gotype) const char ** %{[]string%}
%typemap(in) const char ** %{
    $1 = (char **)malloc(sizeof(char *) * $input.len);
%}
%typemap(argout) const char ** %{
    int i;
    for (i = 0; i < $input.len; ++i) {
        ((_gostring_*)$input.array)[i] = _swig_makegostring(((char**)$1)[i], strlen(((char**)$1)[i]));
    }
%}
%typemap(freearg) const char ** %{
    free($1);
%}

%typemap(gotype) char *OUT %{[]byte%}

%typemap(in) char *OUT %{
    $1 = ($1_ltype) $input.array;
%}

%typemap(gotype) int8_t *REAL_INT8_INOUT %{[]int8%}

%typemap(in) int8_t *REAL_INT8_INOUT %{
    $1 = ($1_ltype) $input.array;
%}

%typemap(gotype) _icu4go_gobyteslice_ %{[]byte%}

%typemap(in) _icu4go_gobyteslice_ %{
    $1 = *(_icu4go_gobyteslice_ *)&$input;
%}

%typemap(out) _icu4go_gobyteslice_ %{
    $result = *(_goslice_ *)&$1;
%}

%typemap(gotype) _icu4go_gointslice_ %{[]int%}

%typemap(in) _icu4go_gointslice_ %{
    $1 = *(_icu4go_gointslice_ *)&$input;
%}

%typemap(out) _icu4go_gointslice_ %{
    $result = *(_goslice_ *)&$1;
%}

%typemap(gotype) _icu4go_goint32slice_ %{[]int32%}

%typemap(in) _icu4go_goint32slice_ %{
    $1 = *(_icu4go_goint32slice_ *)&$input;
%}

%typemap(out) _icu4go_goint32slice_ %{
    $result = *(_goslice_ *)&$1;
%}

%typemap(gotype) _icu4go_gouint16slice_ %{[]uint16%}

%typemap(in) _icu4go_gouint16slice_ %{
    $1 = *(_icu4go_gouint16slice_ *)&$input;
%}

%typemap(out) _icu4go_gouint16slice_ %{
    $result = *(_goslice_ *)&$1;
%}

%typemap(gotype) _icu4go_gostringslice_ %{[]string%}

%typemap(in) _icu4go_gostringslice_ %{
    $1 = *(_icu4go_gostringslice_ *)&$input;
%}

%typemap(out) _icu4go_gostringslice_ %{
    $result = *(_goslice_ *)&$1;
%}

%typemap(gotype) icu::StringPiece, const icu::StringPiece& %{string%}

%typemap(in) icu::StringPiece %{
    $1 = icu::StringPiece($input.p, $input.n);
%}

%typemap(in) const icu::StringPiece& %{
    $*1_ltype $1($input.p, $input.n);
    $1 = &$1_str;
%}

%typemap(out) icu::StringPiece %{
    $result.p = $1.data();
    $result.n = $1.length();
%}

%typemap(gotype) icu::UnicodeString, const icu::UnicodeString& %{string%}

%typemap(in) icu::UnicodeString %{
    $1 = icu::UnicodeString::fromUTF8(icu::StringPiece($input.p, $input.n));
%}

%typemap(in) const icu::UnicodeString& %{
    $*1_ltype $1_str(icu::UnicodeString::fromUTF8(icu::StringPiece($input.p, $input.n)));
    $1 = &$1_str;
%}

%typemap(out) icu::UnicodeString %{
    UErrorCode err(U_ZERO_ERROR);
    int32_t l = _icu4go_utf8_len($1.getBuffer(), $1.length());
    $result.p = (char *)_swig_goallocate(l + 1);
    u_strToUTF8($result.p, l, &l, $1.getBuffer(), $1.length(), &err);
    $result.p[l] = 0;
    $result.n = l;
%}

%typemap(out) const icu::UnicodeString & %{
    UErrorCode err(U_ZERO_ERROR);
    int32_t l = _icu4go_utf8_len($1.getBuffer(), $1.length());
    $result.p = (char *)_swig_goallocate(l + 1);
    u_strToUTF8($result.p, l, &l, $1.getBuffer(), $1.length(), &err);
    $result.p[l] = 0;
    $result.n = l;
%}

%typemap(gotype) UChar32 "rune"

%typemap(in) UChar32 %{
    $1 = ($1_type)$input;
%}

%typemap(gotype) _gostring_* %{*string%}
%typemap(in) _gostring_* %{
    $1 = $input;
%}

%typemap(out) _gostring_* %{
    $result = $1;
%}
