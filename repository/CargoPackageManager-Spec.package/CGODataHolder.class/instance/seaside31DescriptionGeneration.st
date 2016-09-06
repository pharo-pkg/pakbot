as yet unclassified
seaside31DescriptionGeneration
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
