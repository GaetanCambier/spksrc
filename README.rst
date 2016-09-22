spksrc
======
spksrc is a cross compilation framework intended to compile and package software for Synology NAS devices. Packages are made available via the `SynoCommunity repository`_.

Requirements
------------
To use spksrc, it is recommended to use a virtual machine with an x86, 32-bit version of Debian stable OS installed. Non-x86 architectures or 64-bit architectures are not supported.

You'll also need some stuff::

    sudo apt-get install build-essential debootstrap python-pip automake libgmp3-dev libltdl-dev libunistring-dev libffi-dev libncurses5-dev imagemagick libssl-dev pkg-config zlib1g-dev gettext git curl subversion check libboost1.55-tools-dev intltool gperf flex bison xmlto php5 expect libgc-dev mercurial cython lzip cmake swig
    sudo pip install -U setuptools pip wheel httpie

You may need to install some packages from testing like autoconf. Read about Apt-Pinning to know how to do that.

You are now ready to use spksrc and make almost all SPKs. If you have any problem, try installing the
missing packages on your virtual machine.

Usage
-----
Lets start with an example::

    git clone https://github.com/SynoCommunity/spksrc.git
    cd spksrc/
    make setup
    cd spk/transmission
    make arch-88f6281

What have I done?
^^^^^^^^^^^^^^^^^

Contributing
------------
Before opening issues or package requests, see `CONTRIBUTING`_.


Setup Development Environment
-----------------------------
Docker
^^^^^^
* Fork and clone spksrc: ``git clone https://You@github.com/You/spksrc.git ~/spksrc``
* Install Docker on your host OS: `Docker installation`_. A wget-based alternative for linux: `Install Docker with wget`_.
* Download the spksrc docker container: ``docker pull synocommunity/spksrc``
* Run the container with ``docker run -it -v ~/spksrc:/spksrc synocommunity/spksrc /bin/bash``


Virtual machine
^^^^^^^^^^^^^^^
A virtual machine based on an 64-bit version of Debian stable OS is recommended. Non-x86 architectures are not supported.

* Install the requirements::

    sudo dpkg --add-architecture i386 && sudo apt-get update
    sudo aptitude install build-essential debootstrap python-pip automake libgmp3-dev libltdl-dev libunistring-dev libffi-dev libcppunit-dev ncurses-dev imagemagick libssl-dev pkg-config zlib1g-dev gettext git curl subversion check intltool gperf flex bison xmlto php5 expect libgc-dev mercurial cython lzip cmake swig libc6-i386
    sudo pip install -U setuptools pip wheel httpie

* You may need to install some packages from testing like autoconf. Read about Apt-Pinning to know how to do that.
* Some older toolchains may require 32-bit development versions of packages, e.g. `zlib1g-dev:i386`


For further instructions, refer to Pull Requests section of `CONTRIBUTING`_.

