actions
ensureCloned
	| location |
	location := self iceRepository location.
	(location exists not or: [ location hasChildren not ])
		ifTrue: 
			[ self iceRepository backend 
				cloneRepositoryFrom: (IceRemote url: self repositoryUrl)
				branch: (version ifNil: [ 'master' ]) ].