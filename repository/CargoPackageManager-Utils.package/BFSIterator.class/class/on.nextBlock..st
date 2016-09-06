instance creation
on: anObject nextBlock: aBlock
	^ self new
		root: anObject;
		nextBlock: aBlock;
		yourself.