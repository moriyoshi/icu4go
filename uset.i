%module icu4go
%{
#include <unicode/uset.h>

struct USetRange {
    UChar32 start;
    UChar32 end;
    inline USetRange(UChar32 start = -1, UChar32 end = -1): start(start), end(end) {}
};

struct USet {
    inline static USet *OpenEmpty() {
        return uset_openEmpty();
    }

    inline static USet *Open(UChar32 start, UChar32 end) {
        return uset_open(start, end);
    }

    inline static USet *OpenPattern(const icu::UnicodeString& pattern, UErrorCode *err) {
        return uset_openPattern(pattern.getBuffer(), pattern.length(), err);
    }

    inline static USet *OpenPatternOptions(const icu::UnicodeString& pattern, int options, UErrorCode *err) {
        return uset_openPatternOptions(pattern.getBuffer(), pattern.length(), options, err);
    }

    inline void Close() {
        return uset_close(this);
    }

    inline USet* Clone() const {
        return uset_clone(this);
    }

    inline bool IsFrozen() const {
        return uset_isFrozen(this);
    }

    inline void Freeze() {
        uset_freeze(this);
    }

    inline USet *CloneAsThawed() const {
        return uset_cloneAsThawed(this);
    }

    inline void Set(UChar32 start, UChar32 end) {
        uset_set(this, start, end); 
    }

    inline int ApplyPattern(const icu::UnicodeString& pattern, int options, UErrorCode *err) {
        return uset_applyPattern(this, pattern.getBuffer(), pattern.length(), options, err);
    }

    inline void ApplyIntPropertyValue(UProperty prop, int value, UErrorCode *err) {
        uset_applyIntPropertyValue(this, prop, value, err);
    }

    inline void ApplyPropertyAlias(const icu::UnicodeString& prop, const icu::UnicodeString& value, UErrorCode *err) {
        uset_applyPropertyAlias(this, prop.getBuffer(), prop.length(), value.getBuffer(), value.length(), err);
    }

    inline static bool ResemblesPattern(const icu::UnicodeString& pattern, int pos) {
        return uset_resemblesPattern(pattern.getBuffer(), pattern.length(), pos);
    }

    inline icu::UnicodeString ToPattern(bool escapeUnprintable, UErrorCode* err) {
        UErrorCode _err = U_ZERO_ERROR;
        icu::UnicodeString retval;
        int32_t cap(uset_size(this) * 2);
        UChar* buf(retval.getBuffer(cap));
        int32_t l(uset_toPattern(this, buf, cap, escapeUnprintable, &_err));
        if (U_SUCCESS(_err))
            retval.releaseBuffer(l);
        else {
            retval.releaseBuffer(0);
            *err = _err;
        }
        return retval;
    }

    inline void Add(UChar32 c) {
        uset_add(this, c);
    }

    inline void AddAll(const USet* additionalSet) {
        uset_addAll(this, additionalSet);
    }

    inline void AddRange(UChar32 start, UChar32 end) {
        uset_addRange(this, start, end);
    }

    inline void AddString(const icu::UnicodeString& s) {
        uset_addString(this, s.getBuffer(), s.length());
    }

    inline void AddAllCodePoints(const icu::UnicodeString& s) {
        uset_addAllCodePoints(this, s.getBuffer(), s.length());
    }

    inline void Remove(UChar32 c) {
        uset_remove(this, c);
    }

    inline void RemoveRange(UChar32 start, UChar32 end) {
        uset_removeRange(this, start, end);
    }

    inline void RemoveString(const icu::UnicodeString& s) {
        uset_removeString(this, s.getBuffer(), s.length());
    }

    inline void RemoveAll(const USet* removeSet) {
        uset_removeAll(this, removeSet);
    }

    inline void Retain(UChar32 start, UChar32 end) {
        uset_retain(this, start, end);
    }

    inline void RetainAll(const USet *retain) {
        uset_retainAll(this, retain);
    }

    inline void Compact() {
        uset_compact(this);
    }

    inline void Complement() {
        uset_complement(this);
    }

    inline void ComplementAll(const USet *complement) {
        uset_complementAll(this, complement);
    }

    inline void Clear() {
        uset_clear(this);
    }

    inline void CloseOver(int attributes) {
        uset_closeOver(this, attributes);
    }

    inline void RemoveAllStrings() {
        uset_removeAllStrings(this);
    }

    inline bool IsEmpty() const {
        return uset_isEmpty(this);
    }

    inline bool Contains(UChar32 c) const {
        return uset_contains(this, c);
    }

    inline bool ContainsRange(UChar32 start, UChar32 end) const {
        return uset_containsRange(this, start, end);
    }

    inline bool ContainsString(const icu::UnicodeString& str) const {
        return uset_containsString(this, str.getBuffer(), str.length());
    }

    inline int IndexOf(UChar32 c) const {
        return uset_indexOf(this, c);
    }

    inline UChar32 CharAt(int index) const {
        return uset_charAt(this, index);
    }

    inline int Size() const {
        return uset_size(this);
    }

    inline int GetItemCount() const {
        return uset_getItemCount(this);
    }

    inline USetRange GetItem(int index, UErrorCode *err) {
        USetRange retval;
        uset_getItem(this, index, &retval.start, &retval.end, NULL, 0, err);
        return retval;
    }

    inline bool ContainsAll(const USet* set2) const {
        return uset_containsAll(this, set2);
    }

    inline bool ContainsAllCodePoints(const icu::UnicodeString& str) const {
        return uset_containsAllCodePoints(this, str.getBuffer(), str.length());
    }

    inline bool ContainsNone(const USet* set2) const {
        return uset_containsNone(this, set2);
    }

    inline bool ContainsSome(const USet* set2) const {
        return uset_containsSome(this, set2);
    }

    inline int Span(const icu::UnicodeString& str, USetSpanCondition spanCondition) const {
        return uset_span(this, str.getBuffer(), str.length(), spanCondition);
    }

    inline int SpanBack(const icu::UnicodeString& str, USetSpanCondition spanCondition) const {
        return uset_spanBack(this, str.getBuffer(), str.length(), spanCondition);
    }

    inline int SpanUTF8(StringPiece str, USetSpanCondition spanCondition) const {
        return uset_spanBackUTF8(this, str.data(), str.length(), spanCondition);
    }

    inline bool Equals(const USet* set2) const {
        return uset_equals(this, set2);
    }
};

%}

