initialization - private
dependenciesFrom: aDictionary
	^ aDictionary 
		at: #dependencies
		ifPresent: [ :aDependencyList | aDependencyList collect: #asPackageDependency ]
		ifAbsent: #()