printing
printOn: aStream
	aStream << self packageName << ' ('.
	constraints printOn: aStream delimiter: Character space.
	aStream << ')'.