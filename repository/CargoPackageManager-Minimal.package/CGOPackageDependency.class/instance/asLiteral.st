converting
asLiteral
	^ constraints 
		ifEmpty: [ self packageName ]
		ifNotEmpty: [ self packageName -> (constraints collect: #asString as: Array) ]