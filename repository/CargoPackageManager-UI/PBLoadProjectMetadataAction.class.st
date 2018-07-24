Class {
	#name : #PBLoadProjectMetadataAction,
	#superclass : #PBLoadProjectAction,
	#category : #'CargoPackageManager-UI-Loading'
}

{ #category : #querying }
PBLoadProjectMetadataAction class >> isAvailableFor: aProject [
	^ aProject registry 
		ifNil: [ true ]
		ifNotNil: [ :registry | (registry isProjectInstalled: aProject) not ]
]

{ #category : #accessing }
PBLoadProjectMetadataAction >> description [
	^ 'Will load the project metadata (description, list of packages, dependencies).
It will not load any package into the system but the metadata will be browsable through the system browser project view. From this project view, you will be able to load the project or part of it.'
]

{ #category : #running }
PBLoadProjectMetadataAction >> execute [
	CGOPackageRegistry default 
		registerProject: project
]

{ #category : #accessing }
PBLoadProjectMetadataAction >> iconName [
	^ #haloView
]

{ #category : #accessing }
PBLoadProjectMetadataAction >> name [
	^ 'Load the project metadata'
]
