tests-decoding
testDecodeNonStonData
	| fileRef |
	
	fileRef := FileLocator temp asFileReference / 'test.ston'.
	fileRef ensureDelete.
	fileRef writeStreamDo: [ :stream | stream nextPutAll: 'foo bar.' ].
	self
		assert: (CGOPackageVersionCache new decode: fileRef)
		equals: nil.
	fileRef delete.