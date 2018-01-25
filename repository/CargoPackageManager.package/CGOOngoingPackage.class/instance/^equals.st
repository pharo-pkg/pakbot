comparing
= other
	^ self class == other class 
		ifTrue: [ package == other package and: [ project = other project ] ]
		ifFalse: [ ^ false ]	