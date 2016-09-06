tests
testCanPublishPackageVersionAndItsDependencies
	(CGOPackageVersionPublisher on: pkgRepository)
		publishDependencies;
		manifests: { ManifestOneDependency };
		run.
	
	self assert: (fs / 'onedependency') isDirectory.
	self assert: (fs / 'onedependency' / ('onedependency@' , ManifestOneDependency version asSemanticVersion asString)) isFile.
	self assert: (fs / 'nodependency' / ('nodependency@' , ManifestWithNoDependenciesForTest version asSemanticVersion asString)) isFile.