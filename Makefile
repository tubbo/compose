VERSION?=0.0.1
PREFIX?=/usr/local
PKG=pkg/compose-$(VERSION).tar.gz
SIG=$(PKG).asc

# Create the tarball
$(PKG): pkg
	@git archive master -o pkg/compose-$(VERSION).tar.gz
pkg:
	@mkdir -p pkg/

# Sign the tarball
$(SIG): $(PKG)
	@gpg --sign --detach-sign --armor $(PKG)

install:
	@install bin/compose $(PREFIX)/bin
.PHONY: install

uninstall:
	@rm -rf $(PREFIX)/bin/compose
.PHONY: uninstall

release: $(SIG)
	@git add $(SIG)
	@git commit -m "Release $(VERSION)" $(SIG)
	@git tag $(VERSION) -m "Release $(VERSION)"
	@git push origin --tags
	@git push origin master
.PHONY: release

clean:
	@rm -rf pkg
.PHONY: clean
