spksrc
======
spksrc is a cross compilation framework intended to compile and package softwares for Synology NAS

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

* You cloned the repository
* Went into the directory of the SPK for transmission
* Started building the SPK for the architecture 88f6281

  * To list all available architectures use ``ls toolchains`` from within the ``spksrc`` directory. Remove the prefix syno- to have the actual architecture.
  * An overview of which architecture is used per Synology model can be found on the wiki page `Architecture per Synology model`_

At the end of the process, the SPK will be available in ``spksrc/packages/``

What is spksrc doing?
^^^^^^^^^^^^^^^^^^^^^

* First spksrc will read ``spksrc/spk/transmission/Makefile``
* Download the adequate toolchain for the chosen architecture
* Recursively:

  * Process dependencies if any
  * Download the source in ``spksrc/distrib/``
  * Extract the source
  * ``configure``
  * ``make``
  * ``make install``

* Package all the requirements into a SPK under ``spksrc/packages/``:

  * Binaries
  * Installer script
  * Start/Stop/Status script
  * Package icon
  * Wizards (optional)
  * Help files (optional)

Contribute
----------
The only thing you should be editing in spksrc is Makefiles. To make a SPK, start by cross-compiling
the underlying package. To do so:

* Copy a standard cross package like ``spksrc/cross/transmission/Makefile``
  in your new package directory ``spksrc/cross/newpackage/``
* Edit the Makefile variables so it fits your new package
* Empty variables ``DEPENDS`` and ``CONFIGURE_ARGS`` in the Makefile
* Try to cross-compile and fix issues as they come (missing dependencies, configure arguments, patches)

  * ``cd spksrc/cross/newpackage/``
  * ``make arch-88f6281``
  * Use ``make clean`` to clean up the whole working directory after a failed attempt
  
* On a successful cross-compilation create a PLIST file with the same syntax as
  ``spksrc/cross/transmission/PLIST`` but based on the auto-generated PLIST for your
  new package at ``spksrc/cross/newpackage/work-88f6281/newpackage.plist``

Once you have successfully cross compiled the new package, to create the SPK:

* Copy a standard SPK directory like ``spksrc/spk/transmission``
  in your new SPK directory ``spksrc/spk/newspk``
* Edit the stuff to fit your needs

After all that hard work, submit a pull request to have your work merged with the main repository
on GitHub and published in `SynoCommunity's repository`_.

If you are not familiar with git or GitHub, please refer to the excellent `GitHub help pages`_.

