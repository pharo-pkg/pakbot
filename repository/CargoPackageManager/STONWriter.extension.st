Extension { #name : #STONWriter }

{ #category : #'*CargoPackageManager' }
STONWriter >> writeShortList: collection [
	self with: collection do: [ 
		self encodeList: collection ]
]
