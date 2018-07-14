Extension { #name : #MCHttpRepository }

{ #category : #'*CargoPackageManager' }
MCHttpRepository >> stonOn: stonWriter [
	stonWriter writeString: self location
]
