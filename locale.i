%module icu4go;

%{
#include <unicode/locid.h>

extern "C" {
extern void _icu4go__makeLocaleSlice(void *a, int n);

typedef _goslice_ _icu4go_Locale_slice_;

static _icu4go_Locale_slice_ _icu4go_makeLocaleSlice(int len, int cap)
{
    struct {
        intgo len;
        intgo cap;
        _goslice_ ret;
    } a = { len, cap };
    crosscall2(_icu4go__makeLocaleSlice, &a, (int)sizeof(a));
    return a.ret;
}
}

struct _Locale {
    inline _Locale(): impl_(0) {}

    inline _Locale(const char* language, const char* country, const char* variant, const char* keywordsAndValues) {
        if (strlen(country) == 0)
            country = NULL;
        if (strlen(variant) == 0)
            variant = NULL;
        if (strlen(keywordsAndValues) == 0)
            keywordsAndValues = NULL;
        impl_ = new icu::Locale(language, country, variant, keywordsAndValues);  
    }

    inline bool Equals(_Locale that) {
        return *impl_ == *that.impl_;
    }

    inline _Locale Clone() {
        return impl_->clone();
    }

    inline void Close() {
        delete impl_;
        delete this;
    }

    inline static _Locale CreateFromName(const char *name) {
        return icu::Locale::createFromName(name);
    }

    inline static _Locale CreateCanonical(const char* name) {
        return icu::Locale::createCanonical(name);
    }

    inline const char *GetLanguage() {
        return impl_->getLanguage();
    }

    inline const char *GetScript() {
        return impl_->getScript();
    }

    inline const char *GetCountry() {
        return impl_->getCountry();
    }

    inline const char *GetVariant() {
        return impl_->getVariant();
    }

    inline const char *GetName() {
        return impl_->getName();
    }

    inline const char *GetBaseName() {
        return impl_->getBaseName();
    }

    inline StringEnumeration* CreateKeywords(UErrorCode* err) {
        return impl_->createKeywords(*err);
    }

    inline int32_t GetKeywordValue(const char* keywordName, char *buffer, int32_t bufferCapacity, UErrorCode* err) {
        return impl_->getKeywordValue(keywordName, buffer, bufferCapacity, *err);
    }

    inline void SetKeywordValue(const char* keywordName, const char* keywordValue, UErrorCode *err) {
        return impl_->setKeywordValue(keywordName, keywordValue,*err);
    }

    inline const char* GetISO3Language() {
        return impl_->getISO3Language();
    }

    inline const char * getISO3Country() {
        return impl_->getISO3Country();
    }

    inline uint32_t GetLCID(void) {
        return impl_->getLCID();
    }

    inline UnicodeString GetDisplayLanguage() {
        UnicodeString retval;
        impl_->getDisplayLanguage(retval);
        return retval;
    }
 
    inline UnicodeString GetDisplayLanguage(_Locale displayLocale) {
        UnicodeString retval;
        impl_->getDisplayLanguage(*displayLocale.impl_, retval);
        return retval;
    }

    inline UnicodeString GetDisplayScript() {
        UnicodeString retval;
        impl_->getDisplayScript(retval);
        return retval;
    }

    inline UnicodeString GetDisplayScript(_Locale displayLocale) {
        UnicodeString retval;
        impl_->getDisplayScript(*displayLocale.impl_, retval);
        return retval;
    }

    inline UnicodeString GetDisplayCountry() {
        UnicodeString retval;
        impl_->getDisplayCountry(retval);
        return retval;
    }

    inline UnicodeString GetDisplayCountry(_Locale displayLocale) {
        UnicodeString retval;
        impl_->getDisplayCountry(*displayLocale.impl_, retval);
        return retval;
    }

    inline UnicodeString GetDisplayVariant() {
        UnicodeString retval;
        impl_->getDisplayVariant(retval);
        return retval;
    }

    inline UnicodeString GetDisplayVariant(_Locale displayLocale) {
        UnicodeString retval;
        impl_->getDisplayVariant(*displayLocale.impl_, retval);
        return retval;
    }

    inline UnicodeString GetDisplayName() {
        UnicodeString retval;
        impl_->getDisplayName(retval);
        return retval;
    }

    inline UnicodeString GetDisplayName(_Locale displayLocale) {
        UnicodeString retval;
        impl_->getDisplayName(*displayLocale.impl_, retval);
        return retval;
    }

    inline int32_t HashCode(void) {
        return impl_->hashCode();
    }

    inline void SetToBogus() {
        impl_->setToBogus();
    }

    inline bool IsBogus(void) {
        return impl_->isBogus();
    }

    inline static _goslice_ GetAvailableLocales() {
        int32_t c;
        const icu::Locale* result(icu::Locale::getAvailableLocales(c));
        _icu4go_Locale_slice_ retval(_icu4go_makeLocaleSlice(c, c));
        for (int i = 0; i < c; ++i) {
            ((_Locale **)retval.array)[i] = new _Locale(result[i]);
        }
        return retval;
    }

    inline static _icu4go_gostringslice_ GetISOCountries() {
        const char *const* result(icu::Locale::getISOCountries());
        int l(0);
        {
            const char *const* p(result);
            while (*p) {
                ++l;
                ++p;
            }
        }
        _icu4go_gostringslice_ retval(_icu4go_makestringslice(l, l));
        {
            int i(0);
            const char *const* p(result);
            while (*p) {
                retval.array[i] = _swig_makegostring(*p, strlen(*p));
                ++i;
                ++p;
            }
        }
        return retval;
    }

    inline static  _icu4go_gostringslice_ GetISOLanguages() {
        const char *const* result(icu::Locale::getISOLanguages());
        int l(0);
        {
            const char *const* p(result);
            while (*p) {
                ++l;
                ++p;
            }
        }
        _icu4go_gostringslice_ retval(_icu4go_makestringslice(l, l));
        {
            int i(0);
            const char *const* p(result);
            while (*p) {
                retval.array[i] = _swig_makegostring(*p, strlen(*p));
                ++i;
                ++p;
            }
        }
        return retval;
    }

private:
    inline _Locale(const icu::Locale& impl):impl_(new icu::Locale(impl)) {}

    inline _Locale(icu::Locale* impl):impl_(impl) {}

    inline _Locale(const icu::Locale* impl):impl_(const_cast<icu::Locale*>(impl)) {}

    icu::Locale* impl_;
};

%}

