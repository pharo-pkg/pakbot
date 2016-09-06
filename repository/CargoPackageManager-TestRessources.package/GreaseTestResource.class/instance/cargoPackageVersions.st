data - cargo package versions
cargoPackageVersions
	^ self class methods 
		select: [ :each | each hasPragmaNamed: #cargoPackageVersion ]
		thenCollect: [ :method | self withArgs: #() executeMethod: method ]