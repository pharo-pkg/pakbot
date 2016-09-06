actions
newPackageVersion
	| choice |
	choice := UIManager default 
		chooseFrom: #('Package Assembly' 'Package Unit')
		values: { #newPackageAssembly . #newPackageUnit }.
	choice 
		ifNotNil: [ (choice value: self)
			ifNotNil: [ :newPackageVersion |
				self entity: (self entity 
					add: newPackageVersion;
					yourself ) ] ]