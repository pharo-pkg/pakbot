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
			#baseline : #Icetray,
			#url : ''https://github.com/pharo-spec/icetray.git'',
			#version : #master
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
	],
	#repositoryUrl : {
		#type : #git,
		#repositoryUrl : ''https://github.com/pharo-project/pharo-launcher.git'',
		#version : ''development''
	}
}'
]

{ #category : #'expected values' }
PBSerializedProjectV1Test >> stonStringForProjectWithPackages [
	^ '{#version:''1.0''}
{
	#name : #PharoLauncher,
	#description : ''Pharo Launcher is a cross-platform application that\r\r    lets you manage your Pharo images (launch, rename, copy and delete);\r    lets you download image templates (i.e., zip archives) from many different sources (e.g., Jenkins, files.pharo.org, and your local cache);\r    lets you create new images from any template,\r    automatically find and download the appropriate VM to launch your images.'',
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
	],
	#version : ''1.0.0'',
	#repositoryUrl : {
		#type : #git,
		#repositoryUrl : ''https://github.com/pharo-project/pharo-launcher.git'',
		#version : ''development''
	}
}'
]

{ #category : #'expected values' }
PBSerializedProjectV1Test >> stonStringForSimpleProject [
	^ '{#version:''1.0''}
{
	#name : #MyProject,
	#description : ''A simple project used for illustration.'',
	#units : [
		{
			#name : #UnitTest,
			#description : ''A simple ongoing package unit.''
		}
	],
	#version : ''1.0.0'',
	#repositoryUrl : {
		#type : #git,
		#repositoryUrl : ''git://git@github.com/foo/bar.git''
	}
}'
]

{ #category : #tests }
PBSerializedProjectV1Test >> testCanDeSerializeProjectWithDependencies [
	| project expectedDependencies |
	
	project := PBProject fromStonString: self stonStringForProjectWithDependencies.
	
	self
		assert: project dependencies size
		equals: 5.
		
	expectedDependencies := (PharoLauncherProject new 
		buildProject; 
		buildExternalProjectDependencies)	dependencies.
	self
		assertCollection: (project dependencies collect: #name)
		hasSameElements: (expectedDependencies collect: #name)
]

{ #category : #tests }
PBSerializedProjectV1Test >> testCanDeserializeSimpleProject [
	| project packageUnit |
	
	project := PBProject fromStonString: self stonStringForSimpleProject.
	
	self
		assert: project
		equals: PBProject example.
		
	self assert: project assemblies isEmpty.
	self 
		assertCollection: project packageNames asArray
		hasSameElements: #('UnitTest').

	packageUnit := project packageUnits anyOne.
	self
		assert: packageUnit project 
		equals: project.
	self
		assertCollection: packageUnit platformRequirements 
		hasSameElements: #()
	
]

{ #category : #tests }
PBSerializedProjectV1Test >> testCanSerializeProjectWithDependencies [
	| serializedProject project dependenciesVersions |
	
	project := PharoLauncherProject new
		buildProject;
		buildRepository;
		buildExternalProjectDependencies.
	project version: '1.0' asSemanticVersion.
	[ serializedProject := project asSerializedPackage ]
		on: PBProjectHasConflictsError
		do: [ :e | e resume "ignore for now" ].
	
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
		buildRepository;
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
		repository: (CGOGitRepositoryCreator repositoryFromUrl: 'git@github.com:foo/bar.git');
		asSerializedPackage.
	
	self
		assert: serializedProject asString
		equals: self stonStringForSimpleProject
]

{ #category : #tests }
PBSerializedProjectV1Test >> testErrorSignaledWhenTryingToSerializeProjectWithConflictingDependencies [
	| project |
	
	project := PBProject example.
	project 
		version: '1.0' asSemanticVersion;
		registry: PBPackageRegistry new.

	project addDependency:
		(PBMetacelloConfigurationProjectDependency
			name: 'XMLParser' 
			repositoryUrl: 'http://smalltalkhub.com/mc/PharoExtras/XMLParser/main/'
			version: #stable).
	project addDependency: 
		(PBMetacelloConfigurationProjectDependency 
			name: 'XMLParser'
			repositoryUrl: 'http://smalltalkhub.com/mc/PharoExtras/XMLParser/main/'
			version: '1.0').

	self
		should: [ project asSerializedPackage ]
		raise: PBProjectHasConflictsError 
]
