Class {
	#name : #PBAssemblyUIItem,
	#superclass : #PBAbstractUIItem,
	#instVars : [
		'assembly'
	],
	#category : #'CargoPackageManager-Calypso-Environment-Items'
}

{ #category : #accessing }
PBAssemblyUIItem class >> on: aDependency [ 
	^ self new
		dependency: aDependency;
		yourself
]

{ #category : #adding }
PBAssemblyUIItem >> addPackages: aCollection [ 
	
	aCollection do: [ :each | assembly addPackage: each ]
]

{ #category : #decorating }
PBAssemblyUIItem >> decorateTableCell: anItemCellMorph inContext: itemContext [

	| morph |
	morph := (Smalltalk ui theme iconNamed: assembly iconName) asMorph.
	morph setBalloonText: assembly balloonText.
	anItemCellMorph definitionMorph: morph
]

{ #category : #accessing }
PBAssemblyUIItem >> dependency: aDependency [ 
	
	assembly := aDependency
]

{ #category : #announcements }
PBAssemblyUIItem >> isAffectedBy: anAnnouncement [ 
	
	^ false
]

{ #category : #accessing }
PBAssemblyUIItem >> items [
	^ ((assembly packages
		collect: [ :each | PBPackageUIItem on: each ])
		asSortedCollection: [ :a :b | a name < b name ]) asOrderedCollection
]

{ #category : #testing }
PBAssemblyUIItem >> name [
	
	^ assembly name
]

{ #category : #accessing }
PBAssemblyUIItem >> packageCandidates [
	
	^ assembly packageCandidates
]

{ #category : #testing }
PBAssemblyUIItem >> representsItemOfType: aClass [

	^ (CGOAbstractDependency includesBehavior: aClass)
		or: [ self class includesBehavior: aClass ]
]

{ #category : #testing }
PBAssemblyUIItem >> versionString [

	^ assembly constraints size = 1
		ifTrue: [ ^ assembly constraints anyOne displayString ]
		ifFalse: [ assembly constraints displayString ]
]
