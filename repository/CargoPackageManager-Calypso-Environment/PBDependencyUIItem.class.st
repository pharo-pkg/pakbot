Class {
	#name : #PBDependencyUIItem,
	#superclass : #PBAbstractUIItem,
	#instVars : [
		'dependency'
	],
	#category : #'CargoPackageManager-Calypso-Environment-Items'
}

{ #category : #accessing }
PBDependencyUIItem class >> on: aDependency [ 
	^ self new
		dependency: aDependency;
		yourself
]

{ #category : #decorating }
PBDependencyUIItem >> decorateTableCell: anItemCellMorph inContext: itemContext [

	| morph |
	morph := (Smalltalk ui theme iconNamed: dependency statusIconName) asMorph.
	morph setBalloonText: dependency balloonText.
	anItemCellMorph definitionMorph: morph
]

{ #category : #accessing }
PBDependencyUIItem >> dependency: aDependency [ 
	
	dependency := aDependency
]

{ #category : #announcements }
PBDependencyUIItem >> isAffectedBy: anAnnouncement [ 
	
	^ false
]

{ #category : #accessing }
PBDependencyUIItem >> items [ 
	^ #()
]

{ #category : #testing }
PBDependencyUIItem >> name [
	
	^ dependency name , ' ( ' , self versionString, ' )' 
]

{ #category : #testing }
PBDependencyUIItem >> representsItemOfType: aClass [

	^ (PBAbstractDependency includesBehavior: aClass)
		or: [ self class includesBehavior: aClass ]
]

{ #category : #testing }
PBDependencyUIItem >> versionString [

	^ dependency constraints size = 1
		ifTrue: [ ^ dependency constraints anyOne displayString ]
		ifFalse: [ dependency constraints displayString ]
]
