Git Integrity Checks
====================

Various bash scripts that audit GitHub repos and installations to ensure
integrity.

Written by Micheas Herman <http://github.com/micheas>

Some modifications by R.J. Keller <http://github.com/rjkeller>

Usage
=====

Calling integrity-check.sh will return a status of 0 if the repository 
has no changes inside of version control and the repository is on the 
highest numbered tag. Otherwise it will return a status code of 1.
