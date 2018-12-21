Class {
	#name : #PBSerializedProjectV1Test,
	#superclass : #TestCase,
	#category : #'CargoPackageManager-Tests-Model-Serialization'
}

{ #category : #utility }
PBSerializedProjectV1Test >> serializedPropertiesOfDependencies: aListOfResolvedDependencies [
	^ aListOfResolvedDependencies collect: [ :dependency | | serializedDepProperties |
		serializedDepProperties := STON fromString: (STON toString: dependency).
		serializedDepProperties at: #version ]
]

{ #category : #'expected values' }
PBSerializedProjectV1Test >> stonStringForProjectWithDependencies [
	^ '{#version:''1.0''}
{
	#name : #PharoLauncher,
	#description : ''Pharo Launcher is a cross-platform application that\r\r    lets you manage your Pharo images (launch, rename, copy and delete);\r    lets you download image templates (i.e., zip archives) from many different sources (e.g., Jenkins, files.pharo.org, and your local cache);\r    lets you create new images from any template,\r    automatically find and download the appropriate VM to launch your images.'',
	#version : ''1.0.0'',
	#dependencies : [
		{
			#configuration : #JSON,
			#url : ''http://smalltalkhub.com/mc/PharoExtras/JSON/main/'',
			#version : ''1.2''
		},
		{
			#configuration : #OSProcess,
			#url : ''http://www.squeaksource.com/MetacelloRepository'',
			#version : ''4.6.13''
		},
		{
			#configuration : #ProcessWrapper,
			#url : ''http://smalltalkhub.com/mc/hernan/ProcessWrapper/main/'',
			#version : ''0.1-baseline''
		},
		{
			#configuration : #Ston,
			#url : ''http://ss3.gemstone.com/ss/STON'',
			#version : ''0.27''
		},
		{
			#configuration : #XMLParser,
			#url : ''http://smalltalkhub.com/mc/PharoExtras/XMLParser/main/'',
			#version : ''3.5.0''
		}
	]
}'
]

{ #category : #'expected values' }
PBSerializedProjectV1Test >> stonStringForProjectWithPackages [
	^ '{#version:''1.0''}
{
	#name : #PharoLauncher,
	#description : ''Pharo Launcher is a cross-platform application that\r\r    lets you manage your Pharo images (launch, rename, copy and delete);\r    lets you download image templates (i.e., zip archives) from many different sources (e.g., Jenkins, files.pharo.org, and your local cache);\r    lets you create new images from any template,\r    automatically find and download the appropriate VM to launch your images.'',
	#version : ''1.0.0'',
	#units : [
		{
			#name : #PharoLauncher-Core,
			#description : ''Core package with the model, commands and settings.''
		},
		{
			#name : #PharoLauncher-Download,
			#description : ''Package dealing with image / VM detection and download.''
		},
		{
			#name : #PharoLauncher-Spec,
			#description : ''PharoLauncher UI.''
		},
		{
			#name : #PharoLauncher-Tests-Core,
			#description : ''Tests of the PharoLauncher-Core package..''
		},
		{
			#name : #PharoLauncher-Tests-Download,
			#description : ''Tests of the PharoLauncher-Download package.''
		}
	]
}'
]

{ #category : #'expected values' }
PBSerializedProjectV1Test >> stonStringForSimpleProject [
	^ '{#version:''1.0''}
{
	#name : #MyProject,
	#description : ''A simple project used for illustration.'',
	#version : ''1.0.0'',
	#units : [
		{
			#name : #UnitTest,
			#description : ''A simple ongoing package unit.''
		}
	]
}'
]

{ #category : #tests }
PBSerializedProjectV1Test >> testCanSerializeProjectWithDependencies [
	| serializedProject project dependenciesVersions |
	
	project := PharoLauncherProject new
		buildProject;
		buildExternalProjectDependencies.
	project version: '1.0' asSemanticVersion.
	serializedProject := project asSerializedPackage.
	
	dependenciesVersions := self serializedPropertiesOfDependencies: (serializedProject propertyNamed: #dependencies).
	self 
		shouldnt: [ dependenciesVersions collect: #asSemanticVersion ]
		raise: InvalidSemanticVersion.	
	self
		assert: serializedProject asString
		equals: self stonStringForProjectWithDependencies
]

{ #category : #tests }
PBSerializedProjectV1Test >> testCanSerializeProjectWithPackages [
	| serializedProject project |
	
	project := PharoLauncherProject new
		buildProject;
		buildPackages;
		removePackagesDependencies.
	project version: '1.0' asSemanticVersion.
	serializedProject := project asSerializedPackage.
	
	self
		assert: serializedProject asString
		equals: self stonStringForProjectWithPackages
]

{ #category : #tests }
PBSerializedProjectV1Test >> testCanSerializeSimpleProject [
	| serializedProject |
	
	serializedProject := PBProject example 
		version: '1.0' asSemanticVersion;
		registry: PBPackageRegistry new;
		asSerializedPackage.
	
	self
		assert: serializedProject asString
		equals: self stonStringForSimpleProject
]
