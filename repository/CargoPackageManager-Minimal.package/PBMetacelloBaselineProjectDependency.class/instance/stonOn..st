ston
stonOn: stonWriter
	stonWriter 
		writeObject: self
		streamMap: [ :dictionary |
			dictionary
				at: #baseline put: name;
				at: #url put: url asString;
				at: #version put: version. ]