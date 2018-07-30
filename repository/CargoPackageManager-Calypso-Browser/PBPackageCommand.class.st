Class {
	#name : #PBPackageCommand,
	#superclass : #PBProjectCommand,
	#instVars : [
		'package'
	],
	#category : #'CargoPackageManager-Calypso-Browser-Commands'
}

{ #category : #accessing }
PBPackageCommand class >> canBeExecutedInContext: aToolContext [
	^ aToolContext hasSelectedItems
]

{ #category : #accessing }
PBPackageCommand >> package [

	^ package
]

{ #category : #execution }
PBPackageCommand >> prepareFullExecutionInContext: aToolContext [

	super prepareFullExecutionInContext: aToolContext.
	package := aToolContext lastSelectedObject.

]
