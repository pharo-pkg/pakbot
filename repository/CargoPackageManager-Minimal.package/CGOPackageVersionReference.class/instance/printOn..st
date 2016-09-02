printing
printOn: aStream
	aStream << packageName.
	versionNumber ifNotEmpty: [ aStream << $@ << versionNumber ]