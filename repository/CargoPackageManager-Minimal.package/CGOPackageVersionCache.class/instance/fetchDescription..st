fetching
fetchDescription: aPackageVersionString
	| fileRef |
	fileRef := self packageDescriptionCache / aPackageVersionString asLowercase.
	^ fileRef exists
		ifTrue: [ self decode: fileRef ]
		ifFalse: [ nil ]