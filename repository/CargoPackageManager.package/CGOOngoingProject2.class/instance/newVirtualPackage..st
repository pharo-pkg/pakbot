updating
newVirtualPackage: aName
	| virtual |
	
	virtual := CGOOngoingVirtualPackage for: aName asSymbol project: self.
	virtualPackages add: virtual.
	^ registry register: virtual