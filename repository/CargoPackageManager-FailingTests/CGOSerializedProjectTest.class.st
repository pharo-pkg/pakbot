Class {
	#name : #CGOSerializedProjectTest,
	#superclass : #CGOTest,
	#category : #'CargoPackageManager-FailingTests-Model-Serialization'
}

{ #category : #'test data' }
CGOSerializedProjectTest >> stonStringForExampleProject [
	^ 'CGOProject {
	#description : ''A simple project used for illustration.'',
	#version : ''0.1.0-dev'',
	#name : #MyProject,
	#repository : CGOGitRepository {
		#repositoryUrl : ''git@github.com:foo/bar.git'',
		#subdirectory : ''repository''
	},
	#unitNames : [
		#Package1,
		#Package2
	]
}'
]

{ #category : #tests }
CGOSerializedProjectTest >> testFromSton [
	| project |
	
	project := STON fromString: self stonStringForExampleProject.
	
	self
		assert: project
		equals: PBProjectVersion example asCargoProject.
		
	self assert: project authors isEmpty.
	self 
		assertCollection: project packageNames
		hasSameElements: #('Package1' 'Package2')
]

{ #category : #tests }
CGOSerializedProjectTest >> testFromStonTargetClass [
	| ston |
	ston := CGOPackageVersionWriterV1 toStringPretty: 
				(CGOProject new
					instVarNamed: 'name' put: #A;
					instVarNamed: 'version' put: '1.0.0' asSemanticVersion;
					yourself).
	self 
		assert: (STON fromString: ston) class
		equals: CGOProject
]

{ #category : #tests }
CGOSerializedProjectTest >> testStonOn [
	| project |
	
	project := PBProjectVersion example asCargoProject asSerializableCargoProject.
	
	self
		assert: (CGOPackageVersionWriterV1 toStringPretty: project)
		equals: self stonStringForExampleProject
]
