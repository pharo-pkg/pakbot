selection
selectedAction

	| selectedIndex |
	selectedIndex := optionsList widget selectedRowIndex.
	selectedIndex = 0 ifTrue: [ ^ nil ].	
	^ optionsList widget dataSource elementAt: selectedIndex 
		