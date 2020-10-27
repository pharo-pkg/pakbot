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
			#baseline : #OSSubprocess,
			#url : ''https://github.com/pharo-contributions/OSSubprocess.git'',
			#version : ''v1.2.1''
		},
		{
			#baseline : #OSWinSubprocess,
			#url : ''https://github.com/pharo-contributions/OSWinSubprocess.git'',
			#version : ''v1''
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
		#version : ''dev''
	}
}' withInternetLineEndings
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
			#name : #PharoLauncher-80Compatibility,
			#description : ''extensions needed for Pharo 8''
		},
		{
			#name : #PharoLauncher-Core,
			#description : ''Core package with the model, commands and settings.''
		},
		{
			#name : #PharoLauncher-Pharo9ToRemove-FileLocator,
			#description : ''File locator extension integrated into Pharo 9''
		},
		{
			#name : #PharoLauncher-Spec2,
			#description : ''PharoLauncher UI done in Spec 2.''
		},
		{
			#name : #PharoLauncher-Tests-Commands,
			#description : ''Tests of PharoLauncher commands.''
		},
		{
			#name : #PharoLauncher-Tests-Core,
			#description : ''Tests of the PharoLauncher-Core package.''
		},
		{
			#name : #PharoLauncher-Tests-Download,
			#description : ''Tests of the PharoLauncher-Download package.''
		},
		{
			#name : #PharoLauncher-Tests-Functional,
			#description : ''Tests of the PharoLauncher-Download package.''
		},
		{
			#name : #PharoLauncher-Tests-SpecUI,
			#description : ''Tests of the PharoLauncher UI.''
		}
	],
	#repositoryUrl : {
		#type : #git,
		#repositoryUrl : ''https://github.com/pharo-project/pharo-launcher.git'',
		#version : ''dev''
	}
}' withInternetLineEndings
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
	],
	#repositoryUrl : {
		#type : #git,
		#repositoryUrl : ''git://git@github.com/foo/bar.git''
	}
}' withInternetLineEndings 
]

{ #category : #tests }
PBSerializedProjectV1Test >> testCanDeserializeProjectWithDependencies [
	| project expectedDependencies |
	
	project := PBProjectVersion fromStonString: self stonStringForProjectWithDependencies.
	
	self
		assert: project dependencies size
		equals: 3.
		
	expectedDependencies := (PharoLauncherProject new 
		buildProject; 
		buildExternalProjectDependencies)	dependencies.
	self
		assertCollection: (project dependencies collect: #name)
		hasSameElements: (expectedDependencies collect: #name).
		

	self assert: (project dependencies allSatisfy: [ :each | (each instVarNamed: 'project') notNil ]).
]

{ #category : #tests }
PBSerializedProjectV1Test >> testCanDeserializeSimpleProject [
	| project packageUnit |
	
	project := PBProjectVersion fromStonString: self stonStringForSimpleProject.
	
	self
		assert: project
		equals: PBProjectVersion example.
		
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
	
	serializedProject := PBProjectVersion example 
		version: '1.0' asSemanticVersion;
		registry: PBPackageRegistry new;
		repository: (PBGitRepositoryCreator repositoryFromUrl: 'git@github.com:foo/bar.git');
		asSerializedPackage.
	
	self
		assert: serializedProject asString
		equals: self stonStringForSimpleProject
]

{ #category : #tests }
PBSerializedProjectV1Test >> testErrorSignaledWhenTryingToSerializeProjectWithConflictingDependencies [
	| project |
	
	project := PBProjectVersion example.
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
