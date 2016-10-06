updating
updateDependenciesOf: manifest
	| currentDependencies manifestDependencies extraDependencies |

	visited nextPut: manifest.
	currentDependencies := (self dependenciesOf: manifest) sorted.
	manifestDependencies := manifest dependencies.
	currentDependencies = manifestDependencies
		ifFalse: [ 
			manifest asOngoingPackageVersion updateManifestDependencies: (currentDependencies collect: [ :each | CGOPackageDependency on: each]).
			"If we find new dependencies, we also need to update the manifest of these new dependencies (#dependencies metatdat could be outdated)"
			extraDependencies := ((currentDependencies difference: manifestDependencies) collect: #packageManifest) 
					difference: visited.
			extraDependencies do: [ :extraManifest | self updateDependenciesOf: extraManifest ] ].
