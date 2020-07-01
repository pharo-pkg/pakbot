Class {
	#name : #PBPackageAnnouncementTest,
	#superclass : #PBAbstractTest,
	#instVars : [
		'project'
	],
	#category : #'CargoPackageManager-IntegrationTests'
}

{ #category : #tests }
PBPackageAnnouncementTest >> setUp [

	super setUp.
	testRegistry registerInSystem
]

{ #category : #tests }
PBPackageAnnouncementTest >> tearDown [

	self removePackageIfExists: 'Test-APackage'.
	self removePackageIfExists: 'Test-APackageNew'.

	super tearDown
]

{ #category : #tests }
PBPackageAnnouncementTest >> testPackageRemovedFromSystemKeptThePackageInTheProjectButNotInstalled [

	project := testRegistry newProjectNamed: 'Test'.
	project 
		repository: PBGitMemoryRepository new;
		createPackageNamed: 'Test-APackage'.
	
	'Test-APackage' asPackage removeFromSystem.
	
	self assert: (project hasPackageNamed: 'Test-APackage').
	self deny: (project packageNamed: 'Test-APackage') isInstalled
]

{ #category : #tests }
PBPackageAnnouncementTest >> testPackageRemovedFromSystemUpdateRegistry [

	project := testRegistry newProjectNamed: 'Test'.
	project 
		repository: PBGitMemoryRepository new;
		createPackageNamed: 'Test-APackage'.
	
	'Test-APackage' asPackage removeFromSystem.
	
	self deny: (testRegistry hasInstalledPackageNamed: 'Test::Test-APackage')
]

{ #category : #tests }
PBPackageAnnouncementTest >> testPackageRenamedUpdateProject [

	project := testRegistry newProjectNamed: 'Test'.
	project 
		repository: PBGitMemoryRepository new;
		createPackageNamed: 'Test-APackage'.
	
	'Test-APackage' asPackage renameTo: 'Test-APackageNew'.
	
	self assert: (project hasPackageNamed: 'Test-APackageNew').
	self deny: (project hasPackageNamed: 'Test-APackage').	
]

{ #category : #tests }
PBPackageAnnouncementTest >> testPackageRenamedUpdateRegistry [

	project := testRegistry newProjectNamed: 'Test'.
	project 
		repository: PBGitMemoryRepository new;
		createPackageNamed: 'Test-APackage'.
	
	'Test-APackage' asPackage renameTo: 'Test-APackageNew'.
	
	self deny: (testRegistry hasInstalledPackageNamed: 'Test::Test-APackage').
	self assert: (testRegistry hasInstalledPackageNamed: 'Test::Test-APackageNew')	
]
