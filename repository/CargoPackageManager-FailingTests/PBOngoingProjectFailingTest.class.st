Class {
	#name : #PBOngoingProjectFailingTest,
	#superclass : #CGOOngoingProjectTest,
	#instVars : [
		'protocol'
	],
	#category : #'CargoPackageManager-FailingTests-Model'
}

{ #category : #running }
PBOngoingProjectFailingTest >> testAddingDependencyPerformAnnouncement [
	| announced subscription |

	[ 	announced := false.
		subscription := SystemAnnouncer uniqueInstance
			when: CGODependenciesChanged
			do: [ :ann | 
				ann project = ongoingProject
					ifTrue: [ announced := true ] ].
		ongoingProject
			addDependency: (PBPakbotProjectDependency named: 'AnotherProject' version: '=1.0.0').
		self assert: announced 
	] ensure: [ SystemAnnouncer uniqueInstance removeSubscription: subscription ]
]

{ #category : #tests }
PBOngoingProjectFailingTest >> testCanGetProjectFromSCM [
	| projectSourceRepositoryMock project |
	projectSourceRepositoryMock := protocol mock: 'projectSourceRepositoryMock'.
	protocol describe
		allow: projectSourceRepositoryMock recv: #projectMetadataStonString;
		=> (STON toStringPretty: PBProject example asVcsSerializedCargoProject).
	project := PBProject fromRepository: projectSourceRepositoryMock.
	registry reset.
	
	self
		assert: project 
		equals: PBProject example
]

{ #category : #tests }
PBOngoingProjectFailingTest >> testCanPublishAProject [
	| published |
	ongoingProject publish.
	
	self 
		assert: testPackageRepository packageNames size
		equals: 1.
	published := testPackageRepository 
		fetch: ongoingProject packageName
		version: ongoingProject version.
	self 
		assert: published class
		equals: CGOProject.
	self 
		assertCollection: published packageUnitNames
		hasSameElements: #(#Package1 #Package2)
]

{ #category : #tests }
PBOngoingProjectFailingTest >> testCanPublishAProjectAndItsPackages [
	| packages |
	ongoingProject assemblies: { CGOOngoingPackageAssembly for: #AllPackages in: ongoingProject name }.
	
	ongoingProject publishAll.
	
	packages := testPackageRepository packageNames.
	self 
		assert: packages size
		equals: 4.
		
	self 
		assertCollection: packages
		hasSameElements: #(myproject package1 package2 allpackages)
]
