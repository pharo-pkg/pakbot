"
This class represents a package dependency.
The dependent is the package where this dependency was expressed.
Scope is a Symbol reprensenting the name of an external project dependency declared. It is optional and could be nil. 
"
Class {
	#name : #CGOPackageDependency,
	#superclass : #CGOAbstractPackageDependency,
	#instVars : [
		'dependent',
		'constraints',
		'scope'
	],
	#category : 'CargoPackageManager-Minimal-Dependencies'
}

{ #category : #'instance creation' }
CGOPackageDependency class >> newFrom: anAssociation [
	^ self new
		initializeWith: anAssociation
]

{ #category : #'instance creation' }
CGOPackageDependency class >> on: targetedPackageName [
	^ self on: targetedPackageName for: nil
]

{ #category : #'instance creation' }
CGOPackageDependency class >> on: targetedPackageName for: aPackageName [
	^ self on: targetedPackageName for: aPackageName withConstraints: #()
]

{ #category : #'instance creation' }
CGOPackageDependency class >> on: targetedPackageName for: aPackageName withConstraints: contraints [
	self flag: 'TODO: set the dependent with aPackage'.
	^ self new
		initializeOn: targetedPackageName withConstraints: contraints;
		yourself.
]

{ #category : #accessing }
CGOPackageDependency class >> scopeSeparator [
	^ '::'
]

{ #category : #comparing }
CGOPackageDependency >> = other [
	(targetedPackage = other targetedPackage) ifFalse: [ ^ false ].
	(constraints = other constraints) ifFalse: [ ^ false ].
	(dependent = other dependent) ifFalse: [ ^ false ].
	^ true
]

{ #category : #updating }
CGOPackageDependency >> addDefaultVersionConstraint: aResolutionStrategy from: repositories for: platformAttributes [
	| defaultPackageVersionRef |
	constraints ifNotEmpty: [ ^ self ].
	defaultPackageVersionRef := aResolutionStrategy 
						versionOf: self
						in: repositories
						forEnvironment: platformAttributes.
	defaultPackageVersionRef ifNil: [ CGOPackageNotFoundError signal: targetedPackage ].
	constraints := { CGOFixedVersionConstraint with: defaultPackageVersionRef versionString }

]

{ #category : #converting }
CGOPackageDependency >> asLiteral [
	^ constraints 
		ifEmpty: [ self packageName ]
		ifNotEmpty: [ self packageName -> (constraints collect: #asString as: Array) ]
]

{ #category : #converting }
CGOPackageDependency >> asPackageDependency [
	^ self
]

{ #category : #accessing }
CGOPackageDependency >> constraints [
	^ constraints
]

{ #category : #accessing }
CGOPackageDependency >> dependencyName [
	"Name used to find the depencency in a package repository"
	^ scope
		ifNil: [ targetedPackage ]
		ifNotNil: [ scope , self class scopeSeparator , targetedPackage ]
]

{ #category : #accessing }
CGOPackageDependency >> dependent [
	^ dependent
]

{ #category : #testing }
CGOPackageDependency >> hasScope [
	^ scope isNotNil
]

{ #category : #comparing }
CGOPackageDependency >> hash [
	^ targetedPackage hash 
		bitXor: dependent hash
]

{ #category : #private }
CGOPackageDependency >> indexOfScope: packageName [
	^ packageName indexOfSubCollection: self class scopeSeparator
]

{ #category : #initialization }
CGOPackageDependency >> initializeOn: aPackageName withConstraints: aConstraintList [
	super initialize.
	self initializeTargetAndScopeFrom: aPackageName.
	constraints := Array newFrom: aConstraintList
]

{ #category : #initialization }
CGOPackageDependency >> initializeTargetAndScopeFrom: aPackageName [
	| index |
	index := self indexOfScope: aPackageName.
	index = 0
		ifTrue: [ targetedPackage := aPackageName asSymbol ]
		ifFalse: [ scope := (aPackageName first: index - 1) asSymbol.
			targetedPackage := (aPackageName
				copyFrom: index + 2
				to: aPackageName size) asSymbol ]
]

{ #category : #initialization }
CGOPackageDependency >> initializeWith: anAssociation [ 
	| constraintStringList |
	self initializeTargetAndScopeFrom: anAssociation key asSymbol.
	constraintStringList := anAssociation value.
	constraints := constraintStringList collect: 
		[ :constraintString | CGODependencyConstraint fromString: constraintString  ]
]

{ #category : #testing }
CGOPackageDependency >> isInstalled [
	
	^ project registry isInstalled: self
]

{ #category : #testing }
CGOPackageDependency >> isSolved [
	self shouldBeImplemented.
]

{ #category : #accessing }
CGOPackageDependency >> name [
	
	^ targetedPackage
]

{ #category : #accessing }
CGOPackageDependency >> packageName [
	^ targetedPackage
]

{ #category : #printing }
CGOPackageDependency >> printOn: aStream [
	aStream << self packageName << ' ('.
	constraints printOn: aStream delimiter: Character space.
	aStream << ')'.
]

{ #category : #constrains }
CGOPackageDependency >> satisfyConstraints: aSemanticVersion [ 
	^ constraints allSatisfy: [ :each | each isCompatibleWith: aSemanticVersion ]
]

{ #category : #accessing }
CGOPackageDependency >> scope [
	^ scope
]
