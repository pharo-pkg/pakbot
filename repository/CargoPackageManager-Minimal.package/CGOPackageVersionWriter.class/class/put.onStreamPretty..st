convenience
put: anObject onStreamPretty: aWriteStream
	(self new on: aWriteStream)
		prettyPrint: true; 
		nextPut: anObject