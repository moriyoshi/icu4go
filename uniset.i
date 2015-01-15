%module icu4go;
%{
#include <unicode/uniset.h>
#include <unicode/parsepos.h>

class _Transliterator;

struct _UnicodeSet {
    friend class _Transliterator;

    inline _UnicodeSet(): impl_(0) {}

    inline static _UnicodeSet OpenEmpty() {
        return new UnicodeSet();
    }

    inline static _UnicodeSet Open(UChar32 start, UChar32 end) {
        return new UnicodeSet(start, end);
    }

    inline static _UnicodeSet OpenPattern(const UnicodeString& pattern, UErrorCode *err) {
        ParsePosition pos;
        return new UnicodeSet(pattern, pos, 0, NULL, *err);
    }

    inline static _UnicodeSet OpenPatternOptions(const UnicodeString& pattern, int options, UErrorCode *err) {
        ParsePosition pos;
        return new UnicodeSet(pattern, pos, options, NULL, *err);
    }

    inline static _UnicodeSet fromUSet(USet* uset) {
        return UnicodeSet::fromUSet(uset);
    }

    inline USet* toUSet() {
        return impl_->toUSet();
    }

    inline bool IsBogus() const {
        return impl_->isBogus();
    }

    inline void SetToBogus() {
        impl_->setToBogus();
    }

    inline void Close() {
        delete impl_;
        delete this;
    }

    inline _UnicodeSet Clone() const {
        return dynamic_cast<UnicodeSet*>(impl_->clone());
    }

    inline int32_t hashCode() const {
        return impl_->hashCode();
    }

    inline bool IsFrozen() const {
        return impl_->isFrozen();
    }

    inline void Freeze() {
        impl_->freeze();
    }

    inline _UnicodeSet CloneAsThawed() const {
        return dynamic_cast<UnicodeSet*>(impl_->cloneAsThawed());
    }

    inline void Set(UChar32 start, UChar32 end) {
        impl_->set(start, end); 
    }

    inline int ApplyPattern(const UnicodeString& pattern, int options, UErrorCode *err) {
        ParsePosition pos;
        impl_->applyPattern(pattern, pos, options, NULL, *err);
        return pos.getIndex();
    }

    inline void ApplyIntPropertyValue(UProperty prop, int value, UErrorCode *err) {
        impl_->applyIntPropertyValue(prop, value, *err);
    }

    inline void ApplyPropertyAlias(const UnicodeString& prop, const UnicodeString& value, UErrorCode *err) {
        impl_->applyPropertyAlias(prop, value, *err);
    }

    inline static bool ResemblesPattern(const UnicodeString& pattern, int pos) {
        return UnicodeSet::resemblesPattern(pattern, pos);
    }

    inline UnicodeString ToPattern(bool escapeUnprintable, UErrorCode* err) {
        UnicodeString retval;
        impl_->toPattern(retval, escapeUnprintable);
        *err = U_ZERO_ERROR;
        return retval;
    }

    inline void Add(UChar32 c) {
        impl_->add(c);
    }

    inline void AddAll(_UnicodeSet additionalSet) {
        impl_->addAll(*additionalSet.impl_);
    }

    inline void AddRange(UChar32 start, UChar32 end) {
        impl_->add(start, end);
    }

    inline void AddString(const UnicodeString& s) {
        impl_->add(s);
    }

    inline void AddAllCodePoints(const UnicodeString& s) {
        impl_->addAll(s);
    }

    inline void Remove(UChar32 c) {
        impl_->remove(c);
    }

    inline void RemoveRange(UChar32 start, UChar32 end) {
        impl_->remove(start, end);
    }

    inline void RemoveString(const UnicodeString& s) {
        impl_->remove(s);
    }

    inline void RemoveAll(_UnicodeSet removeSet) {
        impl_->removeAll(*removeSet.impl_);
    }

    inline void Retain(UChar32 start, UChar32 end) {
        impl_->retain(start, end);
    }

    inline void RetainAll(_UnicodeSet retain) {
        impl_->retainAll(*retain.impl_);
    }

    inline void Compact() {
        impl_->compact();
    }

    inline void Complement() {
        impl_->complement();
    }

    inline void ComplementAll(_UnicodeSet complement) {
        impl_->complementAll(*complement.impl_);
    }

    inline void Clear() {
        impl_->clear();
    }

    inline void CloseOver(int attributes) {
        impl_->closeOver(attributes);
    }

    inline void RemoveAllStrings() {
        impl_->removeAllStrings();
    }

    inline bool IsEmpty() const {
        return impl_->isEmpty();
    }

    inline bool Contains(UChar32 c) const {
        return impl_->contains(c);
    }

    inline bool ContainsRange(UChar32 start, UChar32 end) const {
        return impl_->contains(start, end);
    }

    inline bool ContainsString(const UnicodeString& str) const {
        return impl_->contains(str);
    }

    inline int IndexOf(UChar32 c) const {
        return impl_->indexOf(c);
    }

    inline UChar32 CharAt(int index) const {
        return impl_->charAt(index);
    }

    inline int Size() const {
        return impl_->size();
    }

    inline int GetItemCount() const {
        return impl_->getRangeCount();
    }

    inline USetRange GetItem(int index, UErrorCode *err) {
        return USetRange(impl_->getRangeStart(index), impl_->getRangeEnd(index));
    }

    inline bool ContainsAll(_UnicodeSet set2) const {
        return impl_->containsAll(*set2.impl_);
    }

    inline bool ContainsAllCodePoints(const UnicodeString& str) const {
        return impl_->containsAll(str);
    }

    inline bool ContainsNone(_UnicodeSet set2) const {
        return impl_->containsNone(*set2.impl_);
    }

    inline bool ContainsSome(_UnicodeSet set2) const {
        return impl_->containsSome(*set2.impl_);
    }

    inline int Span(const UnicodeString& str, USetSpanCondition spanCondition) const {
        return impl_->span(str.getBuffer(), str.length(), spanCondition);
    }

    inline int SpanBack(const UnicodeString& str, USetSpanCondition spanCondition) const {
        return impl_->spanBack(str.getBuffer(), str.length(), spanCondition);
    }

    inline int SpanUTF8(StringPiece str, USetSpanCondition spanCondition) const {
        return impl_->spanUTF8(str.data(), str.length(), spanCondition);
    }

    inline bool Equals(_UnicodeSet set2) const {
        return *impl_ == *set2.impl_;
    }

private:
    inline _UnicodeSet(UnicodeSet* impl): impl_(impl) {}

    inline _UnicodeSet(const UnicodeSet* impl): impl_(const_cast<UnicodeSet*>(impl)) {}

    UnicodeSet* impl_;
};

%}

