saving
saveDescription: aPackageVersion
	| fileRef |
	aPackageVersion ifNil: [ ^ self ].
	fileRef := self packageDescriptionCache / aPackageVersion asString asLowercase.
	fileRef writeStreamDo: [ :stream | stream nextPutAll: (CGOPackageVersionWriter toStringPretty: aPackageVersion) ]
	"Maybe we can have better performances by getting directly the STON string before the conversion in objects"