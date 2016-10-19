tests
testUpdatePackageVersionWith
	| pkgVersion pkgVersion2 result |
	
	self flag: 'This test is failing randomly: sometimes success, sometimes error. Skip it till it has a reproducible status'.
	^ self skip.

	"use an example with more data"
	"pkgVersion := CGOPackageVersion newFrom: 
		( Dictionary new
			add: #package -> #foo;
			add: #version -> '0.2.1-dev' asSemanticVersion;
			add: #description -> 'first';
			yourself ).
	repository savePackageVersion: pkgVersion.
	pkgVersion2 := CGOPackageVersion newFrom: 
		( Dictionary new
			add: #package -> #foo;
			add: #version -> '0.2.1-dev' asSemanticVersion;
			add: #description -> 'second';
			yourself ).
	repository savePackageVersion: pkgVersion2.

	result := repository 
				fetch: #foo
				version: '0.2.1-dev' asSemanticVersion.
	self 
		assert: result description
		equals: 'second'"