%nodefaultctor USet;
%nodefaultdtor USet;
%rename(UnicodeSet) _UnicodeSet;
struct _UnicodeSet {
    static _UnicodeSet OpenEmpty();
    static _UnicodeSet Open(UChar32 start, UChar32 end);
    static _UnicodeSet OpenPattern(const UnicodeString& pattern, UErrorCode *err);
    static _UnicodeSet OpenPatternOptions(const UnicodeString& pattern, int options, UErrorCode *err);
    static _UnicodeSet fromUSet(USet* uset);
    USet* toUSet();
    bool IsBogus() const;
    void SetToBogus();
    void Close();
    _UnicodeSet Clone() const;
    int32_t hashCode() const;
    bool IsFrozen() const;
    void Freeze();
    _UnicodeSet CloneAsThawed() const;
    void Set(UChar32 start, UChar32 end);
    int ApplyPattern(const UnicodeString& pattern, int options, UErrorCode *err);
    void ApplyIntPropertyValue(UProperty prop, int value, UErrorCode *err);
    void ApplyPropertyAlias(const UnicodeString& prop, const UnicodeString& value, UErrorCode *err);
    static bool ResemblesPattern(const UnicodeString& pattern, int pos);
    UnicodeString ToPattern(bool escapeUnprintable, UErrorCode* err);
    void Add(UChar32 c);
    void AddAll(_UnicodeSet additionalSet);
    void AddRange(UChar32 start, UChar32 end);
    void AddString(const UnicodeString& s);
    void AddAllCodePoints(const UnicodeString& s);
    void Remove(UChar32 c);
    void RemoveRange(UChar32 start, UChar32 end);
    void RemoveString(const UnicodeString& s);
    void RemoveAll(_UnicodeSet removeSet);
    void Retain(UChar32 start, UChar32 end);
    void RetainAll(_UnicodeSet retain);
    void Compact();
    void Complement();
    void ComplementAll(_UnicodeSet complement);
    void Clear();
    void CloseOver(int attributes);
    void RemoveAllStrings();
    bool IsEmpty() const;
    bool Contains(UChar32 c) const;
    bool ContainsRange(UChar32 start, UChar32 end) const;
    bool ContainsString(const UnicodeString& str) const;
    int IndexOf(UChar32 c) const;
    UChar32 CharAt(int index) const;
    int Size() const;
    int GetItemCount() const;
    USetRange GetItem(int index, UErrorCode *err);
    bool ContainsAll(_UnicodeSet set2) const;
    bool ContainsAllCodePoints(const UnicodeString& str) const;
    bool ContainsNone(_UnicodeSet set2) const;
    bool ContainsSome(_UnicodeSet set2) const;
    int Span(const UnicodeString& str, USetSpanCondition spanCondition) const;
    int SpanBack(const UnicodeString& str, USetSpanCondition spanCondition) const;
    int SpanUTF8(StringPiece str, USetSpanCondition spanCondition) const;
    bool Equals(_UnicodeSet set2) const;
};

