Class {
	#name : #PBBrowserItem,
	#superclass : #ClyBrowserItem,
	#category : #'CargoPackageManager-Calypso-Environment-Items'
}

{ #category : #testing }
PBBrowserItem >> hasOwnDecoration [

	^ true
]

{ #category : #testing }
PBBrowserItem >> includesActualObject: anObject [
	^ self actualObject = anObject
]

{ #category : #testing }
PBBrowserItem >> representsItemOfType: aClass [

	^ self actualObject representsItemOfType: aClass
]
