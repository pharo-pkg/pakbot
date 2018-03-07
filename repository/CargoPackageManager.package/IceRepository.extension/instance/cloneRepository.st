*CargoPackageManager
cloneRepository
	(self location exists not or: [ self location hasChildren not ])
		ifTrue: 
			[ backend 
				cloneRepositoryFrom: self origin 
				branch: self branchName ].