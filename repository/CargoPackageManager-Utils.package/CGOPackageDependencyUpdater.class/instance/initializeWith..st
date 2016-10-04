initialization
initializeWith: aListOfPackageManifest 
	manifests := aListOfPackageManifest.
	visited := SharedQueue new.