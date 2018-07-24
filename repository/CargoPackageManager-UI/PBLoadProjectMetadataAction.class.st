Class {
	#name : #PBLoadProjectMetadataAction,
	#superclass : #PBLoadProjectAction,
	#category : #'CargoPackageManager-UI-Loading'
}

{ #category : #querying }
PBLoadProjectMetadataAction class >> isAvailableFor: aProject [
	^ false
]
