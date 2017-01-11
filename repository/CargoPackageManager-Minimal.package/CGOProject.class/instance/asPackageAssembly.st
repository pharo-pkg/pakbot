converting
asPackageAssembly
	"Will create a Package Assembly with all project package units as parts"
	^ CGOPackageVersion newFrom: 
		( Dictionary
			with: #package -> name
			with: #version -> version
			with: #parts -> unitNames )