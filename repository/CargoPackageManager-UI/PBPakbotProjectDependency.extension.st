Extension { #name : #PBPakbotProjectDependency }

{ #category : #'*CargoPackageManager-UI' }
PBPakbotProjectDependency >> newEditPanel [
	^ PBPakbotDependencyPanel on: self
]
