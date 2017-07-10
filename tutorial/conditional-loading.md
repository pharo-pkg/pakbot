# Tutorial: Cargo conditional loading support?

Before starting this tutorial, please ensure you already have [Cargo installed](https://github.com/demarey/cargo#install-cargo).

## Platform attributes
Platform attributes can be used to express that a package can only be installed on given platforms. By example, Grease provides some packages that can only be installed on Pharo, others on GemStone. You can also specify that your package only works for a given version of a Smalltalk vendor, e.g. pharo6.x.

Cargo solver uses this information to **see if a package is suitable for installation on the targeted image** by asking the image its platform attributes (Cargo platformAttributes). A package is suitable for installation if the intersection between package requirements and image platform attributes is not empty.

If more than one package is suitable for installation (ex: package A requires #pharo platform attributes, package B requires #'pharo6.x' platform attributes and image platform attributes are #(#squeakCommon #pharo #'pharo6.x' #'pharo6.0.x') ), then Cargo solver will ask you wich package you want to install. 
Note: Definition of platform attributes starts with the most generic attribute to end with the most specific attribute.

## Cargo virtual packages
As explained on the main page of Cargo (https://github.com/demarey/cargo), virtual packages are there to manage smoothly platform-specific packages. The concept of virtual package comes from the [Debian distribution](http://www.linuxtopia.org/online_books/linux_system_administration/debian_linux_guides/debian_linux_faq/ch-pkg_basics.en_007.html).
A virtual package is a special kind of package. It has only a name, a version and a description (you can define here the contract implied by the virtual package). Some concrete packages (units) will **provide** them, some others will **require** them. They offer **low-coupling** in dependencies description but have to be used carefully (no formal contract, just rely on the package name and version).
Let's tak a concrete example with the Grease project.

### Grease
*Grease* is a project aiming to ease cross-Smalltalk dialects project development by providing a suite of tests to check platform compatibility and a common API a developper can rely on to write code that runs on many platforms (e.g. Seaside).
Grease is composed of some packages common to all platforms, as well as packages that are specific to a platform. For this tutorial, we will only focus on a subset of packages of Grease.
Let's model Grease packages for Pharo 6!
We will get:
- 2 common packages: *Grease-Core* and *Grease-Tests-Core*,
- 2 platform-specific packages: *Grease-Pharo60-Core* and *Grease-Tests-Pharo20-Core*,
- 2 assemblies: *Grease-Tests* and *Grease-Essential* (*Grease-Core* is already the name of a package). 
To manage platform-specific packages, we will define 2 virtual packages: *Grease-Core-Platform* and *Grease-Core-Tests-Platform*.
Note: the assemblies only contain one package and are not mandatary. We could simply rename platform-specific packages to *Grease-Tests* and *Grease-Essential* but it is best to have these assemblies for the understanding of the tutorial.
Here is a picture with involved packages: ![Grease project modelled with Cargo](/doc/grease-cargo-tuto.png)

### Manage code specific to a platform
The Grease-Core package contains code that can be run on various platforms. Grease defines some other platform-specific packages relying on Grease-Core like *Grease-Pharo10*, *Grease-Pharo11-Core*, *Grease-Pharo20-Core*, *Grease-Pharo30-Core*, *Grease-Pharo60-Core*, *Grease-GemStone240-Core*, *Grease-GemStone300*, etc. These packages can only be loaded on the targeted platform.

In Cargo, these package will define some metadata to explicit the fact that they can only be installed on some platforms. It is done by specifying platform requirements:
```smalltalk
(project newPackageUnit: #'Grease-Pharo60-Core')
	description: 'Compatibility for Pharo6';
	addDependencyOn: #'Grease-Core';
	platformRequirements: #('pharo6.x');
	yourself.
```
This way, Cargo will know that this package can only be installed in an image providing the `#'pharo6.x'` platform attribute.

Most of the job is done! We now need to find a way to define parts of the *Grease-Essential* assembly. In pseudo-code, the description of *Grease-Essential* could look like:
```smalltalk
	dependencies:
		(platform = 'pharo1.0.x') ifTrue: [ 'Grease-Pharo10-Core' ].
		(platform = 'pharo1.1.x') ifTrue: [ 'Grease-Pharo11-Core' ].
		(platform = 'pharo2.x') ifTrue: [ 'Grease-Pharo20-Core' ].
		(platform = 'pharo3.x') ifTrue: [ 'Grease-Pharo30-Core' ].
		(platform = 'pharo6.x') ifTrue: [ 'Grease-Pharo60-Core' ].
		(platform = 'gs2.4.x') ifTrue: [ 'Grease-GemStone240-Core' ].
		(platform = 'gs3.0.x') ifTrue: [ 'Grease-GemStone300-Core' ].
```
It is not very nice to list all possiblities here because the same dependency could also be necessary in other packages. Instead, let's use and create a virtual package to avoid duplication and introduce more flexibility:
```smalltalk
(project newVirtualPackage: #'Grease-Core-Platform')
	description: 'Platform-specific code for the Grease-Core package unit';
	yourself.
```
Then we can express *Grease-Essential* assembly as following:
```smalltalk
(project newPackageAssembly: #'Grease-Essential')
	description: 'Convenience package to get Grease essentials (grease-core and its associated platform specific package)';
	parts: #('Grease-Core-Platform');
	yourself.
```
Then, a platform-specific package will look like:
```smalltalk
(project newPackageUnit: #'Grease-Pharo60-Core')
	description: 'Compatibility for Pharo6';
	addDependencyOn: #'Grease-Core';
	platformRequirements: #('pharo6.x');
	provisions: #('Grease-Core-Platform');
	yourself.
```
As you can imagine, all other platform-specific packages will provide the *Grease-Core-Platform* virtual package like *Grease-Pharo60-Core*. When you will ask Cargo to install a virtual package (directly or not) in an image, Cargo will first search for package units providing the virtual package, filetering them by their platform requirements to only keep packages that can be installed. At the end, if only one package is detected, it is intalled. In case of many packages fullfill the requirements and provide the required virtual package, then Cargo will ask the user to choose which one to install.

Virtual packages allow to do not hard-code all possible dependencies and keep room to new platform-specific packages without modifying packages relying on them. On the other side, you should use virtual packages carefully because **all packages providing the same virtual package are intended to provide the same functionality with the same API**. Virtual packages are a kind of **contract** between providers and client. It is a good idea to express this contract in the description of the virtual package.

A virtual package, as any other Cargo package, has a version and has to be published (or, at least, saved to SCM) to be used.

Once the package metadata is correct, we save it to SCM.
Then, in a fresh image with Cargo already loaded, you can install *Grease-Tests*:
```smalltalk
Cargo new 
	useSourceRepository: (CGOGitRepository 
		repositoryUrl: 'git@github.com:demarey/Grease-cargo.git'
		subdirectory: 'repository');
	package: #'Grease-Tests' version: '1.4';
	install
```
It will result in loading following package in a Pharo 6.0 image: *Grease-Core*, *Grease-Pharo60-Core*, *Grease-Tests-Core* and *Grease-Tests-Pharo20-Core*.

![Grease-Tests loading with Cargo](/doc/grease-tests-loading.png)