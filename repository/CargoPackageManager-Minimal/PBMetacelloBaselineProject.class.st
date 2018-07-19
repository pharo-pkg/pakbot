"
I represent a Metacello Project using a BaselineOf and act as a Cargo project.

	self exampleConfiguration inspect
"
Class {
	#name : #PBMetacelloBaselineProject,
	#superclass : #PBMetacelloProject,
	#category : 'CargoPackageManager-Minimal-Model'
}

{ #category : #example }
PBMetacelloBaselineProject class >> exampleConfiguration [
	^ self 
		fromProjectDependency: PBMetacelloBaselineProjectDependency example
]

{ #category : #loading }
PBMetacelloBaselineProject >> basicLoad [
	Metacello new 
		repository: repository asString;
		configuration: name;
		version: version;
		load: packageNames.
]

{ #category : #accessing }
PBMetacelloBaselineProject >> isConfiguration [
	^ true
]
