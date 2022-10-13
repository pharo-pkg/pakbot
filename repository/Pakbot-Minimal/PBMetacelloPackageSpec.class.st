"
I represent a Metacello package spec.
See my superclass for more information.
"
Class {
	#name : #PBMetacelloPackageSpec,
	#superclass : #PBMetacelloSpec,
	#category : #'Pakbot-Minimal-Metacello-Support'
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
		dependency platformRequirements: self platformRequirements.
		aPBPackage addDependency: dependency ]
]

{ #category : #converting }
PBMetacelloPackageSpec >> asPakbotPackageIn: aPBproject [
	| package |

	package := aPBproject newNotLoadedPackage: name.
	package platformRequirements: self platformRequirements.
	self addRequirementsTo: package.
	
	^ package
]

{ #category : #converting }
PBMetacelloPackageSpec >> attributeMappingFor: aMetacelloAttribute [

	aMetacelloAttribute = #windows ifTrue: [ ^ PBPlatformAttributes windowsOSKey ].
	aMetacelloAttribute = #unix ifTrue: [ ^ PBPlatformAttributes unixOSKey ].
	aMetacelloAttribute = #osx ifTrue: [ ^ PBPlatformAttributes macOSKey ].
	^ aMetacelloAttribute
]

{ #category : #initialization }
PBMetacelloPackageSpec >> initialize [ 
	requirements := OrderedCollection new.
	attributes := #().
]

{ #category : #testing }
PBMetacelloPackageSpec >> isPackageSpec [
	
	^ true
]

{ #category : #converting }
PBMetacelloPackageSpec >> mergeIn: aPBPackage [
	self name 
		ifNotNil: [ self name = aPBPackage name ifFalse: [ self error: 'Cannot merge spec for a different packages!' ] ].

	self addRequirementsTo: aPBPackage.
]

{ #category : #accessing }
PBMetacelloPackageSpec >> nonCommonAttributes [
	^ self attributes 
		reject: [ :each | each isEmpty or: [ each = #common ] ]
]

{ #category : #converting }
PBMetacelloPackageSpec >> platformRequirements [
	| filteredAttributes attribute |
	filteredAttributes := self nonCommonAttributes.
	filteredAttributes ifEmpty: [ ^ #() ].
	filteredAttributes size > 1 
		ifTrue: [ self error: 'conditional loading with & clauses (nested #for:do: not yet supported!' ].
		
	attribute := filteredAttributes first.
	^ ((attribute includes: PBBaselineVisitor attributesConjonctionCharacter)
		ifTrue: [ (PBBaselineVisitor attributesConjonctionCharacter split: attribute) ]
		ifFalse: [ Array with: attribute ]) 
			collect: [ :each | self attributeMappingFor: each ]
]
