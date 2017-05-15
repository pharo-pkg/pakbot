updating
addPart: aPackageName 
	parts add: (CGOPackageDependency newFrom: aPackageName -> #())