enum {
    USET_IGNORE_SPACE,
    USET_CASE_INSENSITIVE,
    USET_ADD_CASE_MAPPINGS
};

enum USetSpanCondition {
    USET_SPAN_NOT_CONTAINED,
    USET_SPAN_CONTAINED,
    USET_SPAN_SIMPLE,
    USET_SPAN_CONDITION_COUNT
};

enum {
    USET_SERIALIZED_STATIC_ARRAY_CAPACITY
};

struct USetRange {
    UChar32 start;
    UChar32 end;
};

%nodefaultctor USet;
struct USet {
    static USet *OpenEmpty();
    static USet *Open(UChar32 start, UChar32 end);
    static USet *OpenPattern(const icu::UnicodeString& pattern, UErrorCode *err);
    static USet *OpenPatternOptions(const icu::UnicodeString& pattern, int options, UErrorCode *err);
    void Close();
    USet* Clone() const;
    bool IsFrozen() const;
    void Freeze();
    USet *CloneAsThawed() const;
    void Set(UChar32 start, UChar32 end);
    int ApplyPattern(const icu::UnicodeString& pattern, int options, UErrorCode *err);
    void ApplyIntPropertyValue(UProperty prop, int value, UErrorCode *err);
    void ApplyPropertyAlias(const icu::UnicodeString& prop, const icu::UnicodeString& value, UErrorCode *err);
    static bool ResemblesPattern(const icu::UnicodeString& pattern, int pos);
    icu::UnicodeString ToPattern(bool escapeUnprintable, UErrorCode* err);
    void Add(UChar32 c);
    void AddAll(const USet* additionalSet);
    void AddRange(UChar32 start, UChar32 end);
    void AddString(const icu::UnicodeString& s);
    void AddAllCodePoints(const icu::UnicodeString& s);
    void Remove(UChar32 c);
    void RemoveRange(UChar32 start, UChar32 end);
    void RemoveString(const icu::UnicodeString& s);
    void RemoveAll(const USet* removeSet);
    void Retain(UChar32 start, UChar32 end);
    void RetainAll(const USet *retain);
    void Compact();
    void Complement();
    void ComplementAll(const USet *complement);
    void Clear();
    void CloseOver(int attributes);
    void RemoveAllStrings();
    bool IsEmpty() const;
    bool Contains(UChar32 c) const;
    bool ContainsRange(UChar32 start, UChar32 end) const;
    bool ContainsString(const icu::UnicodeString& str) const;
    int IndexOf(UChar32 c) const;
    UChar32 CharAt(int index) const;
    int Size() const;
    int GetItemCount() const;
    USetRange GetItem(int index, UErrorCode *err);
    bool ContainsAll(const USet* set2) const;
    bool ContainsAllCodePoints(const icu::UnicodeString& str) const;
    bool ContainsNone(const USet* set2) const;
    bool ContainsSome(const USet* set2) const;
    int Span(const icu::UnicodeString& str, USetSpanCondition spanCondition) const;
    int SpanBack(const icu::UnicodeString& str, USetSpanCondition spanCondition) const;
    int SpanUTF8(StringPiece str, USetSpanCondition spanCondition) const;
    int Equals(const USet* set2) const;
};
