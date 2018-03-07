converting
icebergUrl
	^ self isGitOverSshScheme
		ifTrue: [ String streamContents: [ :stream | | path |
				url printAuthorityOn: stream.
				path := String streamContents: [ :pathStream | url printPathQueryFragmentOn: pathStream  ].
				stream << $: << path allButFirst. "ZnUrl adds a $/ as first path segment. Not a valid url for iceberg" ] ]
		ifFalse: [ url asString ]