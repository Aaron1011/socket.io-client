
REPORTER = dot

build: socket.io.js

socket.io.js: lib/*.js package.json
	@./support/browserify.sh > socket.io.js

test:
	@./node_modules/.bin/mocha \
		--reporter $(REPORTER) \
		--bail \
		test/index.js
ifeq ($(TRAVIS_SECURE_ENV_VARS),true)
	@./node_modules/.bin/zuul -- test/index.js
endif


test-cov:
	@./node_modules/.bin/istanbul cover ./node_modules/.bin/_mocha -- \
		--reporter $(REPORTER) \
		test/

.PHONY: test
