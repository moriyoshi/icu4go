package icu4go

import (
	"testing"
)

func TestUConverterGetAliases(t *testing.T) {
	err := UErrorCode(0)
	result := UConverterGetAliases("csShift_JIS", &err)
	t.Log(err)
	if !err.Success() {
		t.FailNow()
	}
	for _, r := range result {
		t.Log(r)
	}

}

func TestUConverterGetAvailableNames(t *testing.T) {
	result := UConverterGetAvailableNames()
	for _, r := range result {
		t.Log(r)
	}

}

func TestUConverterOpen(t *testing.T) {
	err := U_ZERO_ERROR
	c := UConverterOpen("csShift_JIS", &err)
	c.SetSubstString("？", &err)
	a := c.GetSubstChars(&err)
	t.Log(err.Error())
	if !err.Success() {
		t.FailNow()
	}
	t.Log(a)
	if len(a) != 2 || a[0] != 0x81 || a[1] != 0x48 {
		t.Fail()
	}
	t.Log(c.GetInvalidChars(&err))
	t.Log(err.Error())
	c.Close()
}

func TestUcnv_GetStarters(t *testing.T) {
	err := U_ZERO_ERROR
	c := UConverterOpen("csShift_JIS", &err)
	t.Log(err.Error())
	if !err.Success() {
		t.FailNow()
	}
	a := c.GetStarters(&err)
	t.Log(err.Error())
	if !err.Success() {
		t.FailNow()
	}
	t.Log(a)
	if len(a) != 256 {
		t.Fail()
	}
	for i := 0; i < 0x81; i++ {
		if a[i] != 0 {
			t.Log(i)
			t.Fail()
		}
	}
	for i := 0x81; i < 0xa0; i++ {
		if a[i] == 0 {
			t.Log(i)
			t.Fail()
		}
	}
	for i := 0xa0; i < 0xe0; i++ {
		if a[i] != 0 {
			t.Log(i)
			t.Fail()
		}
	}
	for i := 0xe0; i < 0xfd; i++ {
		if a[i] == 0 {
			t.Log(i)
			t.Fail()
		}
	}
	for i := 0xfd; i <= 0xff; i++ {
		if a[i] != 0 {
			t.Log(i)
			t.Fail()
		}
	}
	c.Close()
}

func TestUCnv_GetUnicodeSet(t *testing.T) {
	err := U_ZERO_ERROR
	c := UConverterOpen("ISO-8859-1", &err)
	t.Log(err.Error())
	if !err.Success() {
		t.FailNow()
	}
	err = U_ZERO_ERROR
	s := c.GetUnicodeSet(UCNV_ROUNDTRIP_SET, &err)
	if !err.Success() {
		t.FailNow()
	}
	t.Log(s.Size())
	if s.Size() != 256 {
		t.FailNow()
	}
	c.Close()
}

func TestUCnv_FromUnicode(t *testing.T) {
	err := U_ZERO_ERROR
	c := UConverterOpen("csShift_JIS", &err)
	t.Log(err.Error())
	if !err.Success() {
		t.FailNow()
	}
	d := make([]byte, 16)
	s := []uint16 { 0x3042, 0x3044, 0x3046, 0x3048, 0x304a }
	td := d[0:2]
	ts := s[:]
	c.FromUnicode(&td, &ts, nil, false, &err)
	t.Log(err.Error())
	if err != U_BUFFER_OVERFLOW_ERROR {
		t.FailNow()
	}
	if len(td) != 0 {
		t.Fail()
	}
	if len(ts) != 4 {
		t.Fail()
	}
	td = d[2:6]
	err = U_ZERO_ERROR
	c.FromUnicode(&td, &ts, nil, false, &err)
	t.Log(err.Error())
	if err != U_BUFFER_OVERFLOW_ERROR {
		t.FailNow()
	}
	t.Log(len(td))
	if len(td) != 0 {
		t.Fail()
	}
	t.Log(len(ts))
	if len(ts) != 2 {
		t.Fail()
	}
	td = d[6:]
	err = U_ZERO_ERROR
	c.FromUnicode(&td, &ts, nil, false, &err)
	t.Log(err.Error())
	if err != U_ZERO_ERROR {
		t.FailNow()
	}
	t.Log(len(td))
	if len(td) != 6 {
		t.Fail()
	}
	t.Log(len(ts))
	if len(ts) != 0 {
		t.Fail()
	}
	if d[0] != 0x82 || d[1] != 0xa0 {
		t.Fail()
	}
	if d[2] != 0x82 || d[3] != 0xa2 {
		t.Fail()
	}
	if d[4] != 0x82 || d[5] != 0xa4 {
		t.Fail()
	}
	if d[6] != 0x82 || d[7] != 0xa6 {
		t.Fail()
	}
	if d[8] != 0x82 || d[9] != 0xa8 {
		t.Fail()
	}
	t.Log(d)
}

