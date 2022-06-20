Extension { #name : #PBPackage }

{ #category : #'*Pakbot-Browser' }
PBPackage >> uiItemIn: anAssembly presenter: aPresenter [
	^ PBPackageUIItem forPackage: self presenter: aPresenter
]
