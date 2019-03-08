Class {
	#name : #SemanticVersionTest,
	#superclass : #TestCase,
	#category : #'CargoPackageManager-Tests-Model'
}

{ #category : #helpers }
SemanticVersionTest >> assertVersion: aSymbolicVersionString printStringEquals: aString [
	| version |
	
	version := SemanticVersion fromString: aSymbolicVersionString.
	self assert: version printString equals: aString.
]

{ #category : #helpers }
SemanticVersionTest >> assertVersionFromString: aString major: major minor: minor patch: patch suffix: suffix [
	| version |
	
	version := SemanticVersion fromString: aString.
	self assert: version isNotNil.
	self assert: version major equals: major.
	self assert: version minor equals: minor.
	self assert: version patch equals: patch.
	self assert: version suffix equals: suffix.
]

{ #category : #helpers }
SemanticVersionTest >> stonSerializationFor: aString [
	^ CGOPackageVersionWriterV1 toStringPretty: (SemanticVersion fromString: aString)
]

{ #category : #'tests-parsing' }
SemanticVersionTest >> testExtractSuffixSuffixedVersionStringShouldReturnSuffix [
	
	self 
		assert: (SemanticVersion suffixFrom: '0-RC1')
		equals: '-RC1'
]

{ #category : #'tests-parsing' }
SemanticVersionTest >> testPrintString [

	self assertVersion: '2' printStringEquals: '2.0.0'.
	self assertVersion: '1.2' printStringEquals: '1.2.0'.
	self assertVersion: '1.1.3' printStringEquals: '1.1.3'.
	self assertVersion: '1.1.3-RC1' printStringEquals: '1.1.3-RC1'
]

{ #category : #'tests-parsing' }
SemanticVersionTest >> testRegEx [

	self assert: (SemanticVersion parsingRegex matches: '1').
	self assert: (SemanticVersion parsingRegex matches: '1.0').
	self assert: (SemanticVersion parsingRegex matches: '1.0').
	self assert: (SemanticVersion parsingRegex matches: '1.0.1').
	self assert: (SemanticVersion parsingRegex matches: '1-ASD').
	self assert: (SemanticVersion parsingRegex matches: '1.1-aa').
	self assert: (SemanticVersion parsingRegex matches: '1.0.1-aaa')
]

{ #category : #'tests-comparison' }
SemanticVersionTest >> testVersionShouldBeGreaterThanVersionWithEqualMajorAndSmallerMinorNumber [

	self assert: self v11 > self v10.
	
	self assert: self v110 > self v101.
	self assert: self v111 > self v101.
]

{ #category : #'tests-comparison' }
SemanticVersionTest >> testVersionShouldBeGreaterThanVersionWithEqualMajorEqualMinorAndSmallerPatchNumber [

	self assert: self v111 > self v100
]

{ #category : #'tests-comparison' }
SemanticVersionTest >> testVersionShouldBeGreaterThanVersionWithSmallerMajorNumber [

	self assert: self v2 > self v1.
	
	self assert: self v21 > self v10.
	self assert: self v20 > self v11.
	
	self assert: self v210 > self v101.
	self assert: self v211 > self v100.
	
	self assert: self v201 > self v100.
	self assert: self v200 > self v101.
]

{ #category : #'tests-parsing' }
SemanticVersionTest >> testVersionStringInvalidShouldFail [

	self assert: (SemanticVersion fromString: 'toto') isInvalid
]

{ #category : #'tests-parsing' }
SemanticVersionTest >> testVersionStringWithMajorNumberShouldOnlyHaveMajorVersionNumber [

	self assertVersionFromString: '2' major: 2 minor: 0 patch: 0 suffix: nil
]

{ #category : #'tests-parsing' }
SemanticVersionTest >> testVersionStringWithMinorNumberShouldOnlyHaveMajorAndMinorVersionNumber [

	self assertVersionFromString: '1.2' major: 1 minor: 2 patch: 0 suffix: nil
]

{ #category : #'tests-parsing' }
SemanticVersionTest >> testVersionStringWithMoreThanThreeComponentsShouldFail [

	self assert: (SemanticVersion fromString: '1.2.3.4') isInvalid
]

{ #category : #'tests-parsing' }
SemanticVersionTest >> testVersionStringWithPatchNumberShouldOnlyHaveMajorAndMinorAndPatchVersionNumber [

	self assertVersionFromString: '1.1.3' major: 1 minor: 1 patch: 3 suffix: nil
]

{ #category : #'tests-parsing' }
SemanticVersionTest >> testVersionStringWithSuffixButNoMinorNorPatchNumberShouldHaveSuffix [

	self assertVersionFromString: '1-RC1' major: 1 minor: 0 patch: 0 suffix: 'RC1'
]

{ #category : #'tests-parsing' }
SemanticVersionTest >> testVersionStringWithSuffixButNoPatchNumberShouldHaveSuffix [

	self assertVersionFromString: '1.1-RC1' major: 1 minor: 1 patch: 0 suffix: 'RC1'
]

{ #category : #'tests-parsing' }
SemanticVersionTest >> testVersionStringWithSuffixShouldHaveSuffix [

	self assertVersionFromString: '1.1.3-RC1' major: 1 minor: 1 patch: 3 suffix: 'RC1'
]

{ #category : #'tests-comparison' }
SemanticVersionTest >> testVersionWithNoMinorNumberShouldHaveMinorNumberEqualsToZero [
	| v1 v2 |
	
	v1 := SemanticVersion fromString: '1'.
	v2 := SemanticVersion fromString: '1.0'.

	self assert: self v1 equals: self v10.
]

{ #category : #'tests-comparison' }
SemanticVersionTest >> testVersionWithNoMinorNumberShouldHavePatchNumberEqualsToZero [

	self assert: self v1 equals: self v100.
]

{ #category : #'tests-comparison' }
SemanticVersionTest >> testVersionWithNoPatchNumberShouldHavePatchNumberEqualsToZero [
	| v1 v2 |
	
	v1 := SemanticVersion fromString: '1.1'.
	v2 := SemanticVersion fromString: '1.1.0'.

	self assert: self v11 equals: self v110.
]

{ #category : #'tests-development versions' }
SemanticVersionTest >> testVersionWithSuffixDevShouldBeADevelopmentVersion [
	
	self assert: (SemanticVersion fromString: '1.0-dev') isDevelopmentVersion
]

{ #category : #'tests-development versions' }
SemanticVersionTest >> testVersionWithoutSuffixDevShouldNotBeADevelopmentVersion [
	
	self deny: (SemanticVersion fromString: '1.0-devv') isDevelopmentVersion
]

{ #category : #'tests-comparison' }
SemanticVersionTest >> testVersionsWithDifferentMajorVersionNumberShouldBeDifferent [

	self deny: self v1 = self v2.
]

{ #category : #'tests-comparison' }
SemanticVersionTest >> testVersionsWithDifferentMinorVersionNumberShouldBeDifferent [

	self deny: self v11 = self v12.
]

{ #category : #'tests-comparison' }
SemanticVersionTest >> testVersionsWithDifferentPatchVersionNumberShouldBeDifferent [

	self deny: self v111 = self v112.
]

{ #category : #'tests-comparison' }
SemanticVersionTest >> testVersionsWithEqualSemanticVersionsShouldBeEqual [

	self assert: self v123 equals: self v123.
]

{ #category : #'tests-comparison' }
SemanticVersionTest >> testVersionsWithEqualSemanticVersionsWithNoMinorNumberShouldBeEqual [

	self assert: self v1 equals: self v1.
]

{ #category : #'tests-comparison' }
SemanticVersionTest >> testVersionsWithEqualSemanticVersionsWithNoPatchNumberShouldBeEqual [

	self assert: self v12 equals: self v12.
]

{ #category : #helpers }
SemanticVersionTest >> v1 [

	^ SemanticVersion fromString: '1'
]

{ #category : #helpers }
SemanticVersionTest >> v10 [

	^ SemanticVersion fromString: '1.0'
]

{ #category : #helpers }
SemanticVersionTest >> v100 [

	^ SemanticVersion fromString: '1.0.0'
]

{ #category : #helpers }
SemanticVersionTest >> v101 [

	^ SemanticVersion fromString: '1.0.1'
]

{ #category : #helpers }
SemanticVersionTest >> v11 [

	^ SemanticVersion fromString: '1.1'
]

{ #category : #helpers }
SemanticVersionTest >> v110 [

	^ SemanticVersion fromString: '1.1.0'
]

{ #category : #helpers }
SemanticVersionTest >> v111 [

	^ SemanticVersion fromString: '1.1.1'
]

{ #category : #helpers }
SemanticVersionTest >> v112 [

	^ SemanticVersion fromString: '1.1.2'
]

{ #category : #helpers }
SemanticVersionTest >> v12 [

	^ SemanticVersion fromString: '1.2'
]

{ #category : #helpers }
SemanticVersionTest >> v123 [

	^ SemanticVersion fromString: '1.2.3'
]

{ #category : #helpers }
SemanticVersionTest >> v2 [

	^ SemanticVersion fromString: '2'
]

{ #category : #helpers }
SemanticVersionTest >> v20 [

	^ SemanticVersion fromString: '2.0'
]

{ #category : #helpers }
SemanticVersionTest >> v200 [

	^ SemanticVersion fromString: '2.0.0'
]

{ #category : #helpers }
SemanticVersionTest >> v201 [

	^ SemanticVersion fromString: '2.0.1'
]

{ #category : #helpers }
SemanticVersionTest >> v21 [

	^ SemanticVersion fromString: '2.1'
]

{ #category : #helpers }
SemanticVersionTest >> v210 [

	^ SemanticVersion fromString: '2.1.0'
]

{ #category : #helpers }
SemanticVersionTest >> v211 [

	^ SemanticVersion fromString: '2.1.1'
]
