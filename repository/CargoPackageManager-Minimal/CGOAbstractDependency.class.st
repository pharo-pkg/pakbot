"
API for common package / projet dependencies
"
Class {
	#name : #CGOAbstractDependency,
	#superclass : #Object,
	#instVars : [
		'project'
	],
	#category : 'CargoPackageManager-Minimal-Dependencies'
}

{ #category : #testing }
CGOAbstractDependency >> fitsPlatformRequirements [
	
	^ self subclassResponsibility
]

{ #category : #testing }
CGOAbstractDependency >> isSolved [
	
	self subclassResponsibility
]

{ #category : #accessing }
CGOAbstractDependency >> name [
	self subclassResponsibility 
]

{ #category : #accessing }
CGOAbstractDependency >> project: aCGOOngoingProject [ 

	project := aCGOOngoingProject
]

{ #category : #solving }
CGOAbstractDependency >> resolveInSolver: aCGOSolver [ 
	
	self subclassResponsibility
]
