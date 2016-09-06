private
manifestsForAllCurrentDependenciesOfManifest: aManifest
	"List dependencies and transitive dependencies of the given manifest by using the information  present in the manifest #dependencies method (could be outdated)."
	| iterator deps |
	
	iterator := (BFSIterator 
		on: aManifest
		nextBlock: 
			[ :manifest |
			manifest asOngoingPackageVersion dependencies
				reject: [ :each | manifest ignoredDependencies includes: each targetedPackage ]
				thenCollect: [ :each | each targetedPackage packageManifest ] ]).
	
	deps := Set new.
	[ iterator hasNext ] whileTrue: [ deps add: iterator next ].
	^ (deps reject: [ :manifest | manifest asOngoingPackageVersion isAssembly ]) 
		asArray