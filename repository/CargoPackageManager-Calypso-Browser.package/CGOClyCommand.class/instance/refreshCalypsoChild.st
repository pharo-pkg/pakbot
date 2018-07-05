private
refreshCalypsoChild
	toolContext lastSelectedItem childrenDataSource
		ifNil: [ 
			self refreshCalypsoRoot.
			toolContext lastSelectedItem expand ]
		ifNotNil: [:ds |
			self refreshCalypsoRoot ]