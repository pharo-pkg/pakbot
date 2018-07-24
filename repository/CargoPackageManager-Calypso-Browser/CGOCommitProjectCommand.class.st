"
Calypso command providing a contextual menu on Cargo project to allow a commit of the whole project.
"
Class {
	#name : #CGOCommitProjectCommand,
	#superclass : #CGOProjectCommand,
	#instVars : [
		'commitMessage'
	],
	#category : #'CargoPackageManager-Calypso-Browser-Commands'
}

{ #category : #accessing }
CGOCommitProjectCommand class >> defaultMenuIconName [
	^#monticelloPackage
	
]

{ #category : #activation }
CGOCommitProjectCommand class >> systemBrowserMenuActivator [
	<classAnnotation>
	
	^ CmdContextMenuActivation
		byItemOf: CGOSCMMenuGroup
		order: 10000
		for: PBProjectUIItem asCalypsoItemContext 
]

{ #category : #activation }
CGOCommitProjectCommand class >> systemBrowserShortcutActivator [
	<classAnnotation>
	
	^ CmdShortcutActivation by: $s meta for: PBProjectUIItem asCalypsoItemContext 
]

{ #category : #activation }
CGOCommitProjectCommand class >> systemBrowserToolbarActivator [
	<classAnnotation>
	
	^ ClyToolbarActivation
		byItemOf: ClyButtonToolbarGroup
		order: 1010
		for: PBProjectUIItem asCalypsoItemContext , ClyEmptyClassSelectionContext new
]

{ #category : #accessing }
CGOCommitProjectCommand >> commitMessage [
	^ commitMessage
]

{ #category : #accessing }
CGOCommitProjectCommand >> commitMessage: anObject [
	commitMessage := anObject
]

{ #category : #initialization }
CGOCommitProjectCommand >> defaultMenuItemName [
	^ 'Commit...'
]

{ #category : #execution }
CGOCommitProjectCommand >> execute [
	
	(IceTipCommitBrowser onRepository: project project repository iceRepository) openWithSpec
]
