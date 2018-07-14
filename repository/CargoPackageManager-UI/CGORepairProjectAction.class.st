"
I represent all the repair actions that can be executed on a project with problems.
I have a class message #allAvailableFor: that returns all the applicable repair actions for the status of a given project.
"
Class {
	#name : #CGORepairProjectAction,
	#superclass : #Object,
	#instVars : [
		'project'
	],
	#category : 'CargoPackageManager-UI-Repair'
}

{ #category : #accessing }
CGORepairProjectAction class >> allAvailableFor: aProject [

	^ self allSubclasses 
		select: [ :aClass | aClass isAvailableFor: aProject ] 
		thenCollect: [ :aClass | aClass forProject: aProject ]
]

{ #category : #accessing }
CGORepairProjectAction class >> forProject: aProject [

	^ self new
		project: aProject;
		yourself
]

{ #category : #testing }
CGORepairProjectAction class >> isAbstract [
	
	^ self = CGORepairProjectAction
]

{ #category : #accessing }
CGORepairProjectAction class >> isAvailableFor: aProject [

	^ self subclassResponsibility
]

{ #category : #accessing }
CGORepairProjectAction >> description [
	^ self subclassResponsibility
]

{ #category : #execution }
CGORepairProjectAction >> execute [
	^ self subclassResponsibility 
]

{ #category : #accessing }
CGORepairProjectAction >> iconName [
	^ self subclassResponsibility
]

{ #category : #testing }
CGORepairProjectAction >> isLoadProjectAction [
	
	^ false
]

{ #category : #accessing }
CGORepairProjectAction >> name [
	^ self subclassResponsibility 
]

{ #category : #accessing }
CGORepairProjectAction >> project: aProject [ 

	project := aProject
]
