tests
testCanPublishOnePackageVersionProvidingVersion
	| version |
	
	version := '1.0'.

	(CGOPackageVersionPublisher on: pkgRepository)
		versionBlock: [:ongoing | version ];
		manifests: { ManifestOneDependency };
		run.
	
	self assert: (fs / 'onedependency') isDirectory.
	self assert: (fs / 'onedependency' / ('onedependency@' , ManifestOneDependency version asSemanticVersion asString)) isFile.
	self 
		assert: ManifestOneDependency version
		equals: version