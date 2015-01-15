%module icu4go
%{
#include <unicode/errorcode.h>
%}

class ErrorCode {
public:
    ErrorCode();
    virtual ~ErrorCode();
    operator UErrorCode & ();
    operator UErrorCode * ();
    UBool isSuccess() const;
    UBool isFailure() const;
    UErrorCode get() const;
    void set(UErrorCode value);
    UErrorCode reset();
    const char* errorName() const;
};
