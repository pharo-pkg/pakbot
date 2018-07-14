"
I store metadata for this package. These meta data are used by other tools such as the SmalllintManifestChecker and the critics Browser
"
Class {
	#name : #ManifestCargoPackageManagerMinimal,
	#superclass : #PackageManifest,
	#category : 'CargoPackageManager-Minimal'
}

{ #category : #'meta-data - dependency analyser' }
ManifestCargoPackageManagerMinimal class >> manuallyResolvedDependencies [
	^ #(#'FileSystem-Core' #'System-Support' #UIManager #'Collections-Abstract' #'Regex-Core')
]

{ #category : #'meta-data' }
ManifestCargoPackageManagerMinimal class >> packageName [
	^ #'CargoPackageManager-Minimal'
]
