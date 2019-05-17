Extension { #name : #IceAbstractProject }

{ #category : #'*CargoPackageManager' }
IceAbstractProject >> isPakbotProject [
	^ false
]

{ #category : #'*CargoPackageManager' }
IceAbstractProject >> pakbotProject [
	PBProjectMetadataNotFound signal: 'Iceberg project reader does not understand pakbot project metadata'
]
