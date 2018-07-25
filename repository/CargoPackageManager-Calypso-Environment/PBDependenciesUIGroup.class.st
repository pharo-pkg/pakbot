Class {
	#name : #PBDependenciesUIGroup,
	#superclass : #PBAbstractUIItem,
	#instVars : [
		'project'
	],
	#category : #'CargoPackageManager-Calypso-Environment-Items'
}

{ #category : #'instance-creation' }
PBDependenciesUIGroup class >> onProject: aProject [
	^ self new
		project: aProject;
		yourself
]

{ #category : #decorating }
PBDependenciesUIGroup >> decorateTableCell: anItemCellMorph inContext: itemContext [

	anItemCellMorph definitionIcon: #glamorousBookmark.
	anItemCellMorph label color: anItemCellMorph theme calypsoFrozenItemColor.
]

{ #category : #announcements }
PBDependenciesUIGroup >> isAffectedBy: anAnnouncement [ 
	
	^ false
]

{ #category : #accessing }
PBDependenciesUIGroup >> items [ 
	^ project dependencies collect: [ :each | PBDependencyUIItem on: each ]
]

{ #category : #accessing }
PBDependenciesUIGroup >> name [
	
	^ 'Dependencies'
]

{ #category : #accessing }
PBDependenciesUIGroup >> project [
	^ project
]

{ #category : #accessing }
PBDependenciesUIGroup >> project: anObject [
	project := anObject
]

{ #category : #testing }
PBDependenciesUIGroup >> representsItemOfType: aClass [ 

	^ self class includesBehavior: aClass
]
