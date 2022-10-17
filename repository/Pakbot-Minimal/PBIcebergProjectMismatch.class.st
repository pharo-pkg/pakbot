"
Error raised when a PBIcebergProject is referencing a different pakbot project (`PBIcebergProject>>#pakbotProject`) than the project holding the git repository a PBIcebergProject refers to.

"
Class {
	#name : #PBIcebergProjectMismatch,
	#superclass : #PBError,
	#category : #'Pakbot-Minimal-Iceberg-Integration'
}

{ #category : #testing }
PBIcebergProjectMismatch >> isResumable [
	^ true
]
