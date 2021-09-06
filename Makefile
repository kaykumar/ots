VER_BOOTSTRAP=4.3.1
VER_BOOTSWATCH=4.3.1
VER_FONTAWESOME=5.14.0
VER_GIBBERISH_AES=1.0.0
VER_JQUERY=3.4.1
VER_POPPER=1.15.0
VER_VUE=2.6.10
VER_VUE_I18N=8.12.0


default: generate

generate: download_libs
	docker run --rm -ti -v $(CURDIR):$(CURDIR) -w $(CURDIR)/src node:14-alpine \
		sh -exc "npx npm@lts ci && npx npm@lts run build && chown -R $(shell id -u) ../frontend node_modules"

publish:
	curl -sSLo golang.sh https://raw.githubusercontent.com/Luzifer/github-publish/master/golang.sh
	bash golang.sh

# -- Download / refresh external libraries --

clean_libs:
	rm -rf frontend/css frontend/webfonts frontend/js

download_libs: clean_libs fontawesome

fontawesome:
	curl -sSfL https://github.com/FortAwesome/Font-Awesome/archive/$(VER_FONTAWESOME).tar.gz | \
		tar -vC frontend -xz --strip-components=1 --wildcards --exclude='*/js-packages' '*/css' '*/webfonts'
