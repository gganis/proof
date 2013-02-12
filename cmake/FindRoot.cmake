include( FindPackageHandleStandardArgs )

if( ROOT_INCLUDE_DIRS AND ROOT_LIBRARIES )

  set( ROOT_FOUND TRUE )

else()

  #
  # Search for root-config
  #

   find_program(Root_CONFIG
       NAMES root-config
       PATHS ${ROOT_ROOT_DIR}/bin
   )

   if (NOT Root_CONFIG)
      set (Root_FOUND FALSE)
      if (Root_FIND_REQUIRED)
          message (FATAL_ERROR "root-config not found, is ROOT installed under ${ROOT_ROOT_DIR}?")
       endif ()
   else ()
      message (STATUS "[ROOT] root-config path: ${Root_CONFIG}")
   endif ()

   #
   # Some ROOT build options
   #
   execute_process(COMMAND ${Root_CONFIG} --version OUTPUT_VARIABLE ROOT_VERSION OUTPUT_STRIP_TRAILING_WHITESPACE)

  find_path(
    ROOT_INCLUDE_DIR
    NAMES RVersion.h
    HINTS
    ${ROOT_ROOT_DIR}
    PATH_SUFFIXES
    include )
  set( ROOT_INCLUDE_DIRS ${ROOT_INCLUDE_DIR})

#   find_library(
#     ROOT_LIBRARY
#     NAMES Hist Matrix Tree RIO Net Thread MathCore Core Caz
#     HINTS
#     ${ROOT_ROOT_DIR}
#     PATH_SUFFIXES lib64
#     ${LIBRARY_PATH_PREFIX}
#     ${LIB_SEARCH_OPTIONS})
#   set( ROOT_LIBRARIES ${ROOT_LIBRARY} )

  foreach(l Hist Matrix Tree RIO Net Thread MathCore Core)
    find_library(ROOT_${l}_LIBRARY
       NAMES ${l} 
       HINTS
       ${ROOT_ROOT_DIR}
       PATH_SUFFIXES lib64
       ${LIBRARY_PATH_PREFIX}
       ${LIB_SEARCH_OPTIONS})
    list(APPEND ROOT_LIBRARIES ${ROOT_${l}_LIBRARY})
  endforeach()
  execute_process(COMMAND dirname ${ROOT_Core_LIBRARY} OUTPUT_VARIABLE ROOT_LIBRARY_DIR OUTPUT_STRIP_TRAILING_WHITESPACE)

  find_package_handle_standard_args(
    ROOT
    DEFAULT_MSG
    ROOT_INCLUDE_DIR ROOT_LIBRARY_DIR)

   mark_as_advanced( ROOT_INCLUDE_DIR ROOT_LIBRARIES ROOT_LIBRARY_DIR)
endif()
