"
I'm in charge of providing instances of Package: existing ones if present, or creating new ones if needed
"
Class {
	#name : #CGOPackageProvider,
	#superclass : #Object,
	#instVars : [
		'providerStrategy'
	],
	#classVars : [
		'Default'
	],
	#category : 'CargoPackageManager-Minimal-Model'
}

{ #category : #accessing }
CGOPackageProvider class >> default [
	^ Default ifNil: [ Default := self new ]
]

{ #category : #accessing }
CGOPackageProvider class >> resetDefault [
	Default := nil
]

{ #category : #initialization }
CGOPackageProvider >> initialize [
	super initialize.
	providerStrategy := CGOInImagePackageProviderStrategy new
]

{ #category : #accessing }
CGOPackageProvider >> packageNamed: aName [
	^ providerStrategy packageNamed: aName
]

{ #category : #accessing }
CGOPackageProvider >> providerStrategy [
	^ providerStrategy
]

{ #category : #accessing }
CGOPackageProvider >> providerStrategy: anObject [
	providerStrategy := anObject
]

{ #category : #accessing }
CGOPackageProvider >> virtualPackageNamed: aName [
	^ providerStrategy virtualPackageNamed: aName
]
