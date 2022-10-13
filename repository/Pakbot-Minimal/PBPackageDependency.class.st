"
This class represents a package dependency.
The dependent is the package where this dependency was expressed.
Scope is a Symbol reprensenting the name of an external project dependency declared. It is optional and could be nil. 
Platform requirements allow conditional loading of the dependency (ex: only on Windows).
"
Class {
	#name : #PBPackageDependency,
	#superclass : #PBAbstractPackageDependency,
	#instVars : [
		'dependent',
		'constraints',
		'scope'
	],
	#category : #'Pakbot-Minimal-Dependencies'
}

{ #category : #'instance creation' }
PBPackageDependency class >> newFrom: anAssociation [
	^ self new
		initializeWith: anAssociation
]

{ #category : #'instance creation' }
PBPackageDependency class >> on: targetedPackageName [
	^ self on: targetedPackageName for: nil
]

{ #category : #'instance creation' }
PBPackageDependency class >> on: targetedPackageName for: aPackageName [
	^ self on: targetedPackageName for: aPackageName withConstraints: #()
]

{ #category : #'instance creation' }
PBPackageDependency class >> on: targetedPackageName for: aPackageName withConstraints: contraints [
	self flag: 'TODO: set the dependent with aPackage'.
	^ self new
		initializeOn: targetedPackageName withConstraints: contraints;
		yourself.
]

{ #category : #accessing }
PBPackageDependency class >> scopeSeparator [
	^ '::'
]

{ #category : #comparing }
PBPackageDependency >> = other [
	(targetedPackage = other targetedPackage) ifFalse: [ ^ false ].
	(constraints = other constraints) ifFalse: [ ^ false ].
	(dependent = other dependent) ifFalse: [ ^ false ].
	^ true
]

{ #category : #updating }
PBPackageDependency >> addDefaultVersionConstraint: aResolutionStrategy from: repositories for: platformAttributes [
	| defaultPackageVersionRef |
	constraints ifNotEmpty: [ ^ self ].
	defaultPackageVersionRef := aResolutionStrategy 
						versionOf: self
						in: repositories
						forEnvironment: platformAttributes.
	defaultPackageVersionRef ifNil: [ PBPackageNotFoundError signal: targetedPackage ].
	constraints := { PBFixedVersionConstraint with: defaultPackageVersionRef versionString }

]

{ #category : #converting }
PBPackageDependency >> asLiteral [
	^ constraints 
		ifEmpty: [ self packageName ]
		ifNotEmpty: [ self packageName -> (constraints collect: #asString as: Array) ]
]

{ #category : #converting }
PBPackageDependency >> asPackageDependency [
	^ self
]

{ #category : #accessing }
PBPackageDependency >> constraints [
	^ constraints
]

{ #category : #accessing }
PBPackageDependency >> dependencyName [
	"Name used to find the depencency in a package repository"
	^ scope
		ifNil: [ targetedPackage ]
		ifNotNil: [ scope , self class scopeSeparator , targetedPackage ]
]

{ #category : #accessing }
PBPackageDependency >> dependent [
	"Returns the entity that declared the dependency"
	^ dependent
]

{ #category : #accessing }
PBPackageDependency >> dependent: aPBLoadableUnit [

	dependent := aPBLoadableUnit
]

{ #category : #testing }
PBPackageDependency >> hasScope [
	^ scope isNotNil
]

{ #category : #comparing }
PBPackageDependency >> hash [
	^ targetedPackage hash 
		bitXor: dependent hash
]

{ #category : #private }
PBPackageDependency >> indexOfScope: packageName [
	^ packageName indexOfSubCollection: self class scopeSeparator
]

{ #category : #initialization }
PBPackageDependency >> initializeOn: aPackageName withConstraints: aConstraintList [
	self initializeTargetAndScopeFrom: aPackageName.
	constraints := Array newFrom: aConstraintList.
	platformRequirements := Array new.
]

{ #category : #initialization }
PBPackageDependency >> initializeTargetAndScopeFrom: aPackageName [
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
PBPackageDependency >> initializeWith: anAssociation [ 
	| constraintStringList |
	self initializeTargetAndScopeFrom: anAssociation key asSymbol.
	constraintStringList := anAssociation value.
	constraints := constraintStringList collect: 
		[ :constraintString | PBDependencyConstraint fromString: constraintString  ]
]

{ #category : #testing }
PBPackageDependency >> isSolved [
	self shouldBeImplemented.
]

{ #category : #accessing }
PBPackageDependency >> name [
	
	^ targetedPackage
]

{ #category : #accessing }
PBPackageDependency >> packageName [
	^ targetedPackage
]

{ #category : #printing }
PBPackageDependency >> printOn: aStream [
	aStream << self packageName << ' ('.
	constraints printOn: aStream delimiter: Character space.
	aStream << ')'.
]

{ #category : #accessing }
PBPackageDependency >> project [
	"project is not set on dependencies after deserialization from STON"
	^ project ifNil: [ dependent ifNotNil: [ :theDependent | theDependent project ] ]
]

{ #category : #solving }
PBPackageDependency >> resolveIn: aPBResolvedProject solver: aPBSolver [
	aPBResolvedProject addToLoadList: self packageName.
	self resolvedDependency dependencies 
		do: [ :dep | 
				dep resolveIn: aPBResolvedProject solver: aPBSolver ]

]

{ #category : #solving }
PBPackageDependency >> resolvedDependency [
	^ self project packageNamed: self packageName
]

{ #category : #constrains }
PBPackageDependency >> satisfyConstraints: aSemanticVersion [ 
	^ constraints allSatisfy: [ :each | each isCompatibleWith: aSemanticVersion ]
]

{ #category : #accessing }
PBPackageDependency >> scope [
	^ scope
]
