"
I represent a Metacello Project using a BaselineOf and act as a Cargo project.

	self exampleConfiguration inspect
"
Class {
	#name : #PBMetacelloBaselineProject,
	#superclass : #PBMetacelloProject,
	#instVars : [
		'subdirectory'
	],
	#category : #'CargoPackageManager-Minimal-Model'
}

{ #category : #example }
PBMetacelloBaselineProject class >> exampleConfiguration [
	^ self 
		fromProjectDependency: PBMetacelloBaselineProjectDependency example
]

{ #category : #loading }
PBMetacelloBaselineProject >> basicLoad [

	| url metacelloUrlWithVersionAndSubdirectory |
	url := repository asZnUrl.
	
	metacelloUrlWithVersionAndSubdirectory := url scheme , '://' , url host, '/', url segments first , ':', version.
	subdirectory ifNotEmpty: [ metacelloUrlWithVersionAndSubdirectory := metacelloUrlWithVersionAndSubdirectory , '/' , subdirectory ].

	Metacello new 
		repository: metacelloUrlWithVersionAndSubdirectory;
		baseline: name;
		load: packageNames asArray.
]

{ #category : #initialization }
PBMetacelloBaselineProject >> initialize [
	super initialize.
	subdirectory := ''
]

{ #category : #accessing }
PBMetacelloBaselineProject >> isConfiguration [
	^ true
]
