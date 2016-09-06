protocol
next
	| currentElement |
	
	currentElement := queue nextOrNil.
	currentElement ifNotNil: [
		((self hasChildNodes: currentElement) and: [ self isNotVisited: currentElement ])
			ifTrue: [ queue nextPutAll: (nextBlock value: currentElement).
					 alreadyVisited add: currentElement ] ].
	^ currentElement