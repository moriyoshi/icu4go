LIBICU_LDFLAGS=
BUILDFLAGS=-x -work -v -tags "$(shell cat buildtags)" -ldflags "-extld $(CXX) -extldflags '-licuuc -licui18n'"

test: icu_version.i buildtags
	go test $(BUILDFLAGS) ./...

install: icu_version.i buildtags
	go install $(BUILDFLAGS)

clean:
	rm -f icu_version.i buildtags

icu_version.i buildtags:
	./mkversion.sh

.PHONY: generate install test clean
# vim: noet
