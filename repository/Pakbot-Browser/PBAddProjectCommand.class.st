"
A command to create a new (empty) Pakbot project
"
Class {
	#name : #PBAddProjectCommand,
	#superclass : #CmCommand,
	#category : #'Pakbot-Browser-Commands'
}

{ #category : #'instance creation' }
PBAddProjectCommand class >> open [
	<script>
	self new execute.
]

{ #category : #converting }
PBAddProjectCommand >> asSpecCommand [
	^ super asSpecCommand
		iconName: #smallAdd;
		name: 'Add project';
		yourself
]

{ #category : #executing }
PBAddProjectCommand >> execute [
	
	(PBAddProjectPresenter newApplication: self context application)
		openDialog.
]
