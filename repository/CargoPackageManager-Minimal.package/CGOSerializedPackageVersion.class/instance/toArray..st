utility
toArray: aCollection
	^ aCollection 
		ifNil: [ #() ]
		ifNotNil: [ aCollection asArray ]