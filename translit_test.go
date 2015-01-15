package icu4go

import (
	"testing"
	"unicode/utf8"
)

func TestTransliteratorGetAvailableIDs(t *testing.T) {
	err := U_ZERO_ERROR
	e := TransliteratorGetAvailableIDs(&err)
	t.Log(err.Error())
	if !err.Success() {
		t.FailNow()
	}
	s := []byte(nil)
	for e.Next(&s, &err) {
		t.Log(string(s))
	}
	t.Log(err.Error())
	if !err.Success() {
		t.FailNow()
	}
}

func TestTransliteratorCreateInstance(t *testing.T) {
	err := U_ZERO_ERROR
	tl := TransliteratorCreateInstance("Katakana-Latin", UTRANS_FORWARD, &err)
	t.Log(err.Error())
	if !err.Success() {
		t.FailNow()
	}
	defer tl.Close()
	r := tl.GetID()
	t.Log(r)
	if r != "Katakana-Latin" {
		t.Fail()
	}
}

func TestTransliteratorTransliterate(t *testing.T) {
	err := U_ZERO_ERROR
	tl := TransliteratorCreateInstance("Katakana-Latin", UTRANS_FORWARD, &err)
	t.Log(err.Error())
	if !err.Success() {
		t.FailNow()
	}
	defer tl.Close()
	r := tl.Transliterate("テスト")
	t.Log(r)
	if r != "tesuto" {
		t.Fail()
	}
}

func TestTransliteratorTransliterateWithContext(t *testing.T) {
	err := U_ZERO_ERROR
	tl := TransliteratorCreateInstance("Katakana-Hiragana", UTRANS_FORWARD, &err)
	t.Log(err.Error())
	if !err.Success() {
		t.FailNow()
	}
	defer tl.Close()

	s := "テスト"
	pos := NewUTransPosition()
	pos.SetContextStart(0)
	pos.SetStart(0)
	pos.SetContextLimit(utf8.RuneCountInString(s))
	pos.SetLimit(utf8.RuneCountInString(s))
	s = tl.TransliterateWithContext(s, pos, &err)
	t.Log(err.Error())
	if !err.Success() {
		t.FailNow()
	}
	t.Log(s)
	s = tl.FinishTransliteration(s, pos)
	t.Log(s)
	if s != "てすと" {
		t.Fail()
	}
}
