Extension { #name : #PBConflict }

{ #category : #'*CargoPackageManager-UI' }
PBConflict >> resolutionDetailText [

	selectedResolution ifNil: [ ^ 'Please select a version to use' ].
	selectedResolution isInstalled ifTrue: [ ^ 'The selected version is already installed.' ].
	
	^ 'The selected version will be installed'
]
