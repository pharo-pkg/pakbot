Class {
	#name : #CGOProjectElement,
	#superclass : #CGOLoadableUnit,
	#instVars : [
		'project'
	],
	#category : #'CargoPackageManager-Model'
}

{ #category : #accessing }
CGOProjectElement >> project [
	^ project
]

{ #category : #accessing }
CGOProjectElement >> project: aCGOOngoingProject [ 
	project := aCGOOngoingProject
]
