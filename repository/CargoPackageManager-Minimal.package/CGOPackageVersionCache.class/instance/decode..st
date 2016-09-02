decoding
decode: aFileReference
	^ [ CGOPackageVersionReader fromStream: aFileReference readStream ]
		on: Error
		do: [ nil ]