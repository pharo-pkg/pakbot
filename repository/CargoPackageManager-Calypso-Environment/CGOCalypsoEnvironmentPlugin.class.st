"
I dispatch project content retrieval to dedicated providers.
"
Class {
	#name : #CGOCalypsoEnvironmentPlugin,
	#superclass : #ClySystemEnvironmentPlugin,
	#category : 'CargoPackageManager-Calypso-Environment'
}

{ #category : #accessing }
CGOCalypsoEnvironmentPlugin >> collectClassGroupProviders [

	^{CGOClyDependencyGroupProvider new}
]

{ #category : #'item decoration' }
CGOCalypsoEnvironmentPlugin >> decorateBrowserItem: anItem ofProject: aProject [

	aProject project hasProblems
		ifTrue: [ anItem markWith: CGOProjectHasProblems ]
]
