"
Calypso command providing a contextual menu on Cargo project to allow a commit of the whole project.
"
Class {
	#name : #PBCommitProjectCommand,
	#superclass : #PBProjectCommand,
	#category : #'CargoPackageManager-Calypso-Browser-Commands'
}

{ #category : #accessing }
PBCommitProjectCommand class >> canBeExecutedInContext: aToolContext [

	^ (aToolContext isProjectSelected and: [ aToolContext selectedProjectItems size = 1 ])
		and: [ aToolContext selectedProjectItems first actualObject project hasRepository ]
]

{ #category : #accessing }
PBCommitProjectCommand class >> defaultMenuIconName [
	^#monticelloPackage
	
]

{ #category : #activation }
PBCommitProjectCommand class >> systemBrowserMenuActivator [
	<classAnnotation>
	
	^ CmdContextMenuActivation
		byItemOf: PBSCMMenuGroup
		order: 10000
		for: PBProjectUIItem asCalypsoItemContext 
]

{ #category : #activation }
PBCommitProjectCommand class >> systemBrowserShortcutActivator [
	<classAnnotation>
	
	^ CmdShortcutActivation by: $s meta for: PBProjectUIItem asCalypsoItemContext 
]

{ #category : #activation }
PBCommitProjectCommand class >> systemBrowserToolbarActivator [
	<classAnnotation>
	
	^ ClyToolbarActivation
		byItemOf: ClyButtonToolbarGroup
		order: 1010
		for: PBProjectUIItem asCalypsoItemContext , ClyEmptyClassSelectionContext new
]

{ #category : #initialization }
PBCommitProjectCommand >> defaultMenuItemName [
	^ 'Commit...'
]

{ #category : #execution }
PBCommitProjectCommand >> execute [
	[ ^ (IceTipCommitBrowser onRepository: project repository iceRepository)
			openWithSpec;
			yourself ]
	on: IceNotInBranch 
	do: [ UIManager default 
		alert: ('The commit project command failed because you are not in a branch!' , String cr, 
		'Open a repository window and click on repair action to create a new branch or checkout an existing branch.', String cr ,
		'Once done, you will be able to commit the project.' )
		title: 'Commit project failed'	 ]
]
