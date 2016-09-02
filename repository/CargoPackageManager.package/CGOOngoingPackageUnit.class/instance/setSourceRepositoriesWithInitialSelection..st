updating - ui
setSourceRepositoriesWithInitialSelection: aRepositorySet
	| ui |
	ui := RemotesManager new
		title: 'Package source repositories candidates';
		selectedRemotes: aRepositorySet;
		initializeWidgets;
		selectedChangedBlock: 
			[ :selectedRemote :selected | | repositories |
			repositories := self repositories asSet.
			selected 
				ifTrue: [ repositories add: selectedRemote location. ]
				ifFalse: [ repositories remove: selectedRemote location. ].
			self updateRepositories: repositories asArray ].
	ui openDialogWithSpec modalRelativeTo: self currentWorld
		
