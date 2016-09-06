response handling
stonResponse: data
	| entity |
	entity := ZnEntity 
				with: (self toSton: data)
				type: (ZnMimeType applicationSton).
	self response: (ZnResponse ok: entity)