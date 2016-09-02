parsing
parseValue
	| value |
	value := super parseValue.
	^ self nextValueIsAssociationSeparator
		ifTrue: [ (self isValidPropertyNameType: value)
					ifFalse: [ self error: 'unexpected property name type' ].
				self consumeColon.
				Association key: value value: super parseValue ]
		ifFalse: [ value ]