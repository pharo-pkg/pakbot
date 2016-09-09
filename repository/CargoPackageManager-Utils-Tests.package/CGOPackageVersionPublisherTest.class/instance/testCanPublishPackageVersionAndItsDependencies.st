tests
testCanPublishPackageVersionAndItsDependencies
	[ (CGOPackageVersionPublisher on: pkgRepository)
		publishDependencies;
		manifests: { ManifestOneDependency };
		run ]
	on: CGOWorkingCopyNotFound 
	do: [ :ex | ex resume "ignore it. it is a test manifest" ].
	
	self assert: (fs / 'onedependency') isDirectory.
	self assert: (fs / 'onedependency' / ('onedependency@' , ManifestOneDependency version asSemanticVersion asString)) isFile.
	self assert: (fs / 'nodependency' / ('nodependency@' , ManifestWithNoDependenciesForTest version asSemanticVersion asString)) isFile.