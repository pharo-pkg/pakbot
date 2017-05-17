private
refreshCalypsoChild
	toolContext lastSelectedItem childrenDataSource
		ifNil: [ self refreshCalypsoRoot ]
		ifNotNil: [:ds | ds environmentCursor observedContent changedBy: nil]