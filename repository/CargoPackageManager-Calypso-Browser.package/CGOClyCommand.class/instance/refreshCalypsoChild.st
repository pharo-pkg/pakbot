private
refreshCalypsoChild
	toolContext lastSelectedItem childrenDataSource
		ifNil: [ self refreshCalypsoRoot.
					toolContext lastSelectedItem expand ]
		ifNotNil: [:ds | ds environmentCursor observedContent changedBy: nil]