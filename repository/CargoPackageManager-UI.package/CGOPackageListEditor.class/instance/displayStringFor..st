private - displaying
displayStringFor: aDependency
	^ String streamContents: [ :stream |
		stream nextPutAll:	aDependency displayString ]