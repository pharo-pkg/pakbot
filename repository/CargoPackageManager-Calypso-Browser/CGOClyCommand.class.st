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
	#category : 'CargoPackageManager-Calypso-Browser-CargoPackageManager-Calypso-Browser'
}

{ #category : #execution }
CGOClyCommand >> applyResultInContext: aToolContext [
	self refreshCalypsoChild
]

{ #category : #execution }
CGOClyCommand >> prepareFullExecutionInContext: aToolContext [
	| packageManagers |
	super prepareFullExecutionInContext: aToolContext.
	toolContext := aToolContext.
	
	packageManagers := aToolContext systemEnvironment projectManager packageManagers.
	packageManagers size = 1
		ifTrue: [ packageManager := packageManagers first ]
		ifFalse: [ self shouldBeImplemented ].
]

{ #category : #private }
CGOClyCommand >> refreshCalypsoChild [
	toolContext lastSelectedItem childrenDataSource
		ifNil: [ 
			self refreshCalypsoRoot.
			toolContext lastSelectedItem expand ]
		ifNotNil: [:ds |
			self refreshCalypsoRoot ]
]

{ #category : #private }
CGOClyCommand >> refreshCalypsoRoot [

	toolContext tool packageView update
]
