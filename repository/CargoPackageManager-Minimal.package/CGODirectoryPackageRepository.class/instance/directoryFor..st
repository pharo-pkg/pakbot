private
directoryFor: aPackageVersion
	^ (aPackageVersion isVirtual
		ifTrue: [ self virtualDirectory ]
		ifFalse: [ self rootDirectory ]) / aPackageVersion packageName asLowercase