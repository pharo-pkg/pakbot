initialization - private
provisionsFrom: aDictionary
	^ aDictionary 
		at: #provisions 
		ifPresent: [ :aProvisionList | aProvisionList ]
		ifAbsent: #()
