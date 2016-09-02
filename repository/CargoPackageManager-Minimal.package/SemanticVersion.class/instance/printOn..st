printing
printOn: aStream
	aStream << major.
	minor ifNil: [ ^self ].
	aStream << $. << minor.
	patch ifNil: [ ^self ].
	aStream << $. << patch.
	suffix ifNotNil: [ aStream << suffix ]