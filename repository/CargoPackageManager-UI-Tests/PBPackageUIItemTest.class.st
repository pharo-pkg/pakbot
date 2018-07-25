Class {
	#name : #PBPackageUIItemTest,
	#superclass : #PBAbstractCalypsoTest,
	#instVars : [
		'loadedPackage',
		'notLoadedPackage'
	],
	#category : #'CargoPackageManager-UI-Tests'
}

{ #category : #utils }
PBPackageUIItemTest >> contextClass [
	^ PBPackageContextOfFullBrowser 
]

{ #category : #running }
PBPackageUIItemTest >> setUp [
	super setUp.

	project := registry newProjectNamed: 'TestProject'.
	loadedPackage := project createPackageNamed: 'TestProject-Loaded'.
	notLoadedPackage := project newNotLoadedPackage: 'TestProject-NotLoaded'.	
]

{ #category : #tests }
PBPackageUIItemTest >> tearDown [

	('TestProject-Core' asPackageIfAbsent: [ nil ]) ifNotNil: #removeFromSystem.
	super tearDown.
]

{ #category : #tests }
PBPackageUIItemTest >> testAProjectShowsBothLoadedAndNotLoadedPackages [

	| projectUI loadedUI notLoadedUI |

	projectUI := self findProject: 'TestProject'.
	loadedUI := self findUIItem: 'TestProject-Loaded'.
	notLoadedUI := self findUIItem: 'TestProject-NotLoaded'.

	self deny: projectUI items isEmpty.	
	self assert: projectUI items size equals: 2.

	self assert: loadedUI isNotNil.
	self assert: notLoadedUI isNotNil.	
]

{ #category : #tests }
PBPackageUIItemTest >> testAProjectShowsCorrectStatusIcon [

	| loadedUI notLoadedUI |

	self openBrowser.
	self expandNodeNamed: 'TestProject'.
	loadedUI := self findChildInBrowser: 'TestProject-Loaded'.
	notLoadedUI := self findChildInBrowser: 'TestProject-NotLoaded'.
	
	self assert: loadedUI definitionMorph class equals: ImageMorph.
	self assert: notLoadedUI definitionMorph class equals: AlphaImageMorph.
	self assert: notLoadedUI definitionMorph asAlphaImageMorph alpha equals: 0.6.

	self assert: loadedUI definitionMorph form equals: (Smalltalk ui theme iconNamed: #package).
	self assert: notLoadedUI definitionMorph form equals: (Smalltalk ui theme iconNamed: #package).

]

{ #category : #tests }
PBPackageUIItemTest >> testLoadedPackageHasCorrectCommands [

	| packageUI commands |
	packageUI := self findUIItem: 'TestProject-Loaded'.	
	self openBrowser.		
	commands := self commandsOfItem: packageUI.

	self assertCommands: commands includes: PBRemovePackageFromProjectCommand.
	self assertCommands: commands notIncludes: PBLoadPackageCommand


]

{ #category : #tests }
PBPackageUIItemTest >> testNotLoadedPackageHasCorrectCommands [

	| packageUI commands |
	packageUI := self findUIItem: 'TestProject-NotLoaded'.	
	self openBrowser.		
	commands := self commandsOfItem: packageUI.

	self assertCommands: commands includes: PBRemovePackageFromProjectCommand.
	self assertCommands: commands includes: PBLoadPackageCommand


]

{ #category : #tests }
PBPackageUIItemTest >> testPackagesKnowsIfTheyAreInstalled [

	| loadedUI notLoadedUI |

	loadedUI := self findUIItem: 'TestProject-Loaded'.
	notLoadedUI := self findUIItem: 'TestProject-NotLoaded'.

	self deny: notLoadedUI isInstalled.
	self assert: loadedUI isInstalled.	
]

{ #category : #tests }
PBPackageUIItemTest >> testRemovePackageFromProjectCommand [

	| pkg |
	
	project createPackageNamed: 'TestProject-Core'.

	self openBrowser.

	self expandNodeNamed: 'TestProject'.
	pkg := self findUIItem: 'TestProject-Core'.

	(self command: PBRemovePackageFromProjectCommand for: pkg) executeCommand. 
	
	self expandNodeNamed: 'TestProject'.
	self assert: (self findUIItem: 'TestProject-Core') isNil.
]
