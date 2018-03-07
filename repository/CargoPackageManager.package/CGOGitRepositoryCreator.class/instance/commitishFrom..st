querying
commitishFrom: anUrl
	^ (anUrl lastPathSegment includes: $:)
		ifTrue: [ anUrl asString copyAfterLast: $: ]
		ifFalse: [ nil ]