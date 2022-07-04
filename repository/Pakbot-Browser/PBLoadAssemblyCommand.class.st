"
Meta-action that represent the loading of a particular project assembly.
I'm dynamically collected by `PBLoadProjectPresenter`.
"
Class {
	#name : #PBLoadAssemblyCommand,
	#superclass : #PBLoadProjectCommand,
	#instVars : [
		'assembly'
	],
	#category : #'Pakbot-Browser-Commands'
}

{ #category : #testing }
PBLoadAssemblyCommand class >> isAvailableFor: aProject [

	^ aProject assemblies isNotEmpty
]

{ #category : #accessing }
PBLoadAssemblyCommand >> assembly: anAssembly [ 

	assembly := anAssembly
]

{ #category : #accessing }
PBLoadAssemblyCommand >> description [

	^ 'Loads the packages of this assembly and their dependencies.
Packages not belonging to this asembly will not be loaded.'
]

{ #category : #executing }
PBLoadAssemblyCommand >> doExecute [

	assembly load
]

{ #category : #accessing }
PBLoadAssemblyCommand >> iconName [

	^ #group
]

{ #category : #accessing }
PBLoadAssemblyCommand >> name [

	^ 'Load {1} assembly' format: { assembly name }
]
