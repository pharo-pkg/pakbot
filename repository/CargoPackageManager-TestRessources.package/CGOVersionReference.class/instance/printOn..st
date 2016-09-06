printing
printOn: aStream
	aStream 
		nextPutAll: packageName;
		nextPut: $-.
	branch = ''
		ifFalse: [
			aStream
				nextPutAll: branch;
				nextPut: $- ].
	aStream
		nextPutAll: author;
		nextPut: $.;
		print: versionNumber