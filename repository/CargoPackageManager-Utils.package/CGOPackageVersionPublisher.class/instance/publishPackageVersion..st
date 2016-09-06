running
publishPackageVersion: ongoing
	(visited includes: ongoing)
		ifTrue: [ ^ self ]
		ifFalse: [ visited add: ongoing ].

	shouldPublishDependencies 
		ifTrue: [ self publishPackages: (ongoing dependencies collect: #targetedPackage) ].
	ongoing isUnit ifTrue: [ 
		srcRepositories ifNotNil: 
			[ ongoing updateRepositories: srcRepositories ] ].
	versionBlock ifNotNil: 
		[ ongoing updateVersionWith: (versionBlock value: ongoing) ].
	ongoing isUnit
		ifTrue: [ ongoing savePackage ].
	pkgRepository savePackageVersion: ongoing asPackageVersion