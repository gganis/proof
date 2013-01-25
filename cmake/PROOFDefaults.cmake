#-------------------------------------------------------------------------------
# Define the default build parameters
#-------------------------------------------------------------------------------

if( "${CMAKE_BUILD_TYPE}" STREQUAL "" )
  set( CMAKE_BUILD_TYPE RelWithDebInfo )
endif()

set ( CMAKE_INCLUDE_DIRECTORIES_PROJECT_BEFORE true )

# define_default( ENABLE_PERL     TRUE )
# define_default( ENABLE_FUSE     TRUE )
# define_default( ENABLE_CRYPTO   TRUE )
# define_default( ENABLE_KRB5     TRUE )
# define_default( ENABLE_READLINE TRUE )
