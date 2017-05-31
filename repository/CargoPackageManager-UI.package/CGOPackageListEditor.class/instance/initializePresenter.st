initialization
initializePresenter
	super initializePresenter.

	packageTree whenSelectedNodesChanged: [:selection |
		removeButton enabled: selection notEmpty.
		editButton enabled: selection notEmpty ].
	
	addButton action: 
		[ self addAction.
		self refreshUI ].
	removeButton action: 
		[ self removeAction: self selectedPackage.
		self refreshUI ].
	editButton action: 
		[ self editAction ].