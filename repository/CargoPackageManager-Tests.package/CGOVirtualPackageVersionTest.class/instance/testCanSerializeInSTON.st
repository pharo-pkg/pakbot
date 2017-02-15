tests
testCanSerializeInSTON
	| stonString |
	stonString := CGOPackageVersionWriter toStringPretty: self mailVirtualPackage.
	
	self
		assert: stonString
		equals: 'CGOVirtualPackageVersion {
	#package : ''Mail'',
	#version : ''1.0.0'',
	#description : ''I respect the mail protocol V1.0. See link for more details.'',
	#timestamp : DateAndTime [ ''2017-02-03T11:11:15.370245+01:00'' ]
}'