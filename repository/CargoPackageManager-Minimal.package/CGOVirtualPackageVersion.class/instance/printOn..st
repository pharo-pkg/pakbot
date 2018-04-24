printing
printOn: aStream
	aStream << self packageName << '@' << (self version asString) << ' (virtual)'