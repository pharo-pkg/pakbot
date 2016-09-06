accessing
allCurrentDependenciesOf: aPackageName
	"List dependencies and transitive dependencies of the given package name"
	^ self allCurrentDependenciesOfManifest: aPackageName packageManifest