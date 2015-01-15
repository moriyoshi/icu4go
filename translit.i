%module icu4go
%{
#include <unicode/translit.h>

struct _Transliterator {
    inline void Close() {
        delete impl_;
        delete this;
    }

    inline _Transliterator Clone() const {
        return impl_->clone();
    }

    inline icu::UnicodeString Transliterate(icu::UnicodeString s) const {
        impl_->transliterate(s);
        return s;
    }

    inline icu::UnicodeString TransliterateWithContext(icu::UnicodeString s, UTransPosition pos, UErrorCode *err) const {
        impl_->transliterate(s, pos, *err);
        return s;
    }

    inline icu::UnicodeString TransliterateWithInsertionAndContext(icu::UnicodeString s, UTransPosition pos, icu::UnicodeString insertion, UErrorCode *err) const {
        impl_->transliterate(s, pos, insertion, *err);
        return s;
    }

    inline icu::UnicodeString FinishTransliteration(icu::UnicodeString s, UTransPosition &pos) const {
        impl_->finishTransliteration(s, pos);
        return s; 
    }

    inline int32_t GetMaximumContextLength(void) const {
        return impl_->getMaximumContextLength();
    }

    inline icu::UnicodeString GetID(void) const {
        return impl_->getID();
    }

    inline UClassID getDynamicClassID(void) const {
        return impl_->getDynamicClassID();
    }

    inline const UnicodeFilter* getFilter(void) const {
        return impl_->getFilter();
    }

    inline UnicodeFilter* orphanFilter(void) {
        return impl_->orphanFilter();
    }

    inline void AdoptFilter(UnicodeFilter* adoptedFilter) {
        impl_->adoptFilter(adoptedFilter);
    }

    inline _Transliterator CreateInverse(UErrorCode* err) const {
        return impl_->createInverse(*err);
    }

    inline icu::UnicodeString ToRules(UBool escapeUnprintable) const {
        icu::UnicodeString retval; 
        impl_->toRules(retval, escapeUnprintable);
        return retval;
    }

    inline int32_t CountElements() const {
        return impl_->countElements();
    }

    inline _Transliterator GetElement(int32_t index, UErrorCode* err) const {
        return &impl_->getElement(index, *err);
    }

    inline _UnicodeSet GetSourceSet() const {
        UnicodeSet* retval(new UnicodeSet());
        impl_->getSourceSet(*retval);
        return retval;
    }

    inline _UnicodeSet HandleGetSourceSet() const {
        UnicodeSet* retval(new UnicodeSet());
        impl_->handleGetSourceSet(*retval);
        return retval;
    }

    inline _UnicodeSet getTargetSet() const {
        UnicodeSet* retval(new UnicodeSet());
        impl_->getTargetSet(*retval);
        return retval;
    }

    inline static icu::UnicodeString GetDisplayName(const icu::UnicodeString& ID) {
        icu::UnicodeString retval;
        icu::Transliterator::getDisplayName(ID, retval);
        return retval;
    }

    inline static icu::UnicodeString GetDisplayNameOfLocale(const icu::UnicodeString& ID, const Locale& locale) {
        icu::UnicodeString retval;
        icu::Transliterator::getDisplayName(ID, locale, retval);
        return retval;
    }

    inline static _Transliterator CreateInstance(const icu::UnicodeString& ID, UTransDirection dir, UErrorCode* err) {
        return icu::Transliterator::createInstance(ID, dir, *err);
    }

    inline static _Transliterator CreateInstanceWithParseError(const icu::UnicodeString& ID, UTransDirection dir, UParseError* parseError, UErrorCode* err) {
        return icu::Transliterator::createInstance(ID, dir, *parseError, *err);
    }

    inline static Transliterator* CreateFromRules(const icu::UnicodeString& ID, const icu::UnicodeString& rules, UTransDirection dir, UParseError* parseError, UErrorCode* err) {
        return icu::Transliterator::createFromRules(ID, rules, dir, *parseError, *err);
    }

    inline static _StringEnumeration GetAvailableIDs(UErrorCode* err) {
        return icu::Transliterator::getAvailableIDs(*err);
    }

    inline static int32_t CountAvailableSources(void) {
        return icu::Transliterator::countAvailableSources();
    }

    inline static icu::UnicodeString GetAvailableSource(int32_t index) {
        icu::UnicodeString retval;
        icu::Transliterator::getAvailableSource(index,  retval);
        return retval;
    }

    inline static int32_t CountAvailableTargets(const icu::UnicodeString& source) {
        return icu::Transliterator::countAvailableTargets(source);
    }

    inline static icu::UnicodeString GetAvailableTarget(int32_t index, const icu::UnicodeString& source) {
        icu::UnicodeString retval;
        icu::Transliterator::getAvailableTarget(index, source, retval);
        return retval;
    }

    inline static int32_t CountAvailableVariants(const icu::UnicodeString& source, const icu::UnicodeString& target) {
        return icu::Transliterator::countAvailableVariants(source, target);
    }

    inline static UnicodeString GetAvailableVariant(int32_t index, const icu::UnicodeString& source, const icu::UnicodeString& target) {
        icu::UnicodeString retval;
        icu::Transliterator::getAvailableVariant(index, source, target, retval);
        return retval;
    }

    // inline static void registerInstance(Transliterator* adoptedObj);
    // inline static void registerAlias(const icu::UnicodeString& aliasID, const icu::UnicodeString& realID);
    // inline static void unregister(const icu::UnicodeString& ID);

    inline _Transliterator(): impl_(0) {}
private:
    inline _Transliterator(icu::Transliterator *impl): impl_(impl) {}

    inline _Transliterator(const icu::Transliterator *impl): impl_(const_cast<icu::Transliterator*>(impl)) {}

    icu::Transliterator* impl_;
};
%}

