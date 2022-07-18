from setuptools import find_packages, setup

setup(name='bbref',
      version='0.1.0',
      description='Baseball Reference Data Pull',
      author='Dan Bliven',
      author_email='blivds06@gmail.com',
      packages=find_packages("support"),
      package_dir={"": "support"},
     )