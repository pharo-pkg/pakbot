comparing
= other
	(self class = other class) ifFalse: [ ^false ].
	(self packageName = other packageName) ifFalse: [ ^false ].
	(self version = other version) ifFalse: [ ^false ].
	^true