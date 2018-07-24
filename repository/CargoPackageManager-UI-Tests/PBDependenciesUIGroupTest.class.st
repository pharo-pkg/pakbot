Class {
	#name : #PBDependenciesUIGroupTest,
	#superclass : #PBAbstractCalypsoTest,
	#instVars : [
		'configurationProjectV1'
	],
	#category : #'CargoPackageManager-UI-Tests'
}

{ #category : #tests }
PBDependenciesUIGroupTest >> testProjectWithDependenciesShowsDependencieItem [

	| dep |
	project := registry newProjectNamed: 'TestProject'.
	configurationProjectV1 := PBMetacelloConfigurationProjectDependency
		name: 'CargoTestExample'
		repositoryUrl: 'http://smalltalkhub.com/mc/Pharo/CargoTestRepository/main'
		version: '1.0'.
	project addDependency: configurationProjectV1.

	self openBrowser.
	
	self expandNodeNamed: 'TestProject'.
	self expandNodeNamed: 'Dependencies'.
	dep := self findChildInBrowser: 'CargoTestExample'.

	self assert: dep isNotNil.
]

{ #category : #tests }
PBDependenciesUIGroupTest >> testProjectWithDependenciesShowsDependencies [

	| dependencies |
	project := registry newProjectNamed: 'TestProject'.
	configurationProjectV1 := PBMetacelloConfigurationProjectDependency
		name: 'CargoTestExample'
		repositoryUrl: 'http://smalltalkhub.com/mc/Pharo/CargoTestRepository/main'
		version: '1.0'.
	project addDependency: configurationProjectV1.

	self openBrowser.

	self expandNodeNamed: 'TestProject'.
	dependencies := self findChildInBrowser: 'Dependencies'.

	self assert: dependencies isNotNil.
]

{ #category : #tests }
PBDependenciesUIGroupTest >> testProjectWithoutDependenciesDoesNotShowDependencies [

	| dependencies |
	registry newProjectNamed: 'TestProject'.

	self openBrowser.
	self expandNodeNamed: 'TestProject'.
	dependencies := self findChildInBrowser: 'Dependencies'.

	self assert: dependencies isNil.
]
