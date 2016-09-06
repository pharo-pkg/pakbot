tests
testShouldPackageBeUpToDateAndCleanAfterPublishing
	| pkgName wc manifest repositories |
	
	pkgName := 'CGO-Foo'.
	RPackageOrganizer default registerPackageNamed: pkgName.
	wc := MCWorkingCopy forPackage: (MCPackage new name: pkgName).
	manifest := (TheManifestBuilder ofPackageNamed: pkgName) manifest.
	manifest class compile: 'packageName ^ ', pkgName printString.
	repositories := { 'file://' , MCCacheRepository cacheDirectory fullName }.

	self assert: wc needsSaving.
	(CGOPackageVersionPublisher on: pkgRepository)
		manifests: { manifest };
		srcRepositories: repositories;
		run.
	
	self 
		assert: manifest repositories 
		equals: repositories.
	self deny: wc needsSaving.
	wc unload
