loading order
loadInstructions
	loadInstructions := CGOLoadInstructions new.
	self loadOrder do: 
		[ :resolvedDependencyOrCollection | 
		self addLoadGroupFor: resolvedDependencyOrCollection asOrderedCollection ].
	"loadInstructions packageRepositories: #()."
	^ loadInstructions