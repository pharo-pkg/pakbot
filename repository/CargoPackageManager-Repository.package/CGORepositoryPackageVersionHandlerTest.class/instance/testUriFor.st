tests-private
testUriFor
	| pkgVersion |
	pkgVersion := CGOPackageVersion fromString: 'foo@0.1'.
	self 
		assert: (CGORepositoryPackageVersionHandler new uriFor: pkgVersion)
		equals: '/packages/foo/0.1.0'