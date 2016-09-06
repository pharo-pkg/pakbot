response handling
created: uri
	^ (super created: uri)
		entity: (ZnEntity 
				with: (self toSton: uri)
				type: ZnMimeType applicationSton);
		yourself