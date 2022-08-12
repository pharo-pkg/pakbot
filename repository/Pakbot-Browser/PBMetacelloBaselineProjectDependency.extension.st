Extension { #name : #PBMetacelloBaselineProjectDependency }

{ #category : #'*Pakbot-Browser' }
PBMetacelloBaselineProjectDependency >> iconName [

	^ #komitterSmalltalkhubRemote
]

{ #category : #'*Pakbot-Browser' }
PBMetacelloBaselineProjectDependency >> newEditPanel [
	
	^ PBMetacelloBaselineDependencyPresenter on: self
]
