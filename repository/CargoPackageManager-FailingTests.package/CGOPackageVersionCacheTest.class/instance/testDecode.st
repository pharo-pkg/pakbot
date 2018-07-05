tests-decoding
testDecode
	| fileRef |
	
	fileRef := FileLocator temp asFileReference / 'test.ston'.
	fileRef ensureDelete.
	fileRef writeStreamDo: [ :stream | stream nextPutAll: '[ 1, ''toto'']' ].
	self
		assert: (CGOPackageVersionCache new decode: fileRef)
		equals: #(1 'toto').
	fileRef delete.