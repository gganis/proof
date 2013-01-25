#-------------------------------------------------------------------------------
# Define the OS variables
#-------------------------------------------------------------------------------

include( CheckCXXSourceRuns )

set( Linux    FALSE )
set( MacOSX   FALSE )

add_definitions( -D_LARGEFILE_SOURCE -D_LARGEFILE64_SOURCE -D_FILE_OFFSET_BITS=64 )
set( LIBRARY_PATH_PREFIX "lib" )

#-------------------------------------------------------------------------------
# Linux
#-------------------------------------------------------------------------------
if( ${CMAKE_SYSTEM_NAME} STREQUAL "Linux" )
  set( Linux TRUE )
  include( GNUInstallDirs )
  add_definitions( -D__linux__=1 )
  set( EXTRA_LIBS rt )
endif()

#-------------------------------------------------------------------------------
# MacOSX
#-------------------------------------------------------------------------------
if( APPLE )
  set( MacOSX TRUE )
  add_definitions( -D__macos__=1 )
  add_definitions( -DLT_MODULE_EXT=".dylib" )
  set( CMAKE_INSTALL_LIBDIR "lib" )
  set( CMAKE_INSTALL_BINDIR "bin" )
  set( CMAKE_INSTALL_MANDIR "man" )
  set( CMAKE_INSTALL_INCLUDEDIR "include" )
  set( CMAKE_INSTALL_DATADIR "share" )
endif()

