// +build normalizer2

package icu4go

import (
	"testing"
)

func TestNormalizer2GetNFKCInstance(t *testing.T) {
	err := U_ZERO_ERROR
	n := Normalizer2GetNFKCInstance(&err)
	t.Log(err.Error())
	if !err.Success() {
		t.FailNow()
	}
	r := n.Normalize("か\u3099", &err)
	t.Log(err.Error())
	if !err.Success() {
		t.FailNow()
	}
	t.Log(len(r))
	t.Log([]byte(r))
	if r != "が" {
		t.Fail()
	}
}
