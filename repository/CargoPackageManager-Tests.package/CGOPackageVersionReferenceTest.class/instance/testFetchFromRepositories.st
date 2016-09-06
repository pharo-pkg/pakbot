tests
testFetchFromRepositories
	| packageVersion |
	packageVersion := pkgVersionReference fetchFromRepositories.
	self assertIsExpectedPackageVersion: packageVersion