Class {
	#name : #PBPackageRegistryTest,
	#superclass : #PBTest,
	#category : #'Pakbot-Tests-Model'
}

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
PBPackageRegistryTest >> testPackageIsInstalledWhenPackageUnitIsAdded [
	| project unit organizer |
	project := PBProjectVersion example.
	unit := project packageUnits anyOne.
	
	organizer := RPackageOrganizer new.
	RPackage 
		withOrganizer: organizer do: [ organizer registerPackageNamed: unit name ].
	registry systemPackageOrganizer: organizer.
	
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
PBPackageRegistryTest >> testProjectfAlreadyRegisteredAndFullyLoadedDoesNotRaiseAlreadyRegistered [
	registry registerProject: PBMetacelloBaselineProject example.
	
	self 
		shouldnt: [ registry registerProject: PBMetacelloBaselineProject example ]
		raise: PBPackageAlreadyRegistered.
	
	self 
		assert: registry registeredProjects size 
		equals: 1.
]

{ #category : #tests }
PBPackageRegistryTest >> testProjectfAlreadyRegisteredButNotLoadedDoesNotRaiseAlreadyRegisteredWhenLoading [
	| project |
	project := PBProjectVersion example.
	registry registerProject: project.
	
	self 
		shouldnt: [ registry registerProject: PBProjectVersion example ]
		raise: PBPackageAlreadyRegistered.
	
	self 
		assert: registry registeredProjects size 
		equals: 1.
]

{ #category : #tests }
PBPackageRegistryTest >> testProjectfAlreadyRegisteredButNotLoadedMetacelloProjectDoesNotRaiseAlreadyRegisteredWhenLoading [
	| project |
	project := PBMetacelloBaselineProject example.
	project loadedPackages: #(). 
	registry registerProject: project.
	
	self 
		shouldnt: [ registry registerProject: PBMetacelloBaselineProject example ]
		raise: PBPackageAlreadyRegistered.
	
	self 
		assert: registry registeredProjects size 
		equals: 1.
]

{ #category : #tests }
PBPackageRegistryTest >> testProjectfAlreadyRegisteredButPartiallyLoadedDoesNotRaiseAlreadyRegisteredIfHavingNewPackageToLoad [
	| project |
	project := PBMetacelloBaselineProject example.
	project loadedPackages: #('A'). 
	registry registerProject: project.
	
	self 
		shouldnt: [ registry registerProject: PBMetacelloBaselineProject example ]
		raise: PBPackageAlreadyRegistered.
	
	self 
		assert: registry registeredProjects size 
		equals: 1.
]
