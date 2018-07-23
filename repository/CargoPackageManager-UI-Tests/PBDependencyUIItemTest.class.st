Class {
	#name : #PBDependencyUIItemTest,
	#superclass : #PBAbstractCalypsoTest,
	#instVars : [
		'configurationProjectV1'
	],
	#category : #'CargoPackageManager-UI-Tests'
}

{ #category : #running }
PBDependencyUIItemTest >> setUp [
	super setUp.

	configurationProjectV1 := PBMetacelloConfigurationProjectDependency name: 'CargoTestExample' repositoryUrl: 'http://smalltalkhub.com/mc/Pharo/CargoTestRepository/main' version: '1.0'
]

{ #category : #tests }
PBDependencyUIItemTest >> testProjectWithNotInstalledDependencyIsShownWithError [

	| dependency |
	project := registry newProjectNamed: 'TestProject'.
	project addDependency: configurationProjectV1.

	self openBrowser.

	self expandNodeNamed: 'TestProject'.
	self expandNodeNamed: 'Dependencies'.

	dependency := self findChildInBrowser: 'CargoTestExample'.

	self assert: dependency definitionMorph form = (self iconNamed: #error).
	self assert: dependency definitionMorph balloonText isNotNil.
]
