Extension { #name : #NonInteractiveUIManager }

{ #category : #'*CargoPackageManager-UI-Tests' }
NonInteractiveUIManager >> newMenuIn: aThemedMorph for: aModel [
	"Answer a new menu."

	^ Smalltalk ui theme
		newMenuIn: aThemedMorph for: aModel
]
