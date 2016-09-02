comparing
> other 
	(self major > other major) ifTrue: [ ^ true ].
	(self major < other major) ifTrue: [ ^ false ].
	(self minor > other minor) ifTrue: [ ^ true ].
	(self minor < other minor) ifTrue: [ ^ false ].
	(self patch > other patch) ifTrue: [ ^ true ].
	(self patch < other patch) ifTrue: [ ^ false ].
	^ self suffix 
		ifNil: [ ^ other suffix isNotNil ]
		ifNotNil: [ other suffix
					ifNil: [ false ]
					ifNotNil: [ self suffix > other suffix ]  ]