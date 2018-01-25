converting
asPackageVersionReference
	" version 0.0.0 means that the package has no version and comes from a VCS."
	^ CGOPackageVersionReference 
		packageName: self packageName 
		version: self version