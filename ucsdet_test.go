package icu4go

import (
	"testing"
)

func TestUCharsetDetector(t *testing.T) {
	err := U_ZERO_ERROR
	cd := UCharsetDetectorOpen(&err)
	t.Log(err.Error())
	if !err.Success() {
		t.FailNow()
	}
	defer cd.Close()
	cd.SetText([]byte("テスト"), &err)
	t.Log(err.Error())
	if !err.Success() {
		t.FailNow()
	}
	m := cd.Detect(&err)
	t.Log(err.Error())
	if !err.Success() {
		t.FailNow()
	}
	n := m.GetName(&err)
	t.Log(err.Error())
	if !err.Success() {
		t.FailNow()
	}
	t.Log(n)
	if n != "UTF-8" {
		t.Fail()
	}
	t.Log(m.GetConfidence(&err))
	t.Log(err.Error())
	if !err.Success() {
		t.FailNow()
	}
	t.Log(m.GetLanguage(&err))
	t.Log(err.Error())
	if !err.Success() {
		t.FailNow()
	}
	ms := cd.DetectAll(&err)
	t.Log(err.Error())
	if !err.Success() {
		t.FailNow()
	}
	t.Log(len(ms))
	if len(ms) != 1 {
		t.FailNow()
	}
	if ms[0].GetName(&err) != "UTF-8" {
		t.Fail()
	}

}

func TestUCharsetDetectorAllDetectableCharsets(t *testing.T) {
	err := U_ZERO_ERROR
	cd := UCharsetDetectorOpen(&err)
	t.Log(err.Error())
	if !err.Success() {
		t.FailNow()
	}
	defer cd.Close()
	e := cd.GetAllDetectableCharsets(&err)
	t.Log(err.Error())
	if !err.Success() {
		t.FailNow()
	}
	defer e.Close()
	for {
		b := ""
		if !e.UNext(&b, &err) {
			break
		}
		t.Log(err.Error())
		if !err.Success() {
			t.FailNow()
		}
		t.Log(b)
	}
}
