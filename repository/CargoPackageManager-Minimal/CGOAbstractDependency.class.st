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

{ #category : #accessing }
CGOAbstractDependency >> fullyQualifiedName [
	^ self name
]

{ #category : #testing }
CGOAbstractDependency >> isInstalled [	
	"Returns true if the exact version is installed"
	^ self subclassResponsibility
]

{ #category : #testing }
CGOAbstractDependency >> isOutSync [	
	"Returns true if there is a version of the project installed but not the correct version"
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
