Extension { #name : #IceErrorVisitor }

{ #category : #'*CargoPackageManager-UI-Tests' }
IceErrorVisitor >> visitCloneLocationAlreadyExists: anError [ 
	self flag: 'TODO'. "remove when https://github.com/pharo-vcs/iceberg/pull/1381/files is integrated into the core image"
	self visitGenericError: anError
]
