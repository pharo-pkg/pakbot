loading order
reducedGraph

	^ MalGraphReducer new
		addNodesFrom: resolution root
		childrenBlock: [ :resolvedDependency | resolution dependenciesOf: resolvedDependency ];
		run