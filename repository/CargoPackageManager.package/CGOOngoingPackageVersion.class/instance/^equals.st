comparing
= other
	^ self class == other class 
		ifTrue: [ package == other package and: [ projectName = other projectName ] ]
		ifFalse: [ ^ false ]	