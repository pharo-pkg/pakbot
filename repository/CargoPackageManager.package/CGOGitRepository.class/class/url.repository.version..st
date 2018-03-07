instance creation
url: anUrlOrString repository: anIceRepository version: aCommitishString
	^ self basicNew 
		initializeWithUrl: anUrlOrString repository: anIceRepository andVersion: aCommitishString;
		yourself