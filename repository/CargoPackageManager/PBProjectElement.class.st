Class {
	#name : #PBProjectElement,
	#superclass : #PBLoadableUnit,
	#instVars : [
		'project'
	],
	#category : #'CargoPackageManager-Model'
}

{ #category : #accessing }
PBProjectElement >> project [
	^ project
]

{ #category : #accessing }
PBProjectElement >> project: aCGOOngoingProject [ 
	project := aCGOOngoingProject
]
