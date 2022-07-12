Class {
	#name : #PBPackageDependencyTest,
	#superclass : #CGOTest,
	#category : #'CargoPackageManager-Tests-Model'
}

{ #category : #accessing }
PBPackageDependencyTest class >> resources [
	^ #()
]

{ #category : #'tests-accessing' }
PBPackageDependencyTest >> testCanCreateDependencyFromNonScopedPackage [
	| dependency |
	dependency := PBPackageDependency on: #Package.
	
	self 
		assert: dependency targetedPackage 
		equals: 'Package'.
	self assert: dependency scope isNil
]

{ #category : #'tests-accessing' }
PBPackageDependencyTest >> testCanCreateDependencyFromScopedPackage [
	| dependency |
	dependency := PBPackageDependency on: #Project::Package.
	
	self 
		assert: dependency targetedPackage 
		equals: 'Package'.
	self 
		assert: dependency scope
		equals: 'Project'
]

{ #category : #'tests-creation' }
PBPackageDependencyTest >> testCreateDependencyFromCollectionOfContstraintsShouldCreateSeveralConstraints [

	| dependency |
	dependency := PBPackageDependency newFrom: #A -> #('=1.1.1' '=1.1.2' '=1.1.3').
	self assert: dependency constraints size equals: 3
]

{ #category : #'tests-creation' }
PBPackageDependencyTest >> testCreateDependencyFromExactFeatureDependencyNumberShouldHaveFixedVersionConstraint [

	| dependency |
	dependency := PBPackageDependency newFrom: #A -> #('=1.1').
	
	self assert: dependency constraints first isFixed
]

{ #category : #'tests-creation' }
PBPackageDependencyTest >> testCreateDependencyFromExactFeatureDependencyNumberShouldSucceed [

	PBPackageDependency newFrom: #A -> #('=1.1')
]

{ #category : #'tests-creation' }
PBPackageDependencyTest >> testCreateDependencyFromExactMajorDependencyNumberShouldHaveFixedVersionConstraint [

	| dependency |
	dependency := PBPackageDependency newFrom: #A -> #('=1').
	
	self assert: dependency constraints first isFixed
]

{ #category : #'tests-creation' }
PBPackageDependencyTest >> testCreateDependencyFromExactMajorDependencyNumberShouldSucceed [

	PBPackageDependency newFrom: #A -> #('=1')
]

{ #category : #'tests-creation' }
PBPackageDependencyTest >> testCreateDependencyFromExactPatchDependencyNumberShouldHaveFixedVersionConstraint [

	| dependency |
	dependency := PBPackageDependency newFrom: #A -> #('=1.1.1').
	
	self assert: dependency constraints first isFixed
]

{ #category : #'tests-creation' }
PBPackageDependencyTest >> testCreateDependencyFromExactPatchDependencyNumberShouldSucceed [

	PBPackageDependency newFrom: #A -> #('=1.1.1')
]

{ #category : #'tests-creation' }
PBPackageDependencyTest >> testCreateDependencyWithNoConstraintsShouldCreateNoConstraints [
	| dependency |
	dependency := PBPackageDependency newFrom: #A -> #().
	
	self assert: dependency constraints isEmpty
]

{ #category : #'tests-creation' }
PBPackageDependencyTest >> testCreateDependencyWithoutEqualGeneratesAConstraint [
	| dep |

	dep := PBPackageDependency newFrom: #A -> #('1.1.1').

	self assert: dep constraints size equals: 1.
	self assert: dep constraints anyOne class equals: CGOFixedVersionConstraint.
	self deny: dep constraints anyOne version isInvalid.
]

{ #category : #'tests-serialization' }
PBPackageDependencyTest >> testDependencyLiteralReprensentationWithNoConstraintsShouldBeDependencyAssociationWithEmptyConstraintCollection [
	| dependency |
	dependency := PBPackageDependency newFrom: #A -> #().

	self assert: dependency asLiteral equals: #A
]

{ #category : #'tests-serialization' }
PBPackageDependencyTest >> testDependencyLiteralRepresentationShouldBeDependencyAssociation [
	| dependency |
	dependency := PBPackageDependency newFrom: #A -> #('=1.0.0').

	self assert: dependency asLiteral equals: #A -> #('1.0.0')
]

{ #category : #'tests-version comparison' }
PBPackageDependencyTest >> testFeatureDependencyNumberShouldSemanticVersionEquivalent [

	| dependency |
	dependency := PBPackageDependency newFrom: #A -> #('=1.1').
	
	self assert: dependency constraints first version equals: '1.1' asSemanticVersion.
]

{ #category : #'tests-version comparison' }
PBPackageDependencyTest >> testMajorDependencyNumberShouldSemanticVersionEquivalent [

	| dependency |
	dependency := PBPackageDependency newFrom: #A -> #('=1').
	
	self assert: dependency constraints first version equals: '1.0.0' asSemanticVersion.
]

{ #category : #'tests-version comparison' }
PBPackageDependencyTest >> testPatchDependencyNumberShouldSemanticVersionEquivalent [

	| dependency |
	dependency := PBPackageDependency newFrom: #A -> #('=1.1.1').
	
	self assert: dependency constraints first version equals: '1.1.1' asSemanticVersion.
]
