Extension { #name : #PBAssembly }

{ #category : #'*Pakbot-Browser' }
PBAssembly >> uiItemIn: anAssembly presenter: aPresenter [
	^ PBAssemblyUIItem forAssembly: self presenter: aPresenter
]
