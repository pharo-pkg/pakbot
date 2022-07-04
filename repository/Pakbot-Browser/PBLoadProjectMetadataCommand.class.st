"
This action only loads the project metedata into the registry.
"
Class {
	#name : #PBLoadProjectMetadataCommand,
	#superclass : #PBLoadProjectCommand,
	#category : #'Pakbot-Browser-Commands'
}

{ #category : #testing }
PBLoadProjectMetadataCommand class >> isAvailableFor: aProject [

	^ aProject isLoaded not
]

{ #category : #accessing }
PBLoadProjectMetadataCommand >> description [

	^ 'Will load the project metadata (description, list of packages, dependencies).
It will not load any package into the system but the metadata will be browsable through the system browser project view. From this project view, you will be able to load the project or part of it.'
]

{ #category : #executing }
PBLoadProjectMetadataCommand >> doExecute [

	PBPackageRegistry default
		registerProject: project.
		
	PBProjectCreated announceOnProject: project.
]

{ #category : #accessing }
PBLoadProjectMetadataCommand >> iconName [

	^ #haloView
]

{ #category : #accessing }
PBLoadProjectMetadataCommand >> name [

	^ 'Load the project metadata'
]
