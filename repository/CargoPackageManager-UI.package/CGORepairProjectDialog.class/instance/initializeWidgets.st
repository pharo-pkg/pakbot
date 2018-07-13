initialization
initializeWidgets
	
	reasonPanel := self newReadOnlyText.
	optionsList := self newFastTable.
	detailPanel := self newReadOnlyText.

	reasonPanel widget contentsWrapped: project problemLongDescription.

	optionsList widget 
		dataSource: self newActionsDataSource;
		onAnnouncement: FTSelectionChanged send: #selectionChanged: to: self;
		selectRowIndex: 1. 

