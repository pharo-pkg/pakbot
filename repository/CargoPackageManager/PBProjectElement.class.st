Class {
	#name : #PBProjectElement,
	#superclass : #PBLoadableUnit,
	#instVars : [
		'project'
	],
	#category : #'CargoPackageManager-Model'
}

{ #category : #accessing }
PBProjectElement >> fullyQualifiedName [

	 ^ self projectName, '::' , self name
]

{ #category : #accessing }
PBProjectElement >> project [
	^ project
]

{ #category : #accessing }
PBProjectElement >> project: aCGOOngoingProject [ 
	project := aCGOOngoingProject
]

{ #category : #actions }
PBProjectElement >> remove [
	
	self subclassResponsibility
]
