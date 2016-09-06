versions
version01: spec
	<version: '0.1' imports: #('0.2-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'version 0.1 : early version for beta-testing'.
		spec author: 'ChristopheDemarey'.
		spec timestamp: '4/27/2015 15:51'.
		spec 
			project: 'BabyMock2' with: '2.0';
			project: 'Ston' with: '0.9';
			project: 'VoyageMongo' with: '1.3.1';
			project: 'ZincHTTPComponents' with: '2.5.5';
			project: 'MooseAlgos' with: '2.5-baseline'.
		spec 
			package: #PackageManager with: 'PackageManager-ChristopheDemarey.130';
			package: #'PackageManager-Spec' with: 'PackageManager-Spec-ChristopheDemarey.7';
			package: #'PackageManager-TestRessources' with: 'PackageManager-TestRessources-ChristopheDemarey.15';
			package: #'PackageManager-RepositoryBackend' with: 'PackageManager-RepositoryBackend-ChristopheDemarey.30';
			package: #'PackageManager-Tests' with: 'PackageManager-Tests-ChristopheDemarey.10';
			package: #'PackageManager-Repository' with: 'PackageManager-Repository-ChristopheDemarey.3'. ].
