updating
updateDependencies
	manifests do: [ :manifest | | dependencies |
		dependencies := (self dependenciesOf: manifest) sorted.
		dependencies = manifest dependencies
			ifFalse: [ 
				dependencies := dependencies collect: [ :each | CGOPackageDependency on: each].
				manifest asOngoingPackageVersion updateManifestDependencies: dependencies ] ]