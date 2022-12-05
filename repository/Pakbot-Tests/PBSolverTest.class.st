Class {
	#name : #PBSolverTest,
	#superclass : #PBTest,
	#category : #'Pakbot-Tests-Solver'
}

{ #category : #'tests - data' }
PBSolverTest >> noDependenciesProject [

	^ (registry newProjectNamed: #NoDependencies)
		version: '17';
		yourself.	
]

{ #category : #solving }
PBSolverTest >> solveProject: aProject [

	^ registry newSolver solveProject: aProject 
]

{ #category : #tests }
PBSolverTest >> testNoConflictWhenAskingToInstallAPackageAlreadyInstalled [
	| noDepProject17 projectToInstall resolvedProject |

	noDepProject17 := self noDependenciesProject.
	projectToInstall := (PBProjectVersion named: noDepProject17 name)
		version: '17';
		registry: registry;
		yourself.
	
	resolvedProject := self solveProject: projectToInstall asProjectToInstallDependency.
	
	self deny: resolvedProject hasConflicts.
]

{ #category : #tests }
PBSolverTest >> testShouldGetDependencyConflictErrorWhenAskingToInstallAPackageAlreadyInstalledInADifferentVersion [
	| noDepProject17 projectToInstall resolvedProject |

	noDepProject17 := self noDependenciesProject.
	projectToInstall := (PBProjectVersion named: noDepProject17 name)
		version: '19';
		registry: registry;
		yourself.
	
	resolvedProject := self solveProject: projectToInstall asProjectToInstallDependency.
	
	self assert: resolvedProject hasConflicts.
]

{ #category : #tests }
PBSolverTest >> testShouldGetEmptyLoadInstructionsWhenAskingToInstallAPackageAlreadyInstalled [
	| resolution instructions |

	resolution := self solveProject: self noDependenciesProject.
	
	instructions := resolution loadInstructions groups.
	self assert: instructions size equals: 0.
]
