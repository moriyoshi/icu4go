package icu4go

import (
	"testing"
)

func TestLocale_GetAvailableLocales(t *testing.T) {
	r := LocaleGetAvailableLocales()
	for _, l := range r {
		t.Log(l.GetISO3Language())
		l.Close()
	}
}

func TestLocale_GetISOCountries(t *testing.T) {
	r := LocaleGetISOCountries()
	for _, s := range r {
		t.Log(s)
	}
}

