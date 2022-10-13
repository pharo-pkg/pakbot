Extension { #name : #IceAbstractProject }

{ #category : #'*Pakbot-Minimal' }
IceAbstractProject >> isPakbotProject [
	^ false
]

{ #category : #'*Pakbot-Minimal' }
IceAbstractProject >> pakbotProject [
	PBProjectMetadataNotFound signal: 'Iceberg project reader does not understand pakbot project metadata'
]
