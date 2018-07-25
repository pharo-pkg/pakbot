"
I am an abstract command class to have common behaviour of commands that work on assemblies.
In particular extract an assembly from the calypso context.
"
Class {
	#name : #PBAssemblyCommand,
	#superclass : #CGOClyCommand,
	#instVars : [
		'assembly'
	],
	#category : #'CargoPackageManager-Calypso-Browser-Commands'
}

{ #category : #testing }
PBAssemblyCommand class >> canBeExecutedInContext: aToolContext [
	^ aToolContext hasSelectedItems
]

{ #category : #execution }
PBAssemblyCommand >> prepareFullExecutionInContext: aToolContext [

	super prepareFullExecutionInContext: aToolContext.
	assembly := aToolContext lastSelectedProjectChild.
]
