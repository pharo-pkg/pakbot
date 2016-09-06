accessing
selectedDependency
	^ dependencyTree selectedItem ifNotNil: [ :node | node content ]