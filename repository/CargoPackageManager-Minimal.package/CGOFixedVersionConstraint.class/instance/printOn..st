printing
printOn: aStream
	aStream nextPut: $=.
	aStream nextPutAll: version printString 