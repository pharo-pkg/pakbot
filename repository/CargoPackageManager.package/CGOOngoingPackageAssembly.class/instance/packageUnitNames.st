accessing
packageUnitNames
	| foundPackage |
	^ parts
		select: [ :each | 
			foundPackage := registry packageNamed: each targetedPackage ifAbsent: [ nil ].
			foundPackage notNil and: [ foundPackage isUnit ] ]
		thenCollect: #targetedPackage