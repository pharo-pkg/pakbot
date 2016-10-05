updating
updateDependenciesOf: manifest
	| currentDependencies extraDependencies |

	visited nextPut: manifest.
	currentDependencies := (self dependenciesOf: manifest) sorted.
	currentDependencies = manifest dependencies
		ifFalse: [ 
			manifest asOngoingPackageVersion updateManifestDependencies: (currentDependencies collect: [ :each | CGOPackageDependency on: each]).
			"If we find new dependencies, we also need to update the manifest of these new dependencies (#dependencies metatdat could be outdated)"
			extraDependencies := ((currentDependencies difference: manifest dependencies) collect: #packageManifest) 
					difference: visited.
			extraDependencies do: [ :extraManifest | self updateDependenciesOf: extraManifest ] ].
