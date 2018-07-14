Class {
	#name : #CGOClyPackageDependency,
	#superclass : #ClyProjectChildItem,
	#instVars : [
		'cargoPackageDependency'
	],
	#category : 'CargoPackageManager-Calypso-Environment'
}

{ #category : #'instance creation' }
CGOClyPackageDependency class >> of: aProject on: aCGOVirtualPackage [

	^(self project: aProject) 	
		cargoPackageDependency: aCGOVirtualPackage
]

{ #category : #'instance creation' }
CGOClyPackageDependency class >> on: aCGOPackageDependency [ 
	^self new 
		cargoPackageDependency: aCGOPackageDependency
]

{ #category : #comparing }
CGOClyPackageDependency >> = anObject [
	"Answer whether the receiver and anObject represent the same object."

	self == anObject
		ifTrue: [ ^ true ].
	self class = anObject class
		ifFalse: [ ^ false ].
	^ cargoPackageDependency = anObject cargoPackageDependency
]

{ #category : #accessing }
CGOClyPackageDependency >> allPackages [
	^ #()
]

{ #category : #accessing }
CGOClyPackageDependency >> cargoPackageDependency [
	^ cargoPackageDependency
]

{ #category : #accessing }
CGOClyPackageDependency >> cargoPackageDependency: anObject [
	cargoPackageDependency := anObject
]

{ #category : #decoration }
CGOClyPackageDependency >> decorateTableCell: anItemCellMorph of: groupItem [
	super decorateTableCell: anItemCellMorph of: groupItem.
			
	anItemCellMorph definitionIcon: #glamorousBookmark
]

{ #category : #comparing }
CGOClyPackageDependency >> hash [
	"Answer an integer value that is related to the identity of the receiver."

	^super hash bitXor: cargoPackageDependency hash
]

{ #category : #testing }
CGOClyPackageDependency >> isEmpty [
	^true
]

{ #category : #'as yet unclassified' }
CGOClyPackageDependency >> items [
	^#()
]

{ #category : #accessing }
CGOClyPackageDependency >> name [
 ^ cargoPackageDependency packageName
]

{ #category : #accessing }
CGOClyPackageDependency >> packages [
	^ #()
]
