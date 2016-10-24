tests
testStonOnWithApkgWithDependencyWithNoConstraint
	| dictionary pkgVersion result |
	
	dictionary := Dictionary new.
	dictionary
		add: #package -> #A;
		add: #version -> '1.0';
		add: #description -> 'A test package version.';
		add: #sourcePackageVersion -> (CGOMonticelloHostedPackageVersion 
			repositoryUrl: 'http://smalltalkhub.com/mc/Foo/Bar/main'
			packageName: 'no-file-specified'
			versionString: 'JohnDoe.0');
		add: #dependencies -> { #B -> #() }.
	pkgVersion := CGOPackageVersion newFrom: dictionary. 
	pkgVersion
		instVarNamed: 'timestamp'
		put: (DateAndTime fuzzyReadFrom: '2015-02-26T12:17:20.505912+01:00' readStream).
	result := String streamContents: [ :stream | (CGOPackageVersionWriter on: stream)
		referencePolicy: #ignore;
		prettyPrint: true; 
		nextPut: pkgVersion;
		yourself ].
	self assert: result equals: self aWithDependencyWithNoConstraint