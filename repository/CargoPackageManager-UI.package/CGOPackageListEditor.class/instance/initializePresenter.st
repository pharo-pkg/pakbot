initialization
initializePresenter
	super initializePresenter.
	packageTree widget onAnnouncement: FTSelectionChanged send: #selectionChanged: to: self.
	addButton action: [ self addAction ].
	removeButton
		action: [ self removeAction: self selectedPackage.
			self refreshUI ].
	editButton action: [ self editAction ]