func TestUCnv_SetToUCallBack(t *testing.T) {
	err := U_ZERO_ERROR
	c := UConverterOpen("csShift_JIS", &err)
	t.Log(err.Error())
	if !err.Success() {
		t.FailNow()
	}
	c.SetToUCallBack(func (flush bool, converter UConverter, source []byte, target []uint16, offsets []int32, reason UConverterCallbackReason, err*UErrorCode) {
		t.Log(converter)
		t.Log(flush)
		t.Log(reason)
		t.Log(target)
		t.Log(source)
		t.Log(offsets)
	}, &err)
	if !err.Success() {
		t.FailNow()
	}
	a := c.ToUTF8([]byte { 0x82, 0xa0 }, &err)
	t.Log(err.Error())
	if !err.Success() {
		t.FailNow()
	}
	t.Log(a)
	if a != "あ" {
		t.Fail()
	}
	a = c.ToUTF8([]byte { 0x82, 0xfe }, &err)
	t.Log(err.Error())
	if err != U_ILLEGAL_CHAR_FOUND {
		t.FailNow()
	}
	t.Log(a)
	if a != "" {
		t.Fail()
	}
}

func TestUConverterOpenStandardNames(t *testing.T) {
	expected := map[string]bool {
		"ANSI_X3.4-1968": true,
		"US-ASCII": true,
		"ASCII": true,
		"ANSI_X3.4-1986": true,
		"ISO_646.irv:1991": true,
		"ISO646-US": true,
		"us": true,
		"csASCII": true,
		"iso-ir-6": true,
		"cp367": true,
		"IBM367": true,
	}
	err := U_ZERO_ERROR
	e := UConverterOpenStandardNames("ASCII", "IANA", &err)
	t.Log(err.Error())
	if !err.Success() {
		t.FailNow()
	}
	defer e.Close()
	s := ""
	ts := &s
	err = U_ZERO_ERROR;
	c := e.Count(&err)
	t.Log(c)
	t.Log(err.Error())
	if !err.Success() {
		t.FailNow()
	}
	if c != len(expected) {
		t.Fail()
	}
	results := make([]string, 0, 11)
	for ; e.UNext(&s, &err); {
		results = append(results, s)
		t.Log(s)
	}
	t.Log(err.Error())
	if !err.Success() {
		t.FailNow()
	}
	t.Log(*ts)
	t.Log(results)
	if len(results) != len(expected) {
		t.Fail()
	}
	for _, result := range results {
		if _, ok := expected[result]; !ok {
			t.Fail()
		}
	}
}

func TestUConverterDetectUnicodeSignature(t *testing.T) {
	err := U_ZERO_ERROR
	sl := int(0)
	r := UConverterDetectUnicodeSignature([]byte { 0xff, 0xfe }, &sl, &err)
	if !err.Success() {
		t.FailNow()
	}
	t.Log(r)
	if sl != 2 {
		t.Fail()
	}
	if r != "UTF-16LE" {
		t.Fail()
	}
	sl = int(0)
	r = UConverterDetectUnicodeSignature([]byte { 0x00, 0x00, 0xfe, 0xff }, &sl, &err)
	if !err.Success() {
		t.FailNow()
	}
	t.Log(r)
	if sl != 4 {
		t.Fail()
	}
	if r != "UTF-32BE" {
		t.Fail()
	}
}
