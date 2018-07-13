loading order
reducedGraph

	^ MalGraphReducer new
		addNodesFrom: resolution
		childrenBlock: [ :resolvedDependency | resolvedDependency resolvedDependencies collect: [ :each | each resolution ] ];
		run