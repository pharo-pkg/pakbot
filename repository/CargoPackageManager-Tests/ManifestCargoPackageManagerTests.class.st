"
I store metadata for this package. These meta data are used by other tools such as the SmalllintManifestChecker and the critics Browser
"
Class {
	#name : #ManifestCargoPackageManagerTests,
	#superclass : #PackageManifest,
	#category : 'CargoPackageManager-Tests'
}

{ #category : #'code-critics' }
ManifestCargoPackageManagerTests class >> ruleRBBadMessageRuleV1FalsePositive [
	^ #(#(#(#RGPackage #(#'CargoPackageManager-Tests')) #'2018-06-07T11:26:42.106635+02:00') )
]
