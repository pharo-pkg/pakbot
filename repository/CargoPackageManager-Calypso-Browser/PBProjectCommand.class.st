"
Abstract class for all the commands that works on projects.
"
Class {
	#name : #PBProjectCommand,
	#superclass : #PBClyCommand,
	#instVars : [
		'project'
	],
	#category : #'CargoPackageManager-Calypso-Browser-Commands'
}

{ #category : #testing }
PBProjectCommand class >> canBeExecutedInContext: aToolContext [

	^ aToolContext isProjectSelected 
]

{ #category : #execution }
PBProjectCommand >> prepareFullExecutionInContext: aToolContext [

	super prepareFullExecutionInContext: aToolContext.
	project := aToolContext lastSelectedProject project.

]

{ #category : #accessing }
PBProjectCommand >> project [
	^ project
]

{ #category : #accessing }
PBProjectCommand >> project: anObject [
	project := anObject
]
