Extension { #name : #ButtonPresenter }

{ #category : #'*CargoPackageManager-UI-Tests' }
ButtonPresenter >> click [ 

	"I emulate the click from the presenter point of view.
	Of course if the button is disabled, I do nothing, like in real life!!
	If you want to emulate other stuff use performAction"
	
	self isEnabled ifFalse: [ ^ self ].
	^ self performAction
]
