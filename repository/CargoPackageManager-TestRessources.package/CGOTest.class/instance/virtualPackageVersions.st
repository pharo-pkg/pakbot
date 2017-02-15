accessing
virtualPackageVersions
	^ self virtualPackageNames
		collect: [:name | CGOVirtualPackageVersion fromString: name,'@1.0']
		