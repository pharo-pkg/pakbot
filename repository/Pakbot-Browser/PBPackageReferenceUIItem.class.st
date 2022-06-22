"
I represent a package referenced in an assembly.
"
Class {
	#name : #PBPackageReferenceUIItem,
	#superclass : #PBPackageUIItem,
	#instVars : [
		'assembly'
	],
	#category : #'Pakbot-Browser-Items'
}

{ #category : #'instance creation' }
PBPackageReferenceUIItem class >> forPackage: aPBPackage in: aPBAssembly presenter: aSpPresenter [

	^ self new
		package: aPBPackage;
		assembly: aPBAssembly;
		presenter: aSpPresenter;
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

{ #category : #accessing }
PBPackageReferenceUIItem >> commands [ 
	
	^ super commands copyWith: (PBRemovePackageReferenceFromAssemblyCommand forSpecContext: presenter)
]

{ #category : #removing }
PBPackageReferenceUIItem >> removeFromAssembly [
	
	assembly removePackage: package
]
