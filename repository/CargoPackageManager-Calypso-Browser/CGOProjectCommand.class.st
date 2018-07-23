"
Abstract class for all the commands that works on projects.
"
Class {
	#name : #CGOProjectCommand,
	#superclass : #CGOClyCommand,
	#instVars : [
		'project'
	],
	#category : #'CargoPackageManager-Calypso-Browser-Commands'
}

{ #category : #testing }
CGOProjectCommand class >> canBeExecutedInContext: aToolContext [

	^ aToolContext isProjectSelected 
]

{ #category : #execution }
CGOProjectCommand >> prepareFullExecutionInContext: aToolContext [

	super prepareFullExecutionInContext: aToolContext.
	project := aToolContext lastSelectedProject.

]

{ #category : #accessing }
CGOProjectCommand >> project [
	^ project
]

{ #category : #accessing }
CGOProjectCommand >> project: anObject [
	project := anObject
]
