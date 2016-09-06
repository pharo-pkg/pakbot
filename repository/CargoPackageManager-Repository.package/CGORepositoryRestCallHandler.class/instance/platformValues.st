accessing
platformValues
	| value |
	value := self queryAt: #platform ifAbsent: [ #() ].
	value ifEmpty: [ ^ #() ].
	^ value isArray
		ifTrue: [ value collect: #asSymbol as: Array ]
		ifFalse: [ ($, split: value) collect: #asSymbol as: Array ]