"
I represent a Metacello Project using a ConfigurationOf and act as a Cargo project.

	self exampleConfiguration inspect
"
Class {
	#name : #PBMetacelloConfigurationProject,
	#superclass : #PBMetacelloProject,
	#category : #'Pakbot-Minimal-Metacello-Support'
}

{ #category : #example }
PBMetacelloConfigurationProject class >> exampleConfiguration [
	^ self 
		fromProjectDependency: PBMetacelloConfigurationProjectDependency example
]

{ #category : #loading }
PBMetacelloConfigurationProject >> basicLoad [
	Metacello new 
		repository: repository asString;
		configuration: name;
		version: version;
		load: packageNames.
]

{ #category : #accessing }
PBMetacelloConfigurationProject >> configurationClass [

	Smalltalk at: #ConfigurationOf , name ifPresent: [ :aClass | ^ aClass ].
	
	Gofer it 
		url: self repository;
		configurationOf: self name;
		load.
		
	^ Smalltalk at: #ConfigurationOf , name
]

{ #category : #accessing }
PBMetacelloConfigurationProject >> isConfiguration [
	^ true
]

{ #category : #'as yet unclassified' }
PBMetacelloConfigurationProject >> resolvedVersion [
	
	self version isSymbol ifFalse: [ ^ self version ].
	^ (self configurationClass project version: self version) versionString
]
