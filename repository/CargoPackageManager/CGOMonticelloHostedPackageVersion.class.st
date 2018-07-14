"
I represent a package version containing source code hosted on a Monticello server.

- versionString is the string identifying the package version for Monticello, i.e. author-branch-number
"
Class {
	#name : #CGOMonticelloHostedPackageVersion,
	#superclass : #CGOSourcePackageVersion,
	#instVars : [
		'versionString'
	],
	#category : 'CargoPackageManager-Loading'
}

{ #category : #example }
CGOMonticelloHostedPackageVersion class >> cargoSmalltalkHubReposiotry [ 
	<script>
	^ self
		repositoryUrl: 'http://smalltalkhub.com/mc/demarey/CargoPackageManager/main'
		packageName: 'CargoPackageManager-Minimal'
		versionString: 'ChristopheDemarey.21'
]

{ #category : #'instance creation' }
CGOMonticelloHostedPackageVersion class >> repositoryUrl: aStringOrUrl packageName: aString versionString: aVersionString [
	^ self basicNew 
		repositoryUrl: aStringOrUrl asUrl packageName: aString versionString: aVersionString;
		yourself
]

{ #category : #accessing }
CGOMonticelloHostedPackageVersion >> mcVersion [
	repository ifNil: [ MCRepositoryError signal: 'no source repository defined for ', self printString ].
	^ repository mcVersionFor: packageName , '-' , versionString
]

{ #category : #initialization }
CGOMonticelloHostedPackageVersion >> repositoryUrl: aStringOrUrl packageName: aString versionString: aVersionString [
	repository := CGOMonticelloRepository repositoryUrl: aStringOrUrl.
	packageName := aString asSymbol.
	versionString := aVersionString
]

{ #category : #saving }
CGOMonticelloHostedPackageVersion >> saveNewVersion: aSemanticVersion [
	| mcRepository |
	mcRepository := repository mcRepository.
	self workingCopy
		newVersionWithName: (self workingCopy uniqueVersionNameIn: mcRepository)
		message: 'Publication of version ' , aSemanticVersion
		in: mcRepository.
	self flag: 'TODO: update ongoing package version with the new generated package versionString'
]

{ #category : #saving }
CGOMonticelloHostedPackageVersion >> workingCopy [
	^ MCWorkingCopy allManagers 
		detect: [ :wc | wc packageName = packageName ]
		ifNone: [ CGOWorkingCopyNotFound signalFor: self ]
]
