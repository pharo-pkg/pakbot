updating
updateDependenciesOf: aListOfPackageManifest
	^ self basicNew 
		initializeWith: aListOfPackageManifest;
		updateDependencies