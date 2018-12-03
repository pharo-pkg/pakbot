Extension { #name : #ClyClassCreationToolMorph }

{ #category : #'*CargoPackageManager-Calypso-Browser' }
ClyClassCreationToolMorph >> fullBrowserProjectPackageActivation [
	<classAnnotation>
	
	^ClyTabActivationStrategy for: PBPackageContextOfFullBrowser
]
