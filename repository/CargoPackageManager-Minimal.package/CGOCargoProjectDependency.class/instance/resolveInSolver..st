solving
resolveInSolver: aCGOSolver 
	
	self isInstalled
		ifTrue: [ ^ project registry projectNamed: self name ].
	
	"If it is not installed, we need to go fetch it in the INTERNET"
	1halt.