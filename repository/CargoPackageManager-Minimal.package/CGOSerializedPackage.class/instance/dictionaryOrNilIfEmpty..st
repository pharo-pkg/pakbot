utility
dictionaryOrNilIfEmpty: aDictionary
	aDictionary ifNil: [ ^ nil ].
	^ aDictionary ifEmpty: [ nil ]