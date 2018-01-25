utility
toArrayOrNilIfEmpty: aCollection
	aCollection ifNil: [ ^ nil ].
	^ aCollection
		ifEmpty: [ nil ]
		ifNotEmpty: [aCollection asArray ]