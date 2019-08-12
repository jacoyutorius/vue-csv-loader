VERSION := v0.1.0

package:
	@echo ${VERSION}
	@git tag -a ${VERSION} -m "set ${VERSION}"
	@git push origin tags/${VERSION}