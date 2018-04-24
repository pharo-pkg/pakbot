tests-converting
testAsPackageVersionReference
	| pkgVersion pkgVersionReference |
	pkgVersion := CGOPackageUnit example.
	pkgVersionReference := pkgVersion asPackageVersionReference.
	self assert: pkgVersionReference asString equals: 'UnitTest@2.1.0'.
