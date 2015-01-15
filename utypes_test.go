package icu4go

import (
	"testing"
)

func TestUtypes_UErrorCode_Success(t *testing.T) {
	{
		z := U_ZERO_ERROR
		if !z.Success() {
			t.Fail()
		}
	}
	{
		z := U_ZERO_ERROR - 1
		if !z.Success() {
			t.Fail()
		}
	}
	{
		z := U_ZERO_ERROR + 1
		if z.Success() {
			t.Fail()
		}
	}
}

func TestUtypes_UErrorCode_Failure(t *testing.T) {
	{
		z := U_ZERO_ERROR
		if z.Failure() {
			t.Fail()
		}
	}
	{
		z := U_ZERO_ERROR - 1
		if z.Failure() {
			t.Fail()
		}
	}
	{
		z := U_ZERO_ERROR + 1
		if !z.Failure() {
			t.Fail()
		}
	}
}

func TestUtypes_UErrorCode_Error(t *testing.T) {
	{
		z := U_ZERO_ERROR
		if z.Error() != "U_ZERO_ERROR" {
			t.Fail()
		}
	}
}

