ston
fromSton: stonReader
	"Decode the specific PackageVersion serialization format."
	| serializedPkgVersion |
	serializedPkgVersion := CGOSerializedPackageAssembly new fromSton: stonReader.
	serializedPkgVersion flushIn: self.