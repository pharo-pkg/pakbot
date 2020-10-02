"
Dummy class used to keep some usefull pieces of code (easier to get them in a fresh image).
"
Class {
	#name : #CGODataHolder,
	#superclass : #Object,
	#category : #'CargoPackageManager-Spec'
}

{ #category : #'as yet unclassified' }
CGODataHolder >> diffMetacelloPPM4Seaside31 [
	"Only loaded by Metacello"
 '		load : Grease-Tests-Core-pmm.94
			load : Grease-Tests-Pharo20-Core-pmm.8
			load : Seaside-Tests-Core-pmm.272
		load : Seaside-Tests-Pharo20-Core-pmm.4
		load : Seaside-Tests-Component-pmm.36
		load : Seaside-Tests-Canvas-pmm.64
		load : Seaside-Tests-Pharo-Canvas-pmm.1
		load : Seaside-Tests-Session-pmm.72
		load : Seaside-Tests-RenderLoop-lr.13
		load : Seaside-Tests-Environment-pmm.30
		load : Seaside-Tests-Functional-pmm.156
		load : Seaside-Tests-Pharo-Functional-pmm.15
		load : Seaside-Tests-Flow-pmm.37
		load : Seaside-Tests-Welcome-lr.6
		load : Seaside-Tests-Pharo-Continuation-pmm.9'
]

{ #category : #'as yet unclassified' }
CGODataHolder >> metacelloSeaside31Resolution [
 Metacello new
  configuration: 'Seaside3';
  version: '3.1.0';
  record. 
	'linear load : 
	linear load : 3.1.0 [ConfigurationOfSeaside3]
		load : ConfigurationOfGrease
	linear load : 3.1.0 [ConfigurationOfSeaside3]
		load : ConfigurationOfGrease
	linear load : 3.1.0 [ConfigurationOfSeaside3]
		explicit load : Grease
			load : ConfigurationOfGrease-pmm.241
		linear load : 1.1.5 [ConfigurationOfGrease]
			load : Grease-Core-JohanBrichau.83
			load : Grease-Pharo30-Core-pmm.11
		linear load : 1.1.5 [ConfigurationOfGrease]
			load : Grease-Tests-Core-pmm.94
			load : Grease-Tests-Pharo20-Core-pmm.8
		load : Seaside-Core-pmm.808
		load : Seaside-Pharo20-Core-pmm.3
		load : Seaside-Component-pmm.101
		load : Seaside-Canvas-pmm.127
		load : Seaside-Pharo-Canvas-pmm.4
		load : Seaside-Session-pmm.168
		load : Seaside-RenderLoop-JohanBrichau.95
		load : Seaside-Tools-Core-pmm.23
		load : Seaside-Pharo-Tools-Spec-pmm.9
		load : Seaside-Flow-pmm.24
		load : Seaside-Examples-pmm.24
		load : Seaside-Widgets-pmm.33
		load : Seaside-Tools-Web-pmm.118
		load : Seaside-Pharo20-Tools-Web-JohanBrichau.3
		load : Seaside-Development-pmm.163
		load : Seaside-Environment-pmm.81
		load : Seaside-Pharo-Environment-lr.6
		load : Seaside-Tests-Core-pmm.272
		load : Seaside-Tests-Pharo20-Core-pmm.4
		load : Seaside-Tests-Component-pmm.36
		load : Seaside-Tests-Canvas-pmm.64
		load : Seaside-Tests-Pharo-Canvas-pmm.1
		load : Seaside-Tests-Session-pmm.72
		load : Seaside-Tests-RenderLoop-lr.13
		load : Seaside-Tests-Environment-pmm.30
		load : Seaside-Tests-Functional-pmm.156
		load : Seaside-Tests-Pharo-Functional-pmm.15
		load : Seaside-Tests-Flow-pmm.37
		load : Zinc-Seaside-SvenVanCaekenberghe.40
		load : Javascript-Core-pmm.95
		load : Javascript-Pharo20-Core-JohanBrichau.4
		load : JQuery-Core-pmm.128
		load : JQuery-UI-pmm.88
		load : Seaside-Welcome-pmm.47
		load : Seaside-Pharo-Welcome-NickAger.2
		load : Seaside-Tests-Welcome-lr.6
		load : Seaside-Pharo-Continuation-lr.5
		load : Seaside-Tests-Pharo-Continuation-pmm.9
		load : Seaside-Pharo-Flow-lr.5
		load : Seaside-Pharo-Development-JohanBrichau.66'
]

{ #category : #'as yet unclassified' }
CGODataHolder >> seaside31DescriptionGeneration [
"common"
CGOPackageSpecGenerator generateFor: 'Seaside-Canvas' withDependencies: #('Seaside-Core').
CGOPackageSpecGenerator generateFor: 'Seaside-Component' withDependencies: #('Seaside-Core' ).
CGOPackageSpecGenerator generateFor: 'Seaside-Core' withDependencies: #('Grease' ).
CGOPackageSpecGenerator generateFor: 'Seaside-Development' withDependencies: #('Seaside-Tools-Web' 'Seaside-Flow').
CGOPackageSpecGenerator generateFor: 'Seaside-Email' withDependencies: #('Seaside-Core' ).
CGOPackageSpecGenerator generateFor: 'Seaside-Environment' withDependencies: #('Seaside-Core' 'Seaside-Canvas' 'Seaside-Session' 'Seaside-Component' 'Seaside-RenderLoop' 'Seaside-Tools-Core' 'Seaside-Widgets' ).
CGOPackageSpecGenerator generateFor: 'Seaside-Flow' withDependencies: #('Seaside-Core' 'Seaside-Component' 'Seaside-RenderLoop' 'Seaside-Tools-Core' ).
CGOPackageSpecGenerator generateFor: 'Seaside-InternetExplorer' withDependencies: #('Seaside-Core' ).
CGOPackageSpecGenerator generateFor: 'Seaside-RenderLoop' withDependencies: #('Seaside-Component' 'Seaside-Session' ).
CGOPackageSpecGenerator generateFor: 'Seaside-Session' withDependencies: #('Seaside-Core' 'Seaside-Canvas' ).
CGOPackageSpecGenerator generateFor: 'Seaside-Tools-Core' withDependencies: #('Seaside-Core' 'Seaside-Component' 'Seaside-RenderLoop' 'Seaside-Session' ).
CGOPackageSpecGenerator generateFor: 'Seaside-Tools-Web' withDependencies: #('Seaside-Tools-Core' 'Seaside-RenderLoop' 'Seaside-Widgets' ).
CGOPackageSpecGenerator generateFor: 'Seaside-Widgets' withDependencies: #('Seaside-Component' 'Seaside-Canvas' ).
CGOPackageSpecGenerator generateFor: 'Seaside-Tests-Canvas' withDependencies: #('Seaside-Tests-Core' 'Seaside-Canvas' ).
CGOPackageSpecGenerator generateFor: 'Seaside-Tests-Component' withDependencies: #('Seaside-Component' 'Seaside-Tests-Core' ).
CGOPackageSpecGenerator generateFor: 'Seaside-Tests-Core' withDependencies: #('Seaside-Core' 'Grease Core Tests' ).
CGOPackageSpecGenerator generateFor: 'Seaside-Tests-Development' withDependencies: #('Seaside-Development' 'Seaside-Tests-Tools-Web' 'Seaside-Tests-Environment' ).
CGOPackageSpecGenerator generateFor: 'Seaside-Tests-Email' withDependencies: #('Seaside-Email' 'Seaside-Tests-Core' ).
CGOPackageSpecGenerator generateFor: 'Seaside-Tests-Environment' withDependencies: #('Seaside-Environment' 'Seaside-Tests-Component' 'Seaside-Tests-RenderLoop' 'Seaside-Tests-Session' 'Seaside-Tests-Canvas' ).
CGOPackageSpecGenerator generateFor: 'Seaside-Tests-Examples' withDependencies: #('Seaside-Examples' 'Seaside-Tests-Environment' ).
CGOPackageSpecGenerator generateFor: 'Seaside-Tests-Flow' withDependencies: #('Seaside-Flow' 'Seaside-Tests-Functional' ).
CGOPackageSpecGenerator generateFor: 'Seaside-Tests-Functional' withDependencies: #('Seaside-Environment' 'Seaside-Tests-Core' 'Seaside-Widgets' ).
CGOPackageSpecGenerator generateFor: 'Seaside-Tests-InternetExplorer' withDependencies: #('Seaside-InternetExplorer' 'Seaside-Tests-Core' ).
CGOPackageSpecGenerator generateFor: 'Seaside-Tests-RenderLoop' withDependencies: #('Seaside-RenderLoop' 'Seaside-Tests-Session' ).
CGOPackageSpecGenerator generateFor: 'Seaside-Tests-Session' withDependencies: #('Seaside-Tests-Core' 'Seaside-Session' 'Seaside-Tests-Canvas').
CGOPackageSpecGenerator generateFor: 'Seaside-Tests-Tools-Web' withDependencies: #('Seaside-Tools-Web' 'Seaside-Tests-Environment' ).
CGOPackageSpecGenerator generateFor: 'Seaside-Tests-UTF8' withDependencies: #('Seaside-Tests-Core' ).
CGOPackageSpecGenerator generateFor: 'Seaside-Examples' withDependencies: #('Seaside-Component' 'Seaside-Canvas' 'Seaside-Tools-Core' ).

"common groups"                                                                               
CGOPackageSpecGenerator generateFor: 'Seaside-Group-Core' withDependencies: #('Seaside-Core' 'Seaside-Canvas' 'Seaside-Session' 'Seaside-Component' 'Seaside-RenderLoop' 'Seaside-Tools-Core' 'Seaside-Flow' 'Seaside-Environment' 'Seaside-Widgets' ).
CGOPackageSpecGenerator generateFor: 'Seaside-Group-CI' withDependencies: #('Tests' 'Zinc' 'Development Tests' 'REST Tests').
CGOPackageSpecGenerator generateFor: 'Seaside-Group-Tests' withDependencies: #('Core' 'Seaside-Tests-Core' 'Seaside-Tests-Canvas' 'Seaside-Tests-Session' 'Seaside-Tests-Component' 'Seaside-Tests-RenderLoop' 'Seaside-Tests-Environment' 'Seaside-Tests-Flow' 'Seaside-Tests-UTF8' 'Seaside-Tests-InternetExplorer' 'Seaside-Tests-Email' 'Seaside-Tests-Examples' 'RSS Tests' 'Welcome Tests').
"	spec for: #'squeakCommon' do: [
		spec group: 'Tests' with: #('Comet Tests') ]."
CGOPackageSpecGenerator generateFor: 'Seaside-Group-Development' withDependencies: #('Core' 'Seaside-Development' ).
CGOPackageSpecGenerator generateFor: 'Seaside-Group-DevelopmentTests' withDependencies: #('Development' 'Core' 'Seaside-Tests-Development' ).
CGOPackageSpecGenerator generateFor: 'Seaside-Group-Email' withDependencies: #('Seaside-Email').
CGOPackageSpecGenerator generateFor: 'Seaside-Group-Examples' withDependencies: #('Core' 'Seaside-Examples' ).

"pharo"
CGOPackageSpecGenerator generateFor: 'Seaside-Pharo-Continuation' withDependencies: #().
CGOPackageSpecGenerator generateFor: 'Seaside-Pharo-Canvas' withDependencies: #('Seaside-Core' 'Seaside-Canvas').
CGOPackageSpecGenerator generateFor: 'Seaside-Pharo-Development' withDependencies: #().
CGOPackageSpecGenerator generateFor: 'Seaside-Pharo-Email' withDependencies: #().
CGOPackageSpecGenerator generateFor: 'Seaside-Pharo-Environment' withDependencies: #('Seaside-Environment' 'Seaside-Core' 'Seaside-Canvas').
CGOPackageSpecGenerator generateFor: 'Seaside-Pharo-Flow' withDependencies: #('Seaside-Flow' 'Seaside-Pharo-Continuation').
CGOPackageSpecGenerator generateFor: 'Seaside-Tests-Pharo-Development' withDependencies: #('Seaside-Tests-Development' 'Seaside-Pharo-Development').
CGOPackageSpecGenerator generateFor: 'Seaside-Tests-Pharo-Continuation' withDependencies: #('Seaside-Pharo-Continuation' ).
CGOPackageSpecGenerator generateFor: 'Seaside-Tests-Pharo-Functional' withDependencies: #('Seaside-Tests-Functional' 'Seaside-Tests-Environment' 'Seaside-Pharo-Environment').
CGOPackageSpecGenerator generateFor: 'Seaside-Tests-Pharo-Email' withDependencies: #('Seaside-Email' 'Seaside-Pharo-Email' 'Grease Core Tests').
CGOPackageSpecGenerator generateFor: 'Seaside-Tests-Pharo-Canvas' withDependencies: #('Seaside-Tests-Canvas').

"pharo 3"
CGOPackageSpecGenerator generateFor: 'Seaside-Pharo20-Tools-Web' withDependencies: #('Seaside-Tools-Web' 'Seaside-Core' 'Seaside-Canvas').
CGOPackageSpecGenerator generateFor: 'Seaside-Pharo20-Core' withDependencies: #('Seaside-Core').
CGOPackageSpecGenerator generateFor: 'Seaside-Tests-Pharo20-Core' withDependencies: #('Seaside-Pharo20-Core' 'Seaside-Tests-Core').
CGOPackageSpecGenerator generateFor: 'Seaside-Pharo-Tools-Spec' withDependencies: #('Seaside-Tools-Core').

"adaptors"
CGOPackageSpecGenerator generateFor: 'Zinc-HTTP' withDependencies: #().
CGOPackageSpecGenerator generateFor: 'Zinc-Seaside' withDependencies: #('Zinc Project' 'Seaside-Core').

"default group"
CGOPackageSpecGenerator generateFor: 'Seaside-Group-Default' withDependencies: #('Seaside-Core' 'Seaside-Welcome' 'Seaside-Examples' 'Zinc-HTTP').
CGOPackageSpecGenerator generateFor: 'Seaside-Welcome' withDependencies: #('Seaside-Environment' 'Seaside-Tools-Web' 'Seaside-Widgets' 'Seaside-Examples' 'Seaside-Development' 'Seaside-Flow' "'Seaside-Tests-Flow'" 'JQuery-Core' 'JQuery-UI' 'Seaside-Pharo-Welcome').

"jquery"
CGOPackageSpecGenerator generateFor: 'JQuery-Core' withDependencies: #('Javascript-Core').
CGOPackageSpecGenerator generateFor: 'JQuery-UI' withDependencies: #('JQuery-Core').

"javascript"
CGOPackageSpecGenerator generateFor: 'Javascript-Core' withDependencies: #('Seaside-Core' 'Seaside-Canvas' 'Javascript-Pharo20-Core').
CGOPackageSpecGenerator generateFor: 'Javascript-Pharo20-Core' withDependencies: #('Javascript-Core' 'Seaside-Pharo20-Core').

"Welcome"
CGOPackageSpecGenerator generateFor: 'Seaside-Pharo-Welcome' withDependencies: #('Seaside-Welcome').

]

{ #category : #'as yet unclassified' }
CGODataHolder >> seaside31LoadingAnyOrder [
| files gofer |
files := #('Seaside-Tools-Core-pmm.23' 'Seaside-Pharo20-Core-pmm.3' 'Seaside-Pharo-Welcome-NickAger.2' 'JQuery-Core-pmm.128' 'Seaside-Component-pmm.101' 'Seaside-Pharo-Continuation-lr.5' 'Javascript-Core-pmm.95' 'Seaside-Pharo20-Tools-Web-JohanBrichau.3' 'Grease-Core-JohanBrichau.83' 'Grease-Pharo30-Core-pmm.11' 'Seaside-Tools-Web-pmm.118' 'Zinc-Seaside-SvenVanCaekenberghe.40' 'Javascript-Pharo20-Core-JohanBrichau.4' 'Seaside-Environment-pmm.81' 'Seaside-Development-pmm.163' 'Seaside-Examples-pmm.24' 'JQuery-UI-pmm.88' 'Seaside-RenderLoop-JohanBrichau.95' 'Seaside-Pharo-Environment-lr.6' 'Seaside-Pharo-Tools-Spec-pmm.9' 'Seaside-Core-pmm.808' 'Seaside-Widgets-pmm.33' 'Seaside-Session-pmm.168' 'Seaside-Pharo-Flow-lr.5' 'Seaside-Pharo-Development-JohanBrichau.66' 'Seaside-Flow-pmm.24' 'Zinc-Character-Encoding-Core-SvenVanCaekenberghe.28' 'Zinc-HTTP-SvenVanCaekenberghe.388' 'Zinc-Resource-Meta-Core-SvenVanCaekenberghe.30' 'Seaside-Canvas-pmm.127' 'Seaside-Pharo-Canvas-pmm.4' 'Seaside-Welcome-pmm.47').

gofer := Gofer new.
gofer repository: (MCSmalltalkhubRepository owner: 'Seaside' project: 'Seaside31').
gofer repository: (MCSmalltalkhubRepository owner: 'Seaside' project: 'Grease11').
gofer repository: (MCHttpRepository location: 'http://mc.stfx.eu/ZincHTTPComponents' ).

files do: [ :file | gofer version: file ].

gofer load
]

{ #category : #'as yet unclassified' }
CGODataHolder >> seaside31LoadingInOrder [
| files gofer |

files := #(	'Grease-Core-JohanBrichau.83' 
			'Grease-Pharo30-Core-pmm.11' 
			'Zinc-Character-Encoding-Core-SvenVanCaekenberghe.28' 
			'Zinc-Resource-Meta-Core-SvenVanCaekenberghe.30' 
			'Zinc-HTTP-SvenVanCaekenberghe.388').
gofer := Gofer new.
gofer repository: (MCSmalltalkhubRepository owner: 'Seaside' project: 'Grease11').
gofer repository: (MCHttpRepository location: 'http://mc.stfx.eu/ZincHTTPComponents' ).
files do: [ :file | gofer version: file ].
gofer load.

files := #(	'Grease-Core-JohanBrichau.83' 
			'Grease-Pharo30-Core-pmm.11' 
			'Zinc-Character-Encoding-Core-SvenVanCaekenberghe.28' 
			'Zinc-Resource-Meta-Core-SvenVanCaekenberghe.30' 
			'Zinc-HTTP-SvenVanCaekenberghe.388' 
			'Seaside-Core-pmm.808' 
			'Seaside-Pharo20-Core-pmm.3' 
			'Seaside-Component-pmm.101' 
			'Seaside-Canvas-pmm.127' 
			'Seaside-Pharo-Canvas-pmm.4' 
			'Seaside-Session-pmm.168' 
			'Seaside-RenderLoop-JohanBrichau.95' 
			'Seaside-Tools-Core-pmm.23'
			'Seaside-Pharo-Tools-Spec-pmm.9' 
			'Seaside-Flow-pmm.24' 

			'Seaside-Examples-pmm.24' 
			'Seaside-Widgets-pmm.33' 
			'Seaside-Pharo-Flow-lr.5'
			'Seaside-Tools-Web-pmm.118' 
			'Seaside-Pharo20-Tools-Web-JohanBrichau.3' 
			'Seaside-Development-pmm.163' 
			'Seaside-Pharo-Development-JohanBrichau.66' 		

			'Seaside-Environment-pmm.81' 
			'Seaside-Pharo-Environment-lr.6' 
			'Zinc-Seaside-SvenVanCaekenberghe.40' 
			'Javascript-Core-pmm.95' 
			'Javascript-Pharo20-Core-JohanBrichau.4' 
			'JQuery-Core-pmm.128' 
			'JQuery-UI-pmm.88' 
			'Seaside-Welcome-pmm.47'
			'Seaside-Pharo-Welcome-NickAger.2' 
			'Seaside-Pharo-Continuation-lr.5' 
			).

files do: [ :file | 
    gofer := Gofer new.
    gofer repository: (MCSmalltalkhubRepository owner: 'Seaside' project: 'Seaside31').
    gofer repository: (MCHttpRepository location: 'http://mc.stfx.eu/ZincHTTPComponents' ).

    gofer version: file.
    gofer load ].

"test with: ZnZincServerAdaptor startOn: 8080 "
]

{ #category : #'as yet unclassified' }
CGODataHolder >> seaside31PPMResolution [
	| aPackageVersion dependencyToSolve |
	
	aPackageVersion := Seaside31Spec new buildPackage.
	dependencyToSolve := PBPackageDependency 
								on: aPackageVersion package
								for: nil
								withConstraints: (CGOFixedVersionConstraint with: '3.1').
	PBSolver new	solveDependency: dependencyToSolve.

]
