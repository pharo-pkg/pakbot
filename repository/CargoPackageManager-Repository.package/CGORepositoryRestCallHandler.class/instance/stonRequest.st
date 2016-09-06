response handling
stonRequest
	^ (self request contentType matches: ZnMimeType applicationSton)
		ifTrue: [ self fromStonString: self request contents ]
		ifFalse: [ self error: 'STON content expected' ]