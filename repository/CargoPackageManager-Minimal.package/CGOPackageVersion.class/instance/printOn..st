printing
printOn: aStream
	aStream << self packageName << '@' << (version asString)