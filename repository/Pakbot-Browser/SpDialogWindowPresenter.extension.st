Extension { #name : #SpDialogWindowPresenter }

{ #category : #'*Pakbot-Browser' }
SpDialogWindowPresenter >> cancelButton [
	
	^ buttons detect: [ :button | button label asLowercase = 'cancel'  ]
]

{ #category : #'*Pakbot-Browser' }
SpDialogWindowPresenter >> okButton [
	
	^ buttons detect: [ :button | button label asLowercase = 'ok'  ]
]
