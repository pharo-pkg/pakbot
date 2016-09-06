tests
testDeserializeDependenciesIn
	| serializedPkgVersion pkgVersion |
	serializedPkgVersion := CGOSerializedPackageUnit new
		instVarNamed: 'dependencies' put: {#'Grease-Core'->#('=1.1.5') . #'Seaside-Core-Platform'->#('=3.1.0')};
		yourself.
	pkgVersion := CGOPackageUnit new.
	serializedPkgVersion deserializeDependenciesIn: pkgVersion.
	self
		assert: pkgVersion dependencies class
		equals: Array.
	self
		assert: (pkgVersion dependencies at: 1) asString
		equals: 'Grease-Core (=1.1.5)'.
	self
		assert: (pkgVersion dependencies at: 2) asString
		equals: 'Seaside-Core-Platform (=3.1.0)'.