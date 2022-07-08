Class {
	#name : #CGOPackageVersionReferenceTest,
	#superclass : #CGOTest,
	#instVars : [
		'pkgVersionReference',
		'pkgVersionString'
	],
	#category : #'CargoPackageManager-FailingTests-Model'
}

{ #category : #tests }
CGOPackageVersionReferenceTest >> assertIsExpectedPackageVersion: packageVersion [
	self assert: packageVersion notNil.
	self assert: (packageVersion isKindOf: CGOPackageVersion).
	self assert: packageVersion packageName equals: pkgVersionReference packageName.
	self assert: packageVersion version equals: pkgVersionReference versionNumber
]

{ #category : #input }
CGOPackageVersionReferenceTest >> packageVersionDescription [
	^ PBPackageVersionWriterV1 toStringPretty: self resolvedProjectVersion
]

{ #category : #input }
CGOPackageVersionReferenceTest >> resolvedProjectVersion [
	^ self packageVersions detect: [ :each | each packageName = pkgVersionReference packageName ]
]

{ #category : #running }
CGOPackageVersionReferenceTest >> setUp [ 
	| remoteRepositoryMock |
	pkgVersionReference := CGOPackageVersionReference newOn: 'Seaside-Core@3.1.0'.
	remoteRepositoryMock := protocol mock: 'remoteRepositoryMock'.
	protocol describe
		allow: remoteRepositoryMock recv: #fetch:version:;
		=> self resolvedProjectVersion.
	pkgVersionReference packageRepositories: { remoteRepositoryMock }
]

{ #category : #tests }
CGOPackageVersionReferenceTest >> testAsPackageVersion [
	self assertIsExpectedPackageVersion: pkgVersionReference asPackageVersion
]

{ #category : #tests }
CGOPackageVersionReferenceTest >> testCanCreateFromPackageName [
	| ref |
	ref := 'SomePackage' asPackageVersionReference.
	self 
		assert: ref packageName 
		equals: 'SomePackage'.
	self 
		assert: ref versionString
		equals: ''.
	self 
		assert: ref versionNumber
		equals: nil
]

{ #category : #tests }
CGOPackageVersionReferenceTest >> testCanCreateFromString [
	| ref |
	ref := 'SomePackage@1.2' asPackageVersionReference.
	self 
		assert: ref packageName 
		equals: 'SomePackage'.
	self 
		assert: ref versionString
		equals: '1.2.0'.
	self 
		assert: ref versionNumber
		equals: '1.2.0' asSemanticVersion
]

{ #category : #tests }
CGOPackageVersionReferenceTest >> testFetchFromCache [
	| fileRef packageVersion |
	fileRef := CGOPackageVersionCache packageDescriptionCache / pkgVersionReference asString asLowercase.
	fileRef writeStreamDo: [ :stream | stream nextPutAll: self packageVersionDescription ].
	packageVersion := pkgVersionReference fetchFromCache.
	fileRef delete.
	self assertIsExpectedPackageVersion: packageVersion
]

{ #category : #tests }
CGOPackageVersionReferenceTest >> testFetchFromRepositories [
	| packageVersion |
	packageVersion := pkgVersionReference fetchFromRepositories.
	self assertIsExpectedPackageVersion: packageVersion
]

{ #category : #tests }
CGOPackageVersionReferenceTest >> testPackageName [
	self 
		assert: pkgVersionReference packageName
		equals: 'Seaside-Core'
]

{ #category : #tests }
CGOPackageVersionReferenceTest >> testVersionNumber [
	self 
		assert: pkgVersionReference versionNumber
		equals: '3.1.0' asSemanticVersion
]

{ #category : #tests }
CGOPackageVersionReferenceTest >> testVersionString [
	self 
		assert: pkgVersionReference versionString
		equals: '3.1.0'
]
