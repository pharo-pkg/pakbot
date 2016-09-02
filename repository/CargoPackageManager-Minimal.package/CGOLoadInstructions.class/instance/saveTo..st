serialization
saveTo: aFileReference
	aFileReference writeStreamDo: [:stream | stream nextPutAll: self stonString ]