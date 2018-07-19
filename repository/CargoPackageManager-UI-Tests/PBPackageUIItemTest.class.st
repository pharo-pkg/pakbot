Class {
	#name : #PBPackageUIItemTest,
	#superclass : #PBAbstractCalypsoTest,
	#instVars : [
		'loadedPackage',
		'notLoadedPackage'
	],
	#category : #'CargoPackageManager-UI-Tests'
}

{ #category : #running }
PBPackageUIItemTest >> setUp [
	super setUp.
	
	project := registry newProjectNamed: 'TestProject'.
	loadedPackage := project createNewPackageNamed: 'TestProject-Loaded'.
	notLoadedPackage := project newNotLoadedPackage: 'TestProject-NotLoaded'.	
]

{ #category : #tests }
PBPackageUIItemTest >> testAProjectShowsBothLoadedAndNotLoadedPackages [

	| projectUI loadedUI notLoadedUI |

	projectUI := self findProject: 'TestProject'.
	loadedUI := self findPackage: 'TestProject-Loaded'.
	notLoadedUI := self findPackage: 'TestProject-NotLoaded'.

	self deny: projectUI items isEmpty.	
	self assert: projectUI items size equals: 2.

	self assert: loadedUI isNotNil.
	self assert: notLoadedUI isNotNil.	
]

{ #category : #tests }
PBPackageUIItemTest >> testLoadedPackageHasCorrectCommands [

	| packageUI commands |
	packageUI := self findPackage: 'TestProject-Loaded'.	
	commands := self commandsOfItem: packageUI.

	self assertCommands: commands includes: PBRemovePackageFromProjectCommand.
	self assertCommands: commands notIncludes: PBLoadPackageCommand


]

{ #category : #tests }
PBPackageUIItemTest >> testNotLoadedPackageHasCorrectCommands [

	| packageUI commands |
	packageUI := self findPackage: 'TestProject-NotLoaded'.	
	commands := self commandsOfItem: packageUI.

	self assertCommands: commands includes: PBRemovePackageFromProjectCommand.
	self assertCommands: commands includes: PBLoadPackageCommand


]

{ #category : #tests }
PBPackageUIItemTest >> testPackagesKnowsIfTheyAreInstalled [

	| loadedUI notLoadedUI |

	loadedUI := self findPackage: 'TestProject-Loaded'.
	notLoadedUI := self findPackage: 'TestProject-NotLoaded'.

	self deny: notLoadedUI isInstalled.
	self assert: loadedUI isInstalled.	
]
