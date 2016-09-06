initialization
initializePresenter
	super initializePresenter.

	dependencyTree whenSelectedNodesChanged: [:selection |
		removeButton enabled: selection notEmpty.
		editButton enabled: selection notEmpty ].
	
	addButton action: 
		[ ongoingPackageVersion addNewDependency: self.
		self refreshUI ].
	removeButton action: 
		[ ongoingPackageVersion removeDependency: self selectedDependency.
		self refreshUI ].
	editButton action: 
		[ self editConstraints ].