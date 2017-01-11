updating
addDependencyOn: aPackageName 
	dependencies	add:
		(CGOPackageDependency newFrom: aPackageName -> #())