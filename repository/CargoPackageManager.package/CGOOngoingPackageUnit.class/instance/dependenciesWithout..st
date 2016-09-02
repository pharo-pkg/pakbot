private
dependenciesWithout: aPackageDependency
	^ self dependencies 
		reject: [ :dependency | dependency packageName = aPackageDependency packageName ]