"
BFS (see http://en.wikipedia.org/wiki/Breadth-first_search)  iterator.
We avoid to visit already visited children of a node.

	iterator := (BFSIterator 
		on: aGraphRoot 
		nextBlock: [ :parent | parent children]).
	[ iterator hasNext ] whileTrue: 
		[ iterator next ]
"
Class {
	#name : #BFSIterator,
	#superclass : #Object,
	#instVars : [
		'queue',
		'alreadyVisited',
		'root',
		'nextBlock'
	],
	#category : 'CargoPackageManager-Utils'
}

{ #category : #'instance creation' }
BFSIterator class >> on: anObject nextBlock: aBlock [
	^ self new
		root: anObject;
		nextBlock: aBlock;
		yourself.
]

{ #category : #private }
BFSIterator >> hasChildNodes: aNode [
	| children |
	
	[ children := nextBlock value: aNode ] 
		on: MessageNotUnderstood 
		do: [ ^ false ].
	^ children size > 0
]

{ #category : #protocol }
BFSIterator >> hasNext [
	^ queue isEmpty not
	
]

{ #category : #initialization }
BFSIterator >> initialize [
	queue := SharedQueue new.
	alreadyVisited := Set new.
]

{ #category : #private }
BFSIterator >> isNotVisited: aNode [
	^ (alreadyVisited includes: aNode) not
]

{ #category : #protocol }
BFSIterator >> next [
	| currentElement |
	
	currentElement := queue nextOrNil.
	currentElement ifNotNil: [
		((self hasChildNodes: currentElement) and: [ self isNotVisited: currentElement ])
			ifTrue: [ queue nextPutAll: (nextBlock value: currentElement).
					 alreadyVisited add: currentElement ] ].
	^ currentElement
]

{ #category : #accessing }
BFSIterator >> nextBlock: aBlock [
	nextBlock := aBlock
]

{ #category : #protocol }
BFSIterator >> reset [
	self initialize.
	queue nextPut: root
]

{ #category : #accessing }
BFSIterator >> root: anObject [
	root := anObject.
	self reset
]
