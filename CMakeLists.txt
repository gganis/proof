#-------------------------------------------------------------------------------
# Project description
#-------------------------------------------------------------------------------
cmake_minimum_required( VERSION 2.6 )
project( PROOF )

set( CMAKE_MODULE_PATH
 ${PROJECT_SOURCE_DIR}/src
 ${PROJECT_SOURCE_DIR}/cmake )

include( PROOFUtils )
CheckBuildDirectory()

include( PROOFOSDefs )
include( PROOFDefaults )
# include( PROOFSystemCheck )
# include( PROOFFindLibs )
include(RootNewMacros)

set (alien FALSE)

#-------------------------------------------------------------------------------
# VOMS Libs required
#-------------------------------------------------------------------------------
find_package( Root REQUIRED)
find_package( XRootD REQUIRED)

#-------------------------------------------------------------------------------
# Build in subdirectories
#-------------------------------------------------------------------------------
add_subdirectory( src )
 
#-------------------------------------------------------------------------------
# Summary
#-------------------------------------------------------------------------------
message( STATUS "----------------------------------------" )
message( STATUS "Installation path: " ${CMAKE_INSTALL_PREFIX} )
message( STATUS "Build type:        " ${CMAKE_BUILD_TYPE} )
message( STATUS "ROOT Version:      " ${ROOT_VERSION} )
message( STATUS "ROOT include path: " ${ROOT_INCLUDE_DIR} )
message( STATUS "ROOT library path: " ${ROOT_LIBRARY_DIR} )
message( STATUS "XRootD include path: " ${XROOTD_INCLUDE_DIR} )
message( STATUS "XRootD library path: " ${XROOTD_LIBRARY_DIR} )
message( STATUS "----------------------------------------" )

