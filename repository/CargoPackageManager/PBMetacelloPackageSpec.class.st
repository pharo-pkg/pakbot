"
I represent a Metacello package spec.
See my superclass for more information.
"
Class {
	#name : #PBMetacelloPackageSpec,
	#superclass : #PBMetacelloSpec,
	#category : #'CargoPackageManager-Metacello'
}

{ #category : #'instance creation' }
PBMetacelloPackageSpec class >> named: aName [
	^ self new
		name: aName;
		yourself
]

{ #category : #converting }
PBMetacelloPackageSpec >> addRequirementsTo: aPBPackage [

	requirements do: [ :requirement | | dependency |
		dependency := PBPackageDependency on: requirement.
		dependency platformRequirements: self nonCommonAttributes.
		aPBPackage addDependency: dependency ]
]

{ #category : #converting }
PBMetacelloPackageSpec >> asPakbotPackageIn: aPBproject [
	| package |

	package := aPBproject newNotLoadedPackage: name.
	package platformRequirements: self nonCommonAttributes.
	self addRequirementsTo: package.
	
	^ package
]

{ #category : #initialization }
PBMetacelloPackageSpec >> initialize [ 
	requirements := OrderedCollection new.
	attributes := #().
]

{ #category : #converting }
PBMetacelloPackageSpec >> mergeIn: aPBPackage [
	self name 
		ifNotNil: [ self name = aPBPackage name ifFalse: [ self error: 'Cannot merge spec for a different packages!' ] ].

	self addRequirementsTo: aPBPackage.
]

{ #category : #accessing }
PBMetacelloPackageSpec >> nonCommonAttributes [
	^ self attributes reject: [ :each | each isEmpty or: [ each = #common ] ]
]
