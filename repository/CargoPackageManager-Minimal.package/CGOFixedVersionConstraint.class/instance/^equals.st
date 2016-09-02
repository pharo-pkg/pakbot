comparing
= other
	(self class = other class) ifFalse: [ ^false ].
	(self version = other version) ifFalse: [ ^false ].
	^true.