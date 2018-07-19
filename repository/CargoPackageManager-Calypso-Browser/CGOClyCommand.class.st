"
Common super class for Cargo commands.
It provides a way to refresh Calypso UI while Cargo does not provide System announcements.
"
Class {
	#name : #CGOClyCommand,
	#superclass : #CmdCommand,
	#instVars : [
		'toolContext',
		'packageManager'
	],
	#category : #'CargoPackageManager-Calypso-Browser-Commands'
}

{ #category : #execution }
CGOClyCommand >> prepareFullExecutionInContext: aToolContext [
	| packageManagers |
	super prepareFullExecutionInContext: aToolContext.
	toolContext := aToolContext.
	
	packageManagers := aToolContext systemEnvironment projectManager projectManagers.
	packageManagers size = 1
		ifTrue: [ packageManager := packageManagers first ]
		ifFalse: [ self shouldBeImplemented ].
]
