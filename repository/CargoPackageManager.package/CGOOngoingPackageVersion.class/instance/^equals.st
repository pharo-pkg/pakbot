comparing
= other
	^ self class == other class 
		ifTrue: [ manifest == other manifest ]
		ifFalse: [ ^ false ]	