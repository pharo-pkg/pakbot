Extension { #name : #ClyFullBrowser }

{ #category : #'*CargoPackageManager-Calypso-Browser' }
ClyFullBrowser >> selectedPBPackages [
	^ packageView selection asSelectedParentsOf: PBPackageUIItem
]
