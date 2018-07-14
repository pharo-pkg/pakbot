"
Error raised ... when a version is not found!
"
Class {
	#name : #CGOPackageVersionNotFoundError,
	#superclass : #CGOPackageManagerError,
	#instVars : [
		'packageName',
		'versionNumber'
	],
	#category : 'CargoPackageManager-Minimal-Model'
}

{ #category : #'instance-creation' }
CGOPackageVersionNotFoundError class >> package: packageName version: versionNumber [

	^ self new
		package: packageName;
		version: versionNumber;
		signal
]

{ #category : #accessing }
CGOPackageVersionNotFoundError >> package: aPackageName [

	packageName := aPackageName
]

{ #category : #signaling }
CGOPackageVersionNotFoundError >> signal [

	versionNumber ifNotNil: [ 
		self messageText: 'Cannot find package: ' , packageName asString, ' version: ', versionNumber asString ].
	(versionNumber isNil and: [ packageName notNil ]) ifTrue: [
		self messageText: 'Cannot find package: ', packageName ].
	
	super signal.
]

{ #category : #accessing }
CGOPackageVersionNotFoundError >> version: aVersionNumber [

	versionNumber := aVersionNumber
]
