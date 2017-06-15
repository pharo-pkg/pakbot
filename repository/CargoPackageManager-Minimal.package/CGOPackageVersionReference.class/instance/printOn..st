printing
printOn: aStream
	aStream << packageName.
	version ifNotEmpty: [ aStream << $@ << version ]