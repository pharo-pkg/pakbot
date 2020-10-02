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

{ #category : #accessing }
PBAssemblyUIItem >> assembly [
	^ assembly
]

{ #category : #decorating }
PBAssemblyUIItem >> decorateTableCell: anItemCellMorph inContext: itemContext [

	| morph |
	
	morph := (self iconNamed: assembly iconName) asAlphaImageMorph.
	morph setBalloonText: assembly balloonText.
	self isInstalled ifFalse: [ morph alpha: 0.6 ].
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

{ #category : #testing }
PBAssemblyUIItem >> isAssembly [
	
	^ true
]

{ #category : #testing }
PBAssemblyUIItem >> isInstalled [
	
	^ assembly isInstalled
]

{ #category : #accessing }
PBAssemblyUIItem >> items [
	^ ((assembly packages
		collect: [ :each | PBPackageReferenceUIItem on: each inAssembly: assembly ])
		asSortedCollection: [ :a :b | a name < b name ]) asOrderedCollection
]

{ #category : #testing }
PBAssemblyUIItem >> name [
	
	^ assembly name
]

{ #category : #testing }
PBAssemblyUIItem >> representsItemOfType: aClass [

	^ (PBAbstractDependency includesBehavior: aClass)
		or: [ self class includesBehavior: aClass ]
]

{ #category : #testing }
PBAssemblyUIItem >> versionString [

	^ assembly constraints size = 1
		ifTrue: [ ^ assembly constraints anyOne displayString ]
		ifFalse: [ assembly constraints displayString ]
]
