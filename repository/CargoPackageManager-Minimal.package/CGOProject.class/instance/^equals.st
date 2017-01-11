comparing
= other
	^ self class == other class 
		ifTrue: [ name == other name ]
		ifFalse: [ ^ false ]	