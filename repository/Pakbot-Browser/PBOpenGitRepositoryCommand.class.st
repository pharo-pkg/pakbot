"
A command to open the project repository.
Useful to add remotes for example.
"
Class {
	#name : #PBOpenGitRepositoryCommand,
	#superclass : #PBProjectCommand,
	#category : #'Pakbot-Browser-Commands'
}

{ #category : #converting }
PBOpenGitRepositoryCommand >> asSpecCommand [
	^ super asSpecCommand
		iconName: #komitterSmalltalkhubRemote;
		name: 'Repository';
		yourself
]

{ #category : #executing }
PBOpenGitRepositoryCommand >> execute [

	self project ifNil: [ ^ self ].
	self project repository isValidRepository ifFalse: [ ^ self ].
	
	(IceTipRepositoryBrowser onRepository: self project repository iceRepository) open.
]
