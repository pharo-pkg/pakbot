tests
testCanPublishOnePackageVersionProvidingRepository
	| repos |
	
	repos := #('http://smalltalkhub.com/mc/Pharo/Pharo60/main').

	(CGOPackageVersionPublisher on: pkgRepository)
		srcRepositories: repos;
		manifests: { ManifestOneDependency };
		run.
	
	self assert: (fs / 'onedependency') isDirectory.
	self assert: (fs / 'onedependency' / ('onedependency@' , ManifestOneDependency version asSemanticVersion asString)) isFile.
	self 
		assert: ManifestOneDependency repositories 
		equals: repos