Class {
	#name : #PBPackageReferenceUIItem,
	#superclass : #PBPackageUIItem,
	#instVars : [
		'parent',
		'assembly'
	],
	#category : #'CargoPackageManager-Calypso-Environment-Items'
}

{ #category : #'instance creation' }
PBPackageReferenceUIItem class >> on: aPackage inAssembly: anAssembly [

	^ (self on: aPackage)
		assembly: anAssembly;
		yourself
]

{ #category : #accessing }
PBPackageReferenceUIItem >> assembly: anAssembly [
	
	assembly := anAssembly
]

{ #category : #testing }
PBPackageReferenceUIItem >> canBeRemovedFromAssembly [
	
	^ true
]

{ #category : #removing }
PBPackageReferenceUIItem >> removeFromAssembly [
	
	assembly removePackage: package
]
