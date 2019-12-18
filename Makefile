VERSION?=0.0.2
PREFIX?=/usr/local
PKG=pkg/compose-$(VERSION).tar.gz
SIG=$(PKG).asc

# Sign the tarball
$(SIG): $(PKG)
	@gpg --sign --detach-sign --armor $(PKG)

# Create the tarball
$(PKG): pkg
	@git archive master -o pkg/compose-$(VERSION).tar.gz
pkg:
	@mkdir -p pkg/


# Install `compose` to the local machine
install:
	@install bin/compose $(PREFIX)/bin
.PHONY: install

# Remove `compose` from the local machine
uninstall:
	@rm -rf $(PREFIX)/bin/compose
.PHONY: uninstall

# Build the tarball and the release, then add the tarball to the GitHub
# release as an artifact
dist: $(SIG)
	@git add $(SIG)
	@git commit -m "Release $(VERSION)" $(SIG)
	@git push origin master
	@hub release create -a $(PKG) -m "Release v$(VERSION)" $(VERSION)
.PHONY: dist

# Remove the pkg directory
distclean:
	@rm -rf pkg/*.tar.gz
clean: distclean
.PHONY: clean distclean
