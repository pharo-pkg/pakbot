Class {
	#name : #ManifestFooWithNoIgnored,
	#superclass : #PackageManifest,
	#category : 'CargoPackageManager-Tests-FooResource'
}

{ #category : #'meta-data' }
ManifestFooWithNoIgnored class >> description [
	^ 'I represent the manifest of a fake package. I''m used for test purposes.'
]

{ #category : #'meta-data' }
ManifestFooWithNoIgnored class >> file [
	^ 'Kernel-TheIntegrator.2292'
]

{ #category : #'meta-data - dependency analyser' }
ManifestFooWithNoIgnored class >> manuallyResolvedDependencies [
	^ #(#'System-Settings' #'System-Sources' #'System-Localization' #'AST-Core' #Transcript #Compression #'Regex-Core' #'FFI-Kernel' #'Random-Core' #'System-Platforms' #'Multilingual-TextConversion')
]

{ #category : #'meta-data' }
ManifestFooWithNoIgnored class >> packageName [
	^ #'CargoPackageManager-Tests-FooResource'
]

{ #category : #'meta-data' }
ManifestFooWithNoIgnored class >> version [
	^ '1.0'
]
