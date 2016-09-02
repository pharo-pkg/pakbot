deserialization
deserializeRepositories
	repositories ifNil: [ ^ OrderedCollection new: 0 ].
	^ repositories
		collect: [ :repositoryLocation | MCRepository fromUrl: repositoryLocation ]
		as: OrderedCollection