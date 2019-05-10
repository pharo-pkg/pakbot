"
A visitor of nodes used by Iceberg diff allowing to get the list of modifications.
"
Class {
	#name : #IceDiffListingVisitor,
	#superclass : #IceTreeVisitor,
	#instVars : [
		'patcher',
		'additions',
		'removals'
	],
	#category : #'CargoPackageManager-UI-Tests'
}

{ #category : #accessing }
IceDiffListingVisitor >> additions [
	^ additions
]

{ #category : #initialization }
IceDiffListingVisitor >> initialize [ 
	additions := OrderedCollection new.
	removals := OrderedCollection new.
]

{ #category : #accessing }
IceDiffListingVisitor >> removals [
	^ removals
]

{ #category : #visiting }
IceDiffListingVisitor >> visitAddition: anIceAddition [ 
	additions add: anIceAddition definition.
	self visitChildrenOf: currentNode
]

{ #category : #visiting }
IceDiffListingVisitor >> visitRemoval: anIceRemoval [ 
	removals add: anIceRemoval definition.
	self visitChildrenOf: currentNode
]
