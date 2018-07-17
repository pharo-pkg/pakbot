Class {
	#name : #CGOSemanticVersionTest,
	#superclass : #TestCase,
	#category : 'CargoPackageManager-Tests-Model'
}

{ #category : #helpers }
CGOSemanticVersionTest >> assertVersion: aSymbolicVersionString printStringEquals: aString [
	| version |
	
	version := SemanticVersion fromString: aSymbolicVersionString.
	self assert: version printString equals: aString.
]

{ #category : #helpers }
CGOSemanticVersionTest >> assertVersionFromString: aString major: major minor: minor patch: patch suffix: suffix [
	| version |
	
	version := SemanticVersion fromString: aString.
	self assert: version isNotNil.
	self assert: version major equals: major.
	self assert: version minor equals: minor.
	self assert: version patch equals: patch.
	self assert: version suffix equals: suffix.
]

{ #category : #helpers }
CGOSemanticVersionTest >> stonSerializationFor: aString [
	^ CGOPackageVersionWriterV1 toStringPretty: (SemanticVersion fromString: aString)
]

{ #category : #'tests-parsing' }
CGOSemanticVersionTest >> testExtractSuffixSuffixedVersionStringShouldReturnSuffix [
	
	self 
		assert: (SemanticVersion suffixFrom: '0-RC1')
		equals: '-RC1'
]

{ #category : #'tests-parsing' }
CGOSemanticVersionTest >> testPrintString [

	self assertVersion: '2' printStringEquals: '2.0.0'.
	self assertVersion: '1.2' printStringEquals: '1.2.0'.
	self assertVersion: '1.1.3' printStringEquals: '1.1.3'.
	self assertVersion: '1.1.3-RC1' printStringEquals: '1.1.3-RC1'
]

{ #category : #'tests-comparison' }
CGOSemanticVersionTest >> testVersionShouldBeGreaterThanVersionWithEqualMajorAndSmallerMinorNumber [

	self assert: self v11 > self v10.
	
	self assert: self v110 > self v101.
	self assert: self v111 > self v101.
]

{ #category : #'tests-comparison' }
CGOSemanticVersionTest >> testVersionShouldBeGreaterThanVersionWithEqualMajorEqualMinorAndSmallerPatchNumber [

	self assert: self v111 > self v100
]

{ #category : #'tests-comparison' }
CGOSemanticVersionTest >> testVersionShouldBeGreaterThanVersionWithSmallerMajorNumber [

	self assert: self v2 > self v1.
	
	self assert: self v21 > self v10.
	self assert: self v20 > self v11.
	
	self assert: self v210 > self v101.
	self assert: self v211 > self v100.
	
	self assert: self v201 > self v100.
	self assert: self v200 > self v101.
]

{ #category : #'tests-parsing' }
CGOSemanticVersionTest >> testVersionStringInvalidShouldFail [

	self should: [ SemanticVersion fromString: 'toto' ] raise: SemanticVersionFormatError
]

{ #category : #'tests-parsing' }
CGOSemanticVersionTest >> testVersionStringWithMajorNumberShouldOnlyHaveMajorVersionNumber [

	self assertVersionFromString: '2' major: 2 minor: 0 patch: 0 suffix: nil
]

{ #category : #'tests-parsing' }
CGOSemanticVersionTest >> testVersionStringWithMinorNumberShouldOnlyHaveMajorAndMinorVersionNumber [

	self assertVersionFromString: '1.2' major: 1 minor: 2 patch: 0 suffix: nil
]

{ #category : #'tests-parsing' }
CGOSemanticVersionTest >> testVersionStringWithMoreThanThreeComponentsShouldFail [

	self should:  [ SemanticVersion fromString: '1.2.3.4' ] raise: SemanticVersionFormatError
]

{ #category : #'tests-parsing' }
CGOSemanticVersionTest >> testVersionStringWithPatchNumberShouldOnlyHaveMajorAndMinorAndPatchVersionNumber [

	self assertVersionFromString: '1.1.3' major: 1 minor: 1 patch: 3 suffix: nil
]

{ #category : #'tests-parsing' }
CGOSemanticVersionTest >> testVersionStringWithSuffixButNoMinorNorPatchNumberShouldHaveSuffix [

	self assertVersionFromString: '1-RC1' major: 1 minor: 0 patch: 0 suffix: '-RC1'
]

{ #category : #'tests-parsing' }
CGOSemanticVersionTest >> testVersionStringWithSuffixButNoPatchNumberShouldHaveSuffix [

	self assertVersionFromString: '1.1-RC1' major: 1 minor: 1 patch: 0 suffix: '-RC1'
]

{ #category : #'tests-parsing' }
CGOSemanticVersionTest >> testVersionStringWithSuffixShouldHaveSuffix [

	self assertVersionFromString: '1.1.3-RC1' major: 1 minor: 1 patch: 3 suffix: '-RC1'
]

{ #category : #'tests-comparison' }
CGOSemanticVersionTest >> testVersionWithNoMinorNumberShouldHaveMinorNumberEqualsToZero [
	| v1 v2 |
	
	v1 := SemanticVersion fromString: '1'.
	v2 := SemanticVersion fromString: '1.0'.

	self assert: self v1 equals: self v10.
]

{ #category : #'tests-comparison' }
CGOSemanticVersionTest >> testVersionWithNoMinorNumberShouldHavePatchNumberEqualsToZero [

	self assert: self v1 equals: self v100.
]

{ #category : #'tests-comparison' }
CGOSemanticVersionTest >> testVersionWithNoPatchNumberShouldHavePatchNumberEqualsToZero [
	| v1 v2 |
	
	v1 := SemanticVersion fromString: '1.1'.
	v2 := SemanticVersion fromString: '1.1.0'.

	self assert: self v11 equals: self v110.
]

{ #category : #'tests-development versions' }
CGOSemanticVersionTest >> testVersionWithSuffixDevShouldBeADevelopmentVersion [
	
	self assert: (SemanticVersion fromString: '1.0-dev') isDevelopmentVersion
]

{ #category : #'tests-development versions' }
CGOSemanticVersionTest >> testVersionWithoutSuffixDevShouldNotBeADevelopmentVersion [
	
	self deny: (SemanticVersion fromString: '1.0-devv') isDevelopmentVersion
]

{ #category : #'tests-comparison' }
CGOSemanticVersionTest >> testVersionsWithDifferentMajorVersionNumberShouldBeDifferent [

	self deny: self v1 = self v2.
]

{ #category : #'tests-comparison' }
CGOSemanticVersionTest >> testVersionsWithDifferentMinorVersionNumberShouldBeDifferent [

	self deny: self v11 = self v12.
]

{ #category : #'tests-comparison' }
CGOSemanticVersionTest >> testVersionsWithDifferentPatchVersionNumberShouldBeDifferent [

	self deny: self v111 = self v112.
]

{ #category : #'tests-comparison' }
CGOSemanticVersionTest >> testVersionsWithEqualSemanticVersionsShouldBeEqual [

	self assert: self v123 equals: self v123.
]

{ #category : #'tests-comparison' }
CGOSemanticVersionTest >> testVersionsWithEqualSemanticVersionsWithNoMinorNumberShouldBeEqual [

	self assert: self v1 equals: self v1.
]

{ #category : #'tests-comparison' }
CGOSemanticVersionTest >> testVersionsWithEqualSemanticVersionsWithNoPatchNumberShouldBeEqual [

	self assert: self v12 equals: self v12.
]

{ #category : #helpers }
CGOSemanticVersionTest >> v1 [

	^ SemanticVersion fromString: '1'
]

{ #category : #helpers }
CGOSemanticVersionTest >> v10 [

	^ SemanticVersion fromString: '1.0'
]

{ #category : #helpers }
CGOSemanticVersionTest >> v100 [

	^ SemanticVersion fromString: '1.0.0'
]

{ #category : #helpers }
CGOSemanticVersionTest >> v101 [

	^ SemanticVersion fromString: '1.0.1'
]

{ #category : #helpers }
CGOSemanticVersionTest >> v11 [

	^ SemanticVersion fromString: '1.1'
]

{ #category : #helpers }
CGOSemanticVersionTest >> v110 [

	^ SemanticVersion fromString: '1.1.0'
]

{ #category : #helpers }
CGOSemanticVersionTest >> v111 [

	^ SemanticVersion fromString: '1.1.1'
]

{ #category : #helpers }
CGOSemanticVersionTest >> v112 [

	^ SemanticVersion fromString: '1.1.2'
]

{ #category : #helpers }
CGOSemanticVersionTest >> v12 [

	^ SemanticVersion fromString: '1.2'
]

{ #category : #helpers }
CGOSemanticVersionTest >> v123 [

	^ SemanticVersion fromString: '1.2.3'
]

{ #category : #helpers }
CGOSemanticVersionTest >> v2 [

	^ SemanticVersion fromString: '2'
]

{ #category : #helpers }
CGOSemanticVersionTest >> v20 [

	^ SemanticVersion fromString: '2.0'
]

{ #category : #helpers }
CGOSemanticVersionTest >> v200 [

	^ SemanticVersion fromString: '2.0.0'
]

{ #category : #helpers }
CGOSemanticVersionTest >> v201 [

	^ SemanticVersion fromString: '2.0.1'
]

{ #category : #helpers }
CGOSemanticVersionTest >> v21 [

	^ SemanticVersion fromString: '2.1'
]

{ #category : #helpers }
CGOSemanticVersionTest >> v210 [

	^ SemanticVersion fromString: '2.1.0'
]

{ #category : #helpers }
CGOSemanticVersionTest >> v211 [

	^ SemanticVersion fromString: '2.1.1'
]
