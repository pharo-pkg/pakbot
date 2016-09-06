accessing
allCurrentDependenciesOfManifest: aManifest
	"List dependencies and transitive dependencies of the given manifest by using the information  present in the manifest #dependencies method (could be outdated)."
	^ (self manifestsForAllCurrentDependenciesOfManifest: aManifest)
			collect: #packageName