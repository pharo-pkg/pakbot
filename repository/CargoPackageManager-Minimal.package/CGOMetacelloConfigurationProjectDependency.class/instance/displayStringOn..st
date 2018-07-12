ston
displayStringOn: aStream
	
	aStream
		nextPutAll: 'Proj(';
		nextPutAll: url asString;
		nextPutAll: ', ';
		nextPutAll: version asString;
		nextPutAll: ')'