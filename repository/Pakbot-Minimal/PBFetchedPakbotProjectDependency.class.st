"
I am a dependency on a project that has already been fetched.
By so, wehn trying to resolve me, I just return the already fetched project.
"
Class {
	#name : #PBFetchedPakbotProjectDependency,
	#superclass : #PBPakbotProjectDependency,
	#instVars : [
		'dependencyProject'
	],
	#category : #'Pakbot-Minimal-Dependencies'
}

{ #category : #'instance creation' }
PBFetchedPakbotProjectDependency class >> for: aPBProjectVersion fetchedDependency: fetchedProject [

	^ self new
		project: aPBProjectVersion;
		dependencyProject: fetchedProject;
		yourself
]

{ #category : #accessing }
PBFetchedPakbotProjectDependency >> dependencyProject [

	^ dependencyProject
]

{ #category : #accessing }
PBFetchedPakbotProjectDependency >> dependencyProject: aPBProjectVersion [ 

	dependencyProject := aPBProjectVersion.
	name := dependencyProject name.
]

{ #category : #displaying }
PBFetchedPakbotProjectDependency >> displayStringOn: aStream [
	
	aStream << self printString
]

{ #category : #solving }
PBFetchedPakbotProjectDependency >> resolveIn: aPBResolvedProject solver: aPBSolver [

	^ aPBResolvedProject addResolvedDependency: 
		(PBResolvedDependency
			 onDependency: self
			 resolution: (self resolvedProjectWithSolver: aPBSolver))
]

{ #category : #private }
PBFetchedPakbotProjectDependency >> resolvedProjectWithSolver: aPBSolver [
	
	^ aPBSolver solveProject: dependencyProject loads: self packagesToLoad
]
