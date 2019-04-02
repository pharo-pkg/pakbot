Class {
	#name : #PBMetacelloBaselineProjectTest,
	#superclass : #TestCase,
	#category : #'CargoPackageManager-Tests-Model'
}

{ #category : #tests }
PBMetacelloBaselineProjectTest >> testCanConvertGitOverHttpUrlPointingToGitHubToMetacelloUrl [
	| project |
	
	project := PBMetacelloBaselineProject 
		repository: 'https://github.com/sbragagnolo/taskit.git' 
		name: 'TaskIt' 
		version: 'v1.0.1'.
	
	self
		assert: project metacelloUrl
		equals: 'github://sbragagnolo/taskit:v1.0.1'
]

{ #category : #tests }
PBMetacelloBaselineProjectTest >> testCanConvertGitOverSSHUrlPointingToGitHubToMetacelloUrl [
	| project |
	
	project := PBMetacelloBaselineProject 
		repository: 'git@github.com:sbragagnolo/taskit.git' 
		name: 'TaskIt' 
		version: 'v1.0.1'.
	
	self
		assert: project metacelloUrl
		equals: 'github://sbragagnolo/taskit:v1.0.1'
]
