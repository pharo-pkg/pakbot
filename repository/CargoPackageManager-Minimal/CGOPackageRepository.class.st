"
A cargo package repository provides access to a concrete package storage. It lists the packages and versions it stores and provides some other high level accesses like getting the latest version or the version that satisfies certain criteria.

This class is an abstract class exposing the repository main API. See subclasses for concrete implementations.
"
Class {
	#name : #CGOPackageRepository,
	#superclass : #Object,
	#instVars : [
		'baseUrl'
	],
	#category : #'CargoPackageManager-Minimal-Model'
}

{ #category : #'instance creation' }
CGOPackageRepository class >> newWithUrl: anURL [
	^ self basicNew	
		initializeWithUrl: anURL;
		yourself.
	
]

{ #category : #private }
CGOPackageRepository >> checkPreviousRegistrationOf: aPackageVersion [
	| existingPackageVersion |
	
	[ existingPackageVersion := self
		fetch: aPackageVersion packageName
		version: aPackageVersion version.
	aPackageVersion isDevelopmentVersion
		ifFalse:
			[ PBPackageVersionAlreadyExistsError
				signal: aPackageVersion asString , ' already defined' ] ]
		on:
			PBPackageNotFoundError , CGOPackageVersionNotFoundError
		do: [  ].	"no version found for release versions => ok"
	^ existingPackageVersion
]

{ #category : #private }
CGOPackageRepository >> does: aPackageVersion fitPlatformRequirements: requirements [
	^ aPackageVersion platformRequirements 
			ifEmpty: [ true ]
			ifNotEmpty: [ :pkgRequirements | (requirements asSet intersection: pkgRequirements asSet) notEmpty ]
]

{ #category : #'versions fetching' }
CGOPackageRepository >> fetch: aPackageVersionString [
	| pkgVersionRef |

	pkgVersionRef := aPackageVersionString asPackageVersionReference.
	^ self 
		fetch: pkgVersionRef packageName
		version: pkgVersionRef versionString.
]

{ #category : #'versions fetching' }
CGOPackageRepository >> fetch: aPackageName version: aVersion [
	self subclassResponsibility
]

{ #category : #'versions fetching' }
CGOPackageRepository >> fetchVirtual: aVirtualPackageName version: aVersion [
	self subclassResponsibility
]

{ #category : #initialization }
CGOPackageRepository >> initializeWithUrl: aUrlString [
	baseUrl := aUrlString.
	self initialize
]

{ #category : #testing }
CGOPackageRepository >> isVirtual: aPackageName [
	^ (self package: aPackageName) isVirtual
]

{ #category : #private }
CGOPackageRepository >> latestVersionOfConcretePackage: aPackageName suitableForEnvironment: platformAttributes [
	self subclassResponsibility
]

{ #category : #'versions fetching' }
CGOPackageRepository >> latestVersionOfPackage: aPackageName suitableForEnvironment: platformAttributes [
	^ (self isVirtual: aPackageName)
		ifTrue: [ self latestVersionOfVirtualPackage: aPackageName suitableForEnvironment: platformAttributes ]
		ifFalse: [ self latestVersionOfConcretePackage: aPackageName suitableForEnvironment: platformAttributes ]
]

{ #category : #private }
CGOPackageRepository >> latestVersionOfVirtualPackage: aVirtualPackageName suitableForEnvironment: platformAttributes [
	"Virtual packages DO NOT support platform attributes at this time. So, platformAttributes argument is just ignored"
	| pkgVersionRef |
	pkgVersionRef := ((self versionStringsOfVirtual: aVirtualPackageName) collect: #asPackageVersionReference)
		detectMax: #versionNumber.
	^ self fetchVirtual: pkgVersionRef packageName version: pkgVersionRef versionString
]

{ #category : #fetching }
CGOPackageRepository >> package: aPackageName [
	self subclassResponsibility
]

{ #category : #'versions fetching' }
CGOPackageRepository >> packageNames [
	"list name of all packages available in the repository"
	self subclassResponsibility
]

{ #category : #'versions fetching' }
CGOPackageRepository >> packagesProviding: aName version: aSemanticVersion forEnvironment: platformAttributes [
	self subclassResponsibility
]

{ #category : #'versions posting' }
CGOPackageRepository >> savePackageVersion: aPackageVersion [
	"Save the given package version in the repository"
	self subclassResponsibility
]

{ #category : #'versions fetching' }
CGOPackageRepository >> versionStringsOf: aPackageName [
	"Returns the list of versions available in the repository for the given package name"
	self subclassResponsibility
]

{ #category : #'versions fetching' }
CGOPackageRepository >> versionStringsOfVirtual: aPackageName [
	"Returns the list of versions available in the repository for the given virtual package name"
	self subclassResponsibility
]
