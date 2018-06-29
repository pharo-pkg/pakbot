ston
stonOn: stonWriter
	stonWriter 
		writeObject: self
		streamMap: [ :dictionary |
			dictionary
				at: #url put: url asString;
				at: #version put: version. ]