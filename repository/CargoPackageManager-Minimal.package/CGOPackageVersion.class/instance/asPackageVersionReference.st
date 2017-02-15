converting
asPackageVersionReference
	^ CGOPackageVersionReference 
		packageName: self packageName 
		version: self version asString