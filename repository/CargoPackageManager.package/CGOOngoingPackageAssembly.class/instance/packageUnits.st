accessing
packageUnits
	| units |
	units := OrderedCollection new.
	parts
		do: [ :each | | foundPackage |
			foundPackage := registry packageNamed: each packageName ifAbsent: [ nil ].
			(foundPackage notNil and: [ foundPackage isUnit ])
				ifTrue: [ units add: foundPackage ] ].
	^ units