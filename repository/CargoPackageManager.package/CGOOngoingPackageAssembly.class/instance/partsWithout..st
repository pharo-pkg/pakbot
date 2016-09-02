private
partsWithout: aPackageDependency
	^ self parts 
		reject: [ :dependency | dependency packageName = aPackageDependency packageName ]