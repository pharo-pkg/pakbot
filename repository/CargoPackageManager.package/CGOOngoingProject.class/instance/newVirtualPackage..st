updating
newVirtualPackage: aName
	| virtual |
	
	virtual := CGOOngoingVirtualPackageVersion for: aName asSymbol in: name.
	virtualPackages add: virtual.
	^ registry register: virtual