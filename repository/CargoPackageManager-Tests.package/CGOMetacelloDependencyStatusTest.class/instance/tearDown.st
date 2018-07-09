running
tearDown
	
	^ (#JSON asPackageIfAbsent: [ nil ]) ifNotNil: #removeFromSystem.