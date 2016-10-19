decoding
decode: aFileReference
	^ [ STON fromStream: aFileReference readStream ]
		on: Error
		do: [ nil ]