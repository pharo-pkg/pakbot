tests
testCanPublishOnePackageVersion
	(CGOPackageVersionPublisher on: pkgRepository) 
		manifests: { ManifestOneDependency };
		run.
	
	self assert: (fs / 'onedependency') isDirectory.
	self assert: (fs / 'onedependency' / ('onedependency@' , ManifestFoo version asSemanticVersion asString)) isFile.