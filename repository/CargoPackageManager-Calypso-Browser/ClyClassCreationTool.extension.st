Extension { #name : #ClyClassCreationTool }

{ #category : #'*CargoPackageManager-Calypso-Browser' }
ClyClassCreationTool class >> fullBrowserProjectPackageActivation [
	<classAnnotation>
	
	^ClyTabActivationStrategy for: PBPackageContextOfFullBrowser
]
