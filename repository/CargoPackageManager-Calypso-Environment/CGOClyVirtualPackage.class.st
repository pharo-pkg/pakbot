"
I represent a virtual package in a project tree.
I build my children nodes in #buildContentItems.
"
Class {
	#name : #CGOClyVirtualPackage,
	#superclass : #ClyProjectChildItem,
	#instVars : [
		'cargoPackage'
	],
	#category : 'CargoPackageManager-Calypso-Environment'
}

{ #category : #'instance creation' }
CGOClyVirtualPackage class >> of: aProject on: aCGOVirtualPackage [

	^(self project: aProject) 	
		cargoPackage: aCGOVirtualPackage
]

{ #category : #comparing }
CGOClyVirtualPackage >> = anObject [
	"Answer whether the receiver and anObject represent the same object."

	self == anObject
		ifTrue: [ ^ true ].
	self class = anObject class
		ifFalse: [ ^ false ].
	^ cargoPackage = anObject cargoPackage
]

{ #category : #accessing }
CGOClyVirtualPackage >> allPackages [
	^ #()
]

{ #category : #'building items' }
CGOClyVirtualPackage >> buildContentItems [
	^ #()
]

{ #category : #accessing }
CGOClyVirtualPackage >> cargoPackage [
	^ cargoPackage
]

{ #category : #accessing }
CGOClyVirtualPackage >> cargoPackage: anObject [
	cargoPackage := anObject
]

{ #category : #comparing }
CGOClyVirtualPackage >> hash [
	"Answer an integer value that is related to the identity of the receiver."

	^super hash bitXor: cargoPackage hash
]

{ #category : #testing }
CGOClyVirtualPackage >> isEmpty [
	^ true
]

{ #category : #accessing }
CGOClyVirtualPackage >> name [
	^ cargoPackage packageName
]

{ #category : #accessing }
CGOClyVirtualPackage >> packages [
	^ #()
]
