loading order
reducedGraph
	resolution ifNil: [ ^ self ].
	^ MalGraphReducer new
		addNodesFrom: resolution root
		childrenBlock: [ :resolvedDependency | resolution dependenciesOf: resolvedDependency ];
		run