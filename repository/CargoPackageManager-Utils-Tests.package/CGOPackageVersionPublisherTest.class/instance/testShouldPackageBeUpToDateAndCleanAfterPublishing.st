tests
testShouldPackageBeUpToDateAndCleanAfterPublishing
	| pkgName wc manifest |
	
	pkgName := 'CGO-Foo'.
	RPackageOrganizer default registerPackageNamed: pkgName.
	wc := MCWorkingCopy forPackage: (MCPackage new name: pkgName).
	manifest := (TheManifestBuilder ofPackageNamed: pkgName) manifest.
	manifest class compile: 'packageName ^ ', pkgName printString.
	manifest class compile: 'src 
	^ { #backend -> #monticello .
		#repositoryUrl -> ', '''file://' , MCCacheRepository cacheDirectory fullName , ''' .
		#packageName -> #''CGO-Foo'' .
		#versionString -> ''testRunner.1'' } asDictionary'.

	self assert: wc needsSaving.
	(CGOPackageVersionPublisher on: pkgRepository)
		manifests: { manifest };
		run.
	
	self 
		assert: manifest sourcePackageVersion 
		equals: { #backend -> #monticello .
		#repositoryUrl -> ('file://' , MCCacheRepository cacheDirectory fullName) .
		#packageName -> #'CGO-Foo' .
		#versionString -> 'testRunner.1' } asDictionary.
	self deny: wc needsSaving.
	wc unload
