testing - installing
providesPackage: aPackageDependency 
	
	^ self packageName = aPackageDependency packageName and: [ aPackageDependency satisfyConstraints: self version ]