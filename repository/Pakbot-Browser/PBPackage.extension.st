Extension { #name : #PBPackage }

{ #category : #'*Pakbot-Browser' }
PBPackage >> uiItemIn: anAssembly presenter: aPresenter [
	^ PBPackageReferenceUIItem forPackage: self in: anAssembly presenter: aPresenter
]
