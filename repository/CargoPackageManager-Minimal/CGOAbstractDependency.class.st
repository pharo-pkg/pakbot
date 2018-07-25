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

{ #category : #conflicts }
CGOAbstractDependency >> additionalConflictingInstalledProjects [

	^ #()
]

{ #category : #testing }
CGOAbstractDependency >> fitsPlatformRequirements [
	
	^ self subclassResponsibility
]

{ #category : #accessing }
CGOAbstractDependency >> fullyQualifiedName [
	^ self name
]

{ #category : #'querying - installed' }
CGOAbstractDependency >> isInstalled [
	
	"Returns true if the dependency is installed in the image with the same version"
	^ project registry isInstalled: self
]

{ #category : #testing }
CGOAbstractDependency >> isOutSync [	
	"Returns true if there is a version of the project installed but not the correct version"
	
	^ project registry isOutSync: self.
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
