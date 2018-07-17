"
I represent a dependency to a project managed by a Metacello BaselineOf.
"
Class {
	#name : #PBMetacelloBaselineProjectDependency,
	#superclass : #PBMetacelloProjectDependency,
	#category : 'CargoPackageManager-Minimal-Dependencies'
}

{ #category : #example }
PBMetacelloBaselineProjectDependency class >> example [
	^ self
		name: 'PakbotTestExample'
		repositoryUrl: 'git://git@github.com/pharo-pkg/PakbotTestExample.git'
		version: '0866472ddded2a8fc36d3bae23f01aecfe947dc7'
]

{ #category : #accessing }
PBMetacelloBaselineProjectDependency class >> projectClass [
	^ PBMetacelloBaselineProject 
]

{ #category : #'ston-core' }
PBMetacelloBaselineProjectDependency class >> stonName [
	^ #MetacelloBaselineProject
]

{ #category : #'querying - installed' }
PBMetacelloBaselineProjectDependency >> isInstalledInMetacello [
	| baseline |
	baseline := MetacelloProjectRegistration registry baselineRegistry 
		at: #BaselineOf , name 
		ifAbsent: [ ^ false ].
	^ baseline currentVersionString = version 
		and: [ baseline loadedInImage 
			and: [ baseline baselineProjectSpec loads isEmpty ] ]
]

{ #category : #ston }
PBMetacelloBaselineProjectDependency >> stonOn: stonWriter [
	stonWriter writeMap: (OrderedDictionary 
		with: #baseline -> name
		with:	#url -> url asString
		with: 	#version -> version)
]
