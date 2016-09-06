computing
dependenciesOf: manifest
	^ ((Set withAll: (self staticDependenciesOf: manifest)) , manifest manuallyResolvedDependencies)
			reject: [ :each | manifest ignoredDependencies includes: each ]