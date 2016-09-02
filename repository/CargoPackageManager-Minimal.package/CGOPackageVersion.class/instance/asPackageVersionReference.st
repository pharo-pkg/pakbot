converting
asPackageVersionReference
	^ CGOPackageVersionReference new
		initializeWithName: self packageName version: self version asString;
		yourself