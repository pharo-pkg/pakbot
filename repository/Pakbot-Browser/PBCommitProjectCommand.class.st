"
A command to commit the whole project + its metadata through Iceberg UI
"
Class {
	#name : #PBCommitProjectCommand,
	#superclass : #PBProjectCommand,
	#instVars : [
		'usePakbot'
	],
	#category : #'Pakbot-Browser-Commands'
}

{ #category : #private }
PBCommitProjectCommand >> alertNotInABranch [
	UIManager default 
		alert: ('The commit project command failed because you are not in a branch!' , String cr, 
		'Open a repository window and click on repair action to create a new branch or checkout an existing branch.', String cr ,
		'Once done, you will be able to commit the project.' )
		title: 'Commit project failed'
]

{ #category : #converting }
PBCommitProjectCommand >> asSpecCommand [
	^ super asSpecCommand
		iconName: #smallOk;
		name: 'Commit project';
		shortcutKey: $s meta;
		beDisabledWhenCantBeRun;
		yourself
]

{ #category : #executing }
PBCommitProjectCommand >> askUseMetadata [

	| answer |
	answer := UIManager default
		  question:
		  'This project does not use Pakbot metadata yet. Use pakbot metadata?'
		  title: 'Use pakbot metadata?'.
	
	"NonInteractiveUIManager does not answer a boolean. Ensure we get a valid answer"
	^ (answer isKindOf: Boolean)
		ifTrue: [ answer ] 
		ifFalse: [ false "default behaviour" ].
		
]

{ #category : #executing }
PBCommitProjectCommand >> execute [
	self canBeExecuted ifFalse: [ ^ self ].

	self project ifNotMarried: [ 
		usePakbot ifNil: [ 
			usePakbot := self askUseMetadata ifNil: [ ^ nil "cancel command" ] ].
		usePakbot ifTrue: [ 
			self project marryWith: self project repository.
			usePakbot := nil ] ].

	[ 
	^ (IceTipCommitBrowser onRepository: self project repository iceRepository)
		  open;
		  yourself ]
		on: IceNotInBranch
		do: [ self alertNotInABranch ]
]

{ #category : #configuring }
PBCommitProjectCommand >> usePakbot: aBoolean [ 
	usePakbot := aBoolean
]
