.PHONY: build-release
build-release:
	cargo build --release

.PHONY: install
install:
	cp target/release/wmd77 /usr/bin
	cp -r /etc/xdg/* /etc/xdg/
	cp wmd77.desktop /usr/share/xsessions/

.PHONY: uninstall
uninstall:
	rm /usr/bin/wmd77
	rm -rf /etc/xdg/wmd77
	rm /usr/share/xsessions/wmd77.desktop
