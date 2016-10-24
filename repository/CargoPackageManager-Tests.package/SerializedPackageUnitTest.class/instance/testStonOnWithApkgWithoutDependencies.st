tests
testStonOnWithApkgWithoutDependencies
	| dictionary pkgVersion result |
	
	dictionary := Dictionary
		with: #package -> #A
		with: #version -> '1.0'
		with: #description -> 'A test package version.'
		with: #sourceRepository -> (CGOMonticelloHostedPackageVersion 
			repositoryUrl: 'http://smalltalkhub.com/mc/Foo/Bar/main'
			packageName: 'no-file-specified'
			versionString: 'JohnDoe.0').
	pkgVersion := CGOPackageVersion newFrom: dictionary.
	pkgVersion
		instVarNamed: 'timestamp'
		put: (DateAndTime fuzzyReadFrom: '2015-02-26T12:17:20.505912+01:00' readStream).
	result := String streamContents: [ :stream | (CGOPackageVersionWriter on: stream)
		referencePolicy: #ignore;
		prettyPrint: true; 
		nextPut: pkgVersion;
		yourself ].
	self assert: result equals: self a100WithoutDependencies