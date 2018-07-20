"
I represent a package leaf, i.e., I do not contain another package. I have dependencies.
"
Class {
	#name : #CGOPackageUnit,
	#superclass : #CGOPackageVersion,
	#instVars : [
		'dependencies',
		'provisions',
		'platformRequirements'
	],
	#category : 'CargoPackageManager-Minimal-Model'
}

{ #category : #example }
CGOPackageUnit class >> example [
	^ CGOOngoingPackage example asPackageVersionOf: CGOProject example
]

{ #category : #utility }
CGOPackageUnit class >> provisionsFromListOfProvisionStrings: aListOfProvisionStrings [
	" example: self provisionsFromListOfProvisionStrings: #('A@2.0' 'B') "
	aListOfProvisionStrings ifNil: [ ^ #() ].
	^ aListOfProvisionStrings
		collect: [ :provision | | pkgVersionRef |
			pkgVersionRef := provision asPackageVersionReference.
			CGOPackageVersionReference 
				packageName: pkgVersionRef packageName 
				version:	(pkgVersionRef versionNumber 
					ifNil: [ '1.0.0' asSemanticVersion ]
					ifNotNil: [ pkgVersionRef versionNumber ]) ]
]

{ #category : #serialization }
CGOPackageUnit class >> stonName [
	^ #'PackageUnit'
]

{ #category : #converting }
CGOPackageUnit >> asSerializablePackageVersion [
	^ CGOSerializedPackageUnit from: self
]

{ #category : #accessing }
CGOPackageUnit >> dependencies [
	^ dependencies
]

{ #category : #'initialization - private' }
CGOPackageUnit >> dependenciesFrom: aDictionary [
	^ aDictionary 
		at: #dependencies
		ifPresent: [ :aDependencyList | aDependencyList collect: #asPackageDependency ]
		ifAbsent: #()
]

{ #category : #testing }
CGOPackageUnit >> fitsPlatformRequirements [
	^ Cargo platformAttributes includesAll: platformRequirements
]

{ #category : #ston }
CGOPackageUnit >> fromSton: stonReader [
	"Decode the specific PackageVersion serialization format."
	| serializedPkgVersion |
	serializedPkgVersion := CGOSerializedPackageUnit new fromSton: stonReader.
	serializedPkgVersion flushIn: self.
]

{ #category : #initialization }
CGOPackageUnit >> initializeFrom: aDictionary [
	super initializeFrom: aDictionary.
	dependencies := self dependenciesFrom: aDictionary.
	provisions := self provisionsFrom: aDictionary.
	platformRequirements := aDictionary at: #platformRequirements ifAbsent: #().
	
]

{ #category : #initialization }
CGOPackageUnit >> initializeFromOngoing: aCGOOngoingPackageUnit project: aCGOProject [
	super initializeFromOngoing: aCGOOngoingPackageUnit project: aCGOProject.
	self flag: 'todo'.
	dependencies.
	platformRequirements.
	provisions.
]

{ #category : #testing }
CGOPackageUnit >> isUnit [
	^ true
]

{ #category : #accessing }
CGOPackageUnit >> platformRequirements [
	^ platformRequirements
]

{ #category : #printing }
CGOPackageUnit >> printOn: aStream [
	aStream << self name << '@' << self version asString << ' (unit)'
]

{ #category : #testing }
CGOPackageUnit >> provides: aVirtualPackageVersionReference [
	^ provisions 
		detect: [ :provision | | pkgVersionRef |
			pkgVersionRef := provision asPackageVersionReference.
			(pkgVersionRef packageName = aVirtualPackageVersionReference packageName)
				and: [ aVirtualPackageVersionReference versionString
							ifEmpty: [ true ]
							ifNotEmpty: [ pkgVersionRef versionString = aVirtualPackageVersionReference versionString ] ] ]
		ifFound: [ true ]
		ifNone: [ false ]
]

{ #category : #accessing }
CGOPackageUnit >> provisions [
	^ provisions
]

{ #category : #'initialization - private' }
CGOPackageUnit >> provisionsFrom: aDictionary [
	^ aDictionary 
		at: #provisions 
		ifPresent: [ :aProvisionList | aProvisionList ]
		ifAbsent: #()

]

{ #category : #ston }
CGOPackageUnit >> stonOn: stonWriter [
	self asSerializablePackageVersion stonOn: stonWriter
]
