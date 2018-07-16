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
		for: PBProjectBrowserItem asCalypsoItemContext 
]

{ #category : #activation }
CGOCommitProjectCommand class >> systemBrowserShortcutActivator [
	<classAnnotation>
	
	^ CmdShortcutActivation by: $s meta for: PBProjectBrowserItem asCalypsoItemContext 
]

{ #category : #activation }
CGOCommitProjectCommand class >> systemBrowserToolbarActivator [
	<classAnnotation>
	
	^ ClyToolbarActivation
		byItemOf: ClyButtonToolbarGroup
		order: 1010
		for: PBProjectBrowserItem asCalypsoItemContext , ClyEmptyClassSelectionContext new
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
	project saveToSCM: commitMessage
]

{ #category : #initialization }
CGOCommitProjectCommand >> prepareFullExecutionInContext: aToolContext [
	super prepareFullExecutionInContext: aToolContext.
	
	commitMessage := UIManager default 
		multiLineRequest: 'Commit message' 
		initialAnswer: '' 
		answerHeight: 200.
	commitMessage isEmptyOrNil ifTrue: [ CmdCommandAborted signal]
]
