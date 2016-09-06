accessing
loadInstructionsFile
	| file|
	file := fs / 'grease-load-instructions.ston'.
	file writeStreamDo: [ :stream | stream nextPutAll: self loadInstructionsStonString ].
	^ file