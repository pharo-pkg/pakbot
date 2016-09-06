tests-converting
testAsPackageVersionReference
	| pkgVersion pkgVersionReference |
	pkgVersion := CGOPackageVersion fromString: 'A@1.0'.
	pkgVersionReference := pkgVersion asPackageVersionReference.
	self assert: pkgVersionReference asString equals: 'A@1.0.0'.
