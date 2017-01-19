updating
removeDependency: aPackageDependency
	dependencies := dependencies 
		reject: [ :dependency | dependency packageName = aPackageDependency packageName ]