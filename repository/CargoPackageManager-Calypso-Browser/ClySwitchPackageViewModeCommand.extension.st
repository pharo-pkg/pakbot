Extension { #name : #ClySwitchPackageViewModeCommand }

{ #category : #'*CargoPackageManager-Calypso-Browser' }
ClySwitchPackageViewModeCommand class >> fullBrowserToolbarActivation4 [
	<classAnnotation>
	
	^ClyToolbarActivation 
		byItemOf: ClyPackageToolbarGroup 
		order: self toolbarOrder
		for: PBProjectContextOfFullBrowser 
]
