"
I act as a fake project declaring dependencies for one or many project that have been asked to be installed.
It allows to use the same dependency conflict mechanism for top level project conflicts.
"
Class {
	#name : #PBProjectToInstall,
	#superclass : #Object,
	#instVars : [
		'dependencies'
	],
	#category : #'Pakbot-Minimal-Model'
}

{ #category : #'instance creation' }
PBProjectToInstall class >> withProjects: aListOfProjects [ 
	
	^ self new
		projects: aListOfProjects;
		yourself
]

{ #category : #accessing }
PBProjectToInstall >> dependencies [
	
	^ dependencies
]

{ #category : #initialization }
PBProjectToInstall >> projects: aListOfProjects [
 
	dependencies := aListOfProjects collect: [ :project | 
		project asFetchedPakbotProjectDependencyFor: self ].
]
