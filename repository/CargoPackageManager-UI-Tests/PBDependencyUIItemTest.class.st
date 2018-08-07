Class {
	#name : #PBDependencyUIItemTest,
	#superclass : #PBAbstractCalypsoTest,
	#instVars : [
		'configurationProjectV1',
		'configurationProjectV2'
	],
	#category : #'CargoPackageManager-UI-Tests'
}

{ #category : #running }
PBDependencyUIItemTest >> setUp [
	super setUp.

	configurationProjectV1 := PBMetacelloConfigurationProjectDependency name: 'CargoTestExample' repositoryUrl: 'http://smalltalkhub.com/mc/Pharo/CargoTestRepository/main' version: '1.0'.
	configurationProjectV2 := PBMetacelloConfigurationProjectDependency name: 'CargoTestExample' repositoryUrl: 'http://smalltalkhub.com/mc/Pharo/CargoTestRepository/main' version: '2.0'	
]

{ #category : #tests }
PBDependencyUIItemTest >> testProjectWithInstalledDependencyShowsNormalIcon [

	| dependency |

	Metacello new
		configuration: 'CargoTestExample';
		repository: 'http://smalltalkhub.com/mc/Pharo/CargoTestRepository/main';
		version: '1.0';
		load.

	project := testRegistry newProjectNamed: 'TestProject'.
	project addDependency: configurationProjectV1.

	self openBrowser.

	self expandNodeNamed: 'TestProject'.
	self expandNodeNamed: 'Dependencies'.

	dependency := self findChildInBrowser: 'CargoTestExample'.

	self assert: dependency definitionMorph form equals: (self iconNamed: #package).
	self assert: dependency definitionMorph balloonText isNil.
	
]

{ #category : #tests }
PBDependencyUIItemTest >> testProjectWithNotInstalledDependencyIsShownWithError [

	| dependency |
	project := testRegistry newProjectNamed: 'TestProject'.
	project addDependency: configurationProjectV1.

	self openBrowser.

	self expandNodeNamed: 'TestProject'.
	self expandNodeNamed: 'Dependencies'.

	dependency := self findChildInBrowser: 'CargoTestExample'.

	self assert: dependency definitionMorph form equals: (self iconNamed: #error).
	self assert: dependency definitionMorph balloonText isNotNil.
	
]

{ #category : #tests }
PBDependencyUIItemTest >> testProjectWithNotInstalledDependencyIsShownWithWarning [

	| dependency |
	
	Metacello new
		configuration: 'CargoTestExample';
		repository: 'http://smalltalkhub.com/mc/Pharo/CargoTestRepository/main';
		version: '1.0';
		load.	
	
	project := testRegistry newProjectNamed: 'TestProject'.
	project addDependency: configurationProjectV2.

	self openBrowser.

	self expandNodeNamed: 'TestProject'.
	self expandNodeNamed: 'Dependencies'.

	dependency := self findChildInBrowser: 'CargoTestExample'.

	self assert: dependency definitionMorph form equals: (self iconNamed: #error).
	self assert: dependency definitionMorph balloonText isNotNil.
	
]
