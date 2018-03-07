converting
urlWithScheme: anUrlStringOrUrl 
	^ (anUrlStringOrUrl asString beginsWith: 'git@')
		ifTrue: [ ('git+ssh://' , (self normalizeUrl: anUrlStringOrUrl asString)) asZnUrl ]
		ifFalse: [ anUrlStringOrUrl asZnUrl ]