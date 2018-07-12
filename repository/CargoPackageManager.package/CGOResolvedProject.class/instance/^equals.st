comparing
= anotherProject

	self species = anotherProject species
		ifFalse: [ ^ false ].
		
	^ self resolution = anotherProject resolution