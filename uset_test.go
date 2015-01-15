package icu4go

import (
	"testing"
)

func TestUSet_OpenEmpty(t *testing.T) {
	o := USetOpenEmpty()
	defer o.Close()
}

func TestUSet_AddRange(t *testing.T) {
	o := USetOpenEmpty()
	defer o.Close()
	o.AddRange('a', 'z')
	if o.Size() != 26 {
		t.Log(o.Size())
		t.Fail()
	}
	for c := 'a'; c <= 'z'; c++ {
		if !o.Contains(c) {
			t.Log(c)
			t.Fail()
		}
	}
	if o.Contains('0') {
		t.Fail()
	}
}

func TestUSet_ToPattern(t *testing.T) {
	o := USetOpenEmpty()
	defer o.Close()
	o.AddRange('a', 'z')
	o.AddRange('A', 'Z')
	err := U_ZERO_ERROR
	r := o.ToPattern(false, &err)
	if !err.Success() {
		t.FailNow()
	}
	t.Log(r)
	if r != "[A-Za-z]" {
		t.Fail()
	}
}


