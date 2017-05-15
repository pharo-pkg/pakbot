private
refreshCalypsoChild
	toolContext lastSelectedItem parentItem childrenDataSource 
		ifNotNil: [:ds | ds environmentCursor observedContent changedBy: nil]