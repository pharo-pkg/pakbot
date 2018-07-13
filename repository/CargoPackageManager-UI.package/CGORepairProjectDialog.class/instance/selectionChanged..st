selection
selectionChanged: aFTSelectionChanged 
	
	detailPanel widget contentsWrapped: (self selectedAction ifNil: [ '' ] ifNotNil: #description).
	
	self window ifNil: [ ^ self ].
	
	self selectedAction 
		ifNil: [ self window toolbar okButton disable ]
		ifNotNil: [ self window toolbar okButton enable ]