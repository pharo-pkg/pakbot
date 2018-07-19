Extension { #name : #ClyProjectContextOfFullBrowser }

{ #category : #'*CargoPackageManager-Calypso-Browser' }
ClyProjectContextOfFullBrowser >> lastSelectedPBPackage [
		
	^ self lastSelectedObjectIn:(self actualSelectionFrom: tool selectedPBPackages items)
]
