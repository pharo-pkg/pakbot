"
A visitor of nodes used by Iceberg diff allwing to get the list of modifications.
"
Class {
	#name : #IceDiffListingVisitor,
	#superclass : #IceTreeVisitor,
	#instVars : [
		'patcher',
		'additions',
		'removals',
		'modifications'
	],
	#category : #'Pakbot-Browser-Tests'
}

{ #category : #accessing }
IceDiffListingVisitor >> additions [
	^ additions
]

{ #category : #initialization }
IceDiffListingVisitor >> initialize [ 
	additions := OrderedCollection new.
	removals := OrderedCollection new.
	modifications := OrderedCollection new.
]

{ #category : #accessing }
IceDiffListingVisitor >> modifications [
	^ modifications
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
IceDiffListingVisitor >> visitModification: anIceModification [ 
	modifications add: anIceModification
]

{ #category : #visiting }
IceDiffListingVisitor >> visitRemoval: anIceRemoval [ 
	removals add: anIceRemoval definition.
	self visitChildrenOf: currentNode
]
