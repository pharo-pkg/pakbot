converting
urlWithScheme: anUrlStringOrUrl 
	^ (anUrlStringOrUrl asString beginsWith: 'git@')
		ifTrue: [ ('git://' , (self normalizeUrl: anUrlStringOrUrl asString)) asZnUrl ]
		ifFalse: [ anUrlStringOrUrl asZnUrl ]