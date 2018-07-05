private
refreshCalypsoRoot

	toolContext tool packageView dataSource isDirty
		ifTrue: [ toolContext tool packageView dataSource runUpdate ]