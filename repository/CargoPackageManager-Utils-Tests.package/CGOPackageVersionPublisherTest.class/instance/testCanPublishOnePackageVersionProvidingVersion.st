tests
testCanPublishOnePackageVersionProvidingVersion
	| version |
	
	version := '1.0'.

	[ (CGOPackageVersionPublisher on: pkgRepository)
		versionBlock: [:ongoing | version ];
		manifests: { ManifestOneDependency };
		run]
	on: CGOWorkingCopyNotFound 
	do: [ :ex | ex resume "ignore it. it is a test manifest" ].
	
	self assert: (fs / 'onedependency') isDirectory.
	self assert: (fs / 'onedependency' / ('onedependency@' , ManifestOneDependency version asSemanticVersion asString)) isFile.
	self 
		assert: ManifestOneDependency version
		equals: version