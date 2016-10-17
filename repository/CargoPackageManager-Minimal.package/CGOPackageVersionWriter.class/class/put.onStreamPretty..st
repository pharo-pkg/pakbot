convenience
put: anObject onStreamPretty: aWriteStream
	(self new on: aWriteStream)
		nextPut: anObject