initialization
selectionChanged: ann
	
	removeButton enabled: ann newSelectedRowIndexes notEmpty.
	editButton enabled: ann newSelectedRowIndexes notEmpty.
