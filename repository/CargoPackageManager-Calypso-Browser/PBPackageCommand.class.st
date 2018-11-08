"
Abstract class for all the commands that works on packages.
"
Class {
	#name : #PBPackageCommand,
	#superclass : #PBProjectCommand,
	#instVars : [
		'packageItem'
	],
	#category : #'CargoPackageManager-Calypso-Browser-Commands'
}

{ #category : #accessing }
PBPackageCommand class >> canBeExecutedInContext: aToolContext [
	^ aToolContext hasSelectedItems
]

{ #category : #accessing }
PBPackageCommand >> packageItem [

	^ packageItem
]

{ #category : #execution }
PBPackageCommand >> prepareFullExecutionInContext: aToolContext [

	super prepareFullExecutionInContext: aToolContext.
	packageItem := aToolContext lastSelectedObject.

]
