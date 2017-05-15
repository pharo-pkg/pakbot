accessing
selectedPackage
	^ packageTree selectedItem ifNotNil: [ :node | node content ]