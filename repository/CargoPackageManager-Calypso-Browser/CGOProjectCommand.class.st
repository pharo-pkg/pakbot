"
Abstract class for all the commands that works on projects.
"
Class {
	#name : #CGOProjectCommand,
	#superclass : #CGOClyCommand,
	#instVars : [
		'project'
	],
	#category : 'CargoPackageManager-Calypso-Browser-CargoPackageManager-Calypso-Browser'
}

{ #category : #execution }
CGOProjectCommand >> prepareFullExecutionInContext: aToolContext [

	super prepareFullExecutionInContext: aToolContext.
	project := aToolContext lastSelectedProject project.

]

{ #category : #accessing }
CGOProjectCommand >> project [
	^ project
]

{ #category : #accessing }
CGOProjectCommand >> project: anObject [
	project := anObject
]
