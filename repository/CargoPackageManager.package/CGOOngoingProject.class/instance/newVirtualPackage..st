updating
newVirtualPackage: aName
	| virtual |
	
	virtual := CGOOngoingVirtualPackage 
		for: aName asSymbol 
		project: self.
	(virtualPackages includes: virtual)
		ifTrue: [ CGOPackageAlreadyRegistered signal ].
	virtualPackages add: virtual.
	^ registry register: virtual