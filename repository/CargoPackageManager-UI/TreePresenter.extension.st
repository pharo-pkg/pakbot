Extension { #name : #TreePresenter }

{ #category : #'*CargoPackageManager-UI' }
TreePresenter >> whenSelectedNodesChanged: aBlock [
	"Set a block to perform when a new node is selected"

	selectionHolder whenChangedDo: [ :col | aBlock cull: col ]
]
