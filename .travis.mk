WORK=$(HOME)/gopath

script: run_test

before_install: install_libicu_dev install_swig

install_libicu_dev:
	sudo apt-get install libicu-dev

install_swig:
	curl -O -L http://prdownloads.sourceforge.net/swig/swig-3.0.4.tar.gz && \
	tar xfz swig-3.0.4.tar.gz && \
	cd swig-3.0.4 && \
	./configure --prefix=$(WORK) >/dev/null && \
	make >/dev/null && make install && \
	cd .. && rm -rf swig-3.0.4

run_test:
	$(MAKE) test

.PHONY: script before_install install_swig run_test
# vim: noet