enum UTransDirection {
        UTRANS_FORWARD,
        UTRANS_REVERSE
};

struct UTransPosition {
    int32_t contextStart;
    int32_t contextLimit;
    int32_t start;
    int32_t limit;
};

%rename(Transliterator) _Transliterator;
%nodefaultctor _Transliterator;
%nodefaultdtor _Transliterator;
struct _Transliterator {
    void Close();
    _Transliterator Clone() const;
    icu::UnicodeString Transliterate(icu::UnicodeString s) const;
    icu::UnicodeString TransliterateWithContext(icu::UnicodeString s, UTransPosition& pos, UErrorCode *err) const;
    icu::UnicodeString TransliterateWithInsertionAndContext(icu::UnicodeString s, UTransPosition& pos, icu::UnicodeString insertion, UErrorCode *err) const;
    icu::UnicodeString FinishTransliteration(icu::UnicodeString s, UTransPosition& pos) const;
    int32_t GetMaximumContextLength(void) const;
    icu::UnicodeString GetID(void) const;
    UClassID getDynamicClassID(void) const;
    const UnicodeFilter* getFilter(void) const;
    UnicodeFilter* orphanFilter(void);
    void AdoptFilter(UnicodeFilter* adoptedFilter);
    _Transliterator CreateInverse(UErrorCode* err) const;
    icu::UnicodeString ToRules(UBool escapeUnprintable) const;
    int32_t CountElements() const;
    _Transliterator GetElement(int32_t index, UErrorCode* err) const;
    _UnicodeSet GetSourceSet() const;
    _UnicodeSet HandleGetSourceSet() const;
    _UnicodeSet getTargetSet() const;
    static icu::UnicodeString GetDisplayName(const icu::UnicodeString& ID);
    static icu::UnicodeString GetDisplayNameOfLocale(const icu::UnicodeString& ID, const Locale& locale);
    static _Transliterator CreateInstance(const icu::UnicodeString& ID, UTransDirection dir, UErrorCode* err);
    static _Transliterator CreateInstanceWithParseError(const icu::UnicodeString& ID, UTransDirection dir, UParseError* parseError, UErrorCode* err);
    static Transliterator* CreateFromRules(const icu::UnicodeString& ID, const icu::UnicodeString& rules, UTransDirection dir, UParseError* parseError, UErrorCode* err);
    static _StringEnumeration GetAvailableIDs(UErrorCode* err);
    static int32_t CountAvailableSources(void);
    static icu::UnicodeString GetAvailableSource(int32_t index);
    static int32_t CountAvailableTargets(const icu::UnicodeString& source);
    static icu::UnicodeString GetAvailableTarget(int32_t index, const icu::UnicodeString& source);
    static int32_t CountAvailableVariants(const icu::UnicodeString& source, const icu::UnicodeString& target);
    static icu::UnicodeString GetAvailableVariant(int32_t index, const icu::UnicodeString& source, const icu::UnicodeString& target);
};
