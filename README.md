![Image of Cargo](/cargo-picture-small.png)

# Cargo package manager [![Build Status](https://travis-ci.org/demarey/cargo.svg?branch=master)](https://travis-ci.org/demarey/cargo)

Cargo is a lightweitgh package manager for Smalltalk.

## What are the motivations behind Cargo?
* Dependencies expressed at the package level. We want that each package describes its own dependencies in a synthetic way.
* Dependencies as first-class objects, so that tools can use them to offer added value
* Better handling of platform-specific packages. In big project with a lot of dependencies that could be run on various platforms (e.g. Seaside), the description of platform-specific dependendies leads to wide specification, hard to maintain. Cargo tries to solve this problem by providing a low-coupling dependency to manage this kind of dependencies.
* Support update strategies through the use of semantic versionning
* Provide a central place to publis package versions and provide a web site on top of it to query on available packages (something similar to https://packagist.org/).

## Cargo big picture
![Cargo big picture](/doc/cargo-overview.png)

## Cargo basics
Cargo is a package manager. It automates the process of installing, upgrading and removing Smalltalk programs and libraries for a Smalltalk image in a consistent manner. A package manager deals with packages, distributions of software. Packages contain metadata, such as the software's name, description of its purpose, version number, vendor,  and a list of dependencies necessary for the software to run properly.
### Packages
Packages are the unit of distribution of a software. It is the minimal artefact you can load. Cargo defines 3 kind of packages:
* **package unit**: it represents a piece of code in a specific version. It has dependencies.
* **package assembly**: it represents a set of package units or package assemblies. It is useful to group a coherent set of packages all together. Assemblies do not have dependencies.
* **virtual package**: they are there to manage smoothly platform-specific packages. A virtual package has only a name. Some concrete packages (units) will provide them, some others will require them. They offer low-coupling in dependencies description but have to be used carefully (no specified contract, just rely on the package name). This concept comes from the [Debian distribution] (http://www.linuxtopia.org/online_books/linux_system_administration/debian_linux_guides/debian_linux_faq/ch-pkg_basics.en_007.html).
![Cargo packages](/doc/cargo-packages.png)

### Dependency description
With Cargo, dependencies are expressed at the package level (as well as other package metadata). It means each package knows its dependencies. 
There is a working copy of the dependencies within the package. It is part of the package metadata. This working copy of dependencies intend to be easy to manage: you mostly describe a dependency by refering to a package name (no specific version, assumes it refers to the package of the same name already in the image).
When you want to share a version of your package, you will publish it to the Cargo package repository so that it becomes available to anyone. During the publishing process, numberered (cargo) versions will be added to the dependencies to get reproducible loadings.

### Loading packages
You can ask Cargo to load one or many packages. Cargo will select adequate package versions according to your platform attributes and already installed packages. The package selection is called the solving of the user query. It results in getting back Cargo **load instructions** that is an object representing the list of packages to load in order.
Cargo load instructions are serializable so that they can be used for off-line loading for example.

### Updating packages
Cargo relies on [semantic versioning](http://semver.org/) to determine compatibility between versions of a package. It implies that **only a major version change could break the backward-compatibility** of a package. In other words, a patch version update (e.g. 1.2.0 => 1.2.1) or a minor version update (e.g. 1.2.1 => 1.3) should be compitable with packages working with the previous version. So, it is important that developers update the version number of a package with care by asking himself some questions: 
 * did I make incompatible API changes? If yes, a major version increment is needed.
 * did I introduce new functionalities without breaking backward-compatibility?. If yes, a minor version increment is needed.
 * did I fix a bug in a backward-compatible way? If yes, a patch version increment is needed.
In development mode, to avoid to publish a new package version to share your code with users or developers, you can use a special suffix (e.g. 2.1-dev) to tag a version as a development version. Cargo will allow you to override this version in the Cargo package repository. It means that you will be able to publish many times the same version with possibly different code.

## How to use Cargo?
Cargo comes with an API inspired by the one available in the latest versions of [Metacello](https://github.com/dalehenrich/metacello-work).

### Install Cargo
```smalltalk
Metacello new 
	repository: 'github://demarey/cargo/repository';
	baseline: 'Cargo';
	load: 'client'
```

### Load packages
### 

[](### List packages installed in the image)
[](### Update packages already installed)

##FAQ
###Where should I update my package dependencies?
Dependencies are part of package metadata. Package metadata is currently managed through a PackageManifest (a class in the package itself). You should not directly edit this class but use the Nautilus plugin to edit the metadata: select a package in Nautilus, open the contextual menu (right-click) and select "Browse package metadata ..."
The DependencyAnalyzer tool could also help to find the dependencies of a package. It is also available from Nautilus contextual menu on a package: "browse dependencies ..."
###Do I need to release and publish all packages of my project independently?
The anwser is no! It would be a tedious work to release all packages independently. Cargo comes with some tools to automatize the release and the publication of a set of packages.
###Do I need to specify a version number for all dependencies?
No, version number for dependencies are optional for the current working copy of the package metadata. More, it is recommanded to do not specify the version number but only describe the package you depend on. The version of a dependency is only required when you release a new version of your package. At this time, if no version is specified, Cargo will use the package version of the dependency currently in the image.