%insert(gc_header) %{
extern void ·makeLocaleSlice(void);

#pragma cgo_export_static _icu4go__makeLocaleSlice
#pragma textflag NOSPLIT
void _icu4go__makeLocaleSlice(void *a, int32 n)
{
    runtime·cgocallback(·makeLocaleSlice, a, n);
}
%}

%insert(go_wrapper) %{
func makeLocaleSlice(l int, c int) []SwigcptrLocale {
    return make([]SwigcptrLocale, l, c)
}
%}

%typemap(gotype) _icu4go_Locale_slice_ %{[]SwigcptrLocale%}
%typemap(in) _icu4go_Locale_slice_ %{
    $1 = $input;
%}
%typemap(out) _icu4go_Locale_slice_ %{
    $result = $1;
%}

%rename(Locale) _Locale;
%nodefaultctor _Locale;
%nodefaultdtor _Locale;
struct _Locale {
    _Locale(const char* language, const char* country, const char* variant, const char* keywordsAndValues);
    bool Equals(_Locale that);
    _Locale Clone();
    void Close();
    static _Locale CreateFromName(const char *name);
    static _Locale CreateCanonical(const char* name);
    const char *GetLanguage();
    const char *GetScript();
    const char *GetCountry();
    const char *GetVariant();
    const char *GetName();
    const char *GetBaseName();
    StringEnumeration* CreateKeywords(UErrorCode* err);
    int32_t GetKeywordValue(const char* keywordName, char *buffer, int32_t bufferCapacity, UErrorCode* err);
    void SetKeywordValue(const char* keywordName, const char* keywordValue, UErrorCode *err);
    const char* GetISO3Language();
    const char * getISO3Country();
    uint32_t GetLCID(void);
    UnicodeString GetDisplayLanguage();
    UnicodeString GetDisplayLanguage(_Locale displayLocale);
    UnicodeString GetDisplayScript();
    UnicodeString GetDisplayScript(_Locale displayLocale);
    UnicodeString GetDisplayCountry();
    UnicodeString GetDisplayCountry(_Locale displayLocale);
    UnicodeString GetDisplayVariant();
    UnicodeString GetDisplayVariant(_Locale displayLocale);
    UnicodeString GetDisplayName();
    UnicodeString GetDisplayName(_Locale displayLocale);
    int32_t HashCode(void);
    void SetToBogus();
    bool IsBogus(void);
    static _icu4go_Locale_slice_ GetAvailableLocales();
    static _icu4go_gostringslice_ GetISOCountries();
    static  _icu4go_gostringslice_ GetISOLanguages();
};
