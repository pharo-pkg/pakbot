tests
testCanPublishOnePackageVersion
	[ (CGOPackageVersionPublisher on: pkgRepository) 
		manifests: { ManifestOneDependency };
		run ]
	on: CGOWorkingCopyNotFound 
	do: [ :ex | ex resume "ignore it. it is a test manifest" ].
	
	self assert: (fs / 'onedependency') isDirectory.
	self assert: (fs / 'onedependency' / ('onedependency@' , ManifestFoo version asSemanticVersion asString)) isFile.