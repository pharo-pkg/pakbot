Class {
	#name : #PBPackageRegistryTest,
	#superclass : #TestCase,
	#instVars : [
		'registry'
	],
	#category : #'CargoPackageManager-Tests-Model'
}

{ #category : #initialization }
PBPackageRegistryTest >> setUp [
	registry := PBPackageRegistry new.
]

{ #category : #tests }
PBPackageRegistryTest >> testCanDetectAMetacelloBaselineProjectIsAlreadyInstalled [
	"Pakbot can automatically convert a Metacello baseline to a Pakbot Project.
	When loading a Metacello baseline, the corresponding PBMetacelloBaselineProject is registered as a Pakbot project.
	This project must answer if it is already installed"
	
	| project |
	project := PBMetacelloBaselineProject example.
	registry registerProject: project.
	
	self 
		assert: project isInstalled
		description: 'Cannot detect if a Metacello Baseline Project is already installed!'
]

{ #category : #tests }
PBPackageRegistryTest >> testPackageRegisteredWhenPackageUnitIsAdded [
	| project unit |
	project := PBProjectVersion example.
	unit := project packageUnits anyOne.
	
	registry register: unit.
	
	self 
		assert: registry installedPackages size
		equals: 1.
]

{ #category : #tests }
PBPackageRegistryTest >> testProjectCannotBeRegisteredIfAlreadyRegisteredWithDifferentVersionOrRepository [
	| project |
	registry registerProject:  PBProjectVersion example.
	project := PBProjectVersion example.
	project version: '1.1'.
	
	self 
		should: [ registry registerProject: project ]
		raise: PBPackageAlreadyRegistered.
	
	self 
		assert: registry registeredProjects size 
		equals: 1.
]

{ #category : #tests }
PBPackageRegistryTest >> testProjectRegisteredWhenPackageUnitIsAdded [
	| project unit |
	project := PBProjectVersion example.
	unit := project packageUnits anyOne.
	
	registry register: unit.
	
	self 
		assert: registry registeredProjects size
		equals: 1.
]

{ #category : #tests }
PBPackageRegistryTest >> testProjectStillRegisteredWhenPackageUnitIsUnregisteredAndSomeOfItsPackageStillInstalled [
	| project unit |
	project := PBProjectVersion example.
	project 
		registry: registry;
		repository: PBGitMemoryRepository new.
	unit := project packageUnits anyOne.
	registry register: unit.
	project importPackageNamed: #Unit2. "registers #Unit2"
	
	registry unregister: unit.
	
	self 
		assert: registry registeredProjects size 
		equals: 1
]

{ #category : #tests }
PBPackageRegistryTest >> testProjectUnregisteredWhenPackageUnitIsUnregistered [
	| project unit |
	project := PBProjectVersion example.
	unit := project packageUnits anyOne.
	registry register: unit.
	
	registry unregister: unit.
	
	self 
		assert: registry registeredProjects isEmpty.
]

{ #category : #tests }
PBPackageRegistryTest >> testProjectfAlreadyRegisteredDoesNotRaiseAlreadyRegisteredIfSameVersionAndSameRepository [
	| project |
	project := PBProjectVersion example.
	registry registerProject: project.
	
	self 
		shouldnt: [ registry registerProject: project ]
		raise: PBPackageAlreadyRegistered.
	
	self 
		assert: registry registeredProjects size 
		equals: 1.
]
