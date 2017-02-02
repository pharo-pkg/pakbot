accessing
project
	^ [ self projectFromRegistry ]
		on: CGOPackageNotFoundError 
		do: [ self projectFromSCM ]