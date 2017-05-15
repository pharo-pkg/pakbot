private
refreshCalypsoChild
	toolContext lastSelectedItem childrenDataSource 
		ifNotNil: [:ds | ds environmentCursor observedContent changedBy: nil]