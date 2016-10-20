parsing
parseMapDo: block
	self expectChar: ${.
	(self matchChar: $})
		ifTrue: [ ^ self ].
	[ readStream atEnd ] whileFalse: [ | association |
		association := self parseValue.
		(allowComplexMapKeys or: [ association name isString or: [ association name isNumber ] ])
			ifFalse: [ self error: 'unexpected property name type' ].
		block value: association name value: association value.
		(self matchChar: $}) 
			ifTrue: [ ^ self ].
		self expectChar: $, ].
	self error: 'end of map expected'