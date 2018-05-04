Builds a Docker image based on `debian:stable` which includes the Matlab Runtime.

Sets these env variables:

  *  `MATLAB_INSTALL`: Location of Matlab install
  *  `MATLAB_LD_LIBRARY_PATH`:  Value of LD_LIBRARY_PATH that must be used to find Matlab libs

  * ~~`MCR_CACHE_VERBOSE`~~ Unset (used to be set to `true`)
  * `MCR_CACHE_ROOT`: Set to `/tmp`


Common tasks are in the `Makefile`.
