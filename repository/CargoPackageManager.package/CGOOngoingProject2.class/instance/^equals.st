comparing
= other
	^ self class == other class 
		ifTrue: [ package == other package ]
		ifFalse: [ ^ false ]	