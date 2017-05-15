accessing
packageUnitNames
	| foundPackage |
	^ parts
		select: [ :each | 
			foundPackage := registry packageNamed: each packageName ifAbsent: [ nil ].
			foundPackage notNil and: [ foundPackage isUnit ] ]