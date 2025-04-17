====================================
佛教比丘戒律(Buddhist Monastic Code)
====================================

.. image:: https://github.com/siongui/vinaya-bmc-zh/workflows/Pelican%20site%20CI/badge.svg
    :target: https://github.com/siongui/vinaya-bmc-zh/blob/master/.github/workflows/pelican.yml

Development Tool: Pelican_ (static site generator written in Python)

Development Environment: `Ubuntu 22.04`_


First-time Setup
----------------

1. On a fresh/clean installation of Ubuntu, update system first. Otherwise will
   get unable to locate package error.
   See `this SO answer <https://stackoverflow.com/a/58072486>`__.

   .. code-block:: bash

     $ sudo apt-get update

2. Install git_ and pip_:

   .. code-block:: bash

     $ sudo apt-get install git
     $ sudo apt-get install python3-pip

   From the `answer in Ask Ubuntu <https://askubuntu.com/a/1031733>`_,
   we can use python-is-python3 and prevent Python 2 from being installed
   on Ubuntu 20.04

   .. code-block:: bash

     $ sudo apt-get install python-is-python3
     $ sudo apt-mark hold python2 python2-minimal python2.7 python2.7-minimal libpython2-stdlib libpython2.7-minimal libpython2.7-stdlib

3. Install language packages to add locale (English, Traditional Chinese, and
   Thai in this example):

   .. code-block:: bash

     $ sudo apt-get install language-pack-en
     $ sudo apt-get install language-pack-zh-hant
     $ sudo apt-get install language-pack-th

   Or you can install languages in "Settings" -> "Region & Language", which
   installs more related packages such as fonts for languages.

4. git clone source code:

   .. code-block:: bash

     $ cd
     $ mkdir dev
     $ cd ~/dev/
     $ git clone https://github.com/siongui/vinaya-bmc-zh.git --depth=1
     # or clone with full depth
     $ git clone https://github.com/siongui/vinaya-bmc-zh.git YOUR_REPO

5. Install Python tools:

   .. code-block:: bash

     $ cd ~/dev/YOUR_REPO/
     $ pip3 install -r requirements.txt

6. Install Pelican `i18n_subsites`_ plugin:

   .. code-block:: bash

     $ cd ~/dev/YOUR_REPO/
     $ make download

7. Generate CSS file:

   .. code-block:: bash

     $ cd ~/dev/YOUR_REPO/
     $ make scss


Daily Development
-----------------

.. code-block:: bash

    # start edit and develope
    $ cd ~/dev/YOUR_REPO/
    # re-generate the website and start dev server
    $ make
    # open your browser and preview the website at http://localhost:8000/


References
----------

.. [1] `Buddhist Monastic Code <https://www.dhammatalks.org/vinaya/bmc/Section0000.html>`_


.. _Pelican: https://blog.getpelican.com/
.. _Ubuntu 22.04: https://releases.ubuntu.com/22.04/
.. _git: https://git-scm.com/
.. _pip: https://pypi.python.org/pypi/pip
.. _i18n_subsites: https://github.com/getpelican/pelican-plugins/tree/master/i18n_subsites
