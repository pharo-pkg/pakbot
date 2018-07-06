tests
testAsPackageVersionReference
	| pkgVersion pkgVersionReference |
	pkgVersion := CGOVirtualPackageVersion fromString: 'V@1.0'.
	pkgVersionReference := pkgVersion asPackageVersionReference.
	self assert: pkgVersionReference asString equals: 'V@1.0.0'.
