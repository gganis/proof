#
# Try to find XROOTD
# Once done this will define
#
#  XROOTD_FOUND - system has XROOTD
#  XROOTD_INCLUDE_DIR - the XROOTD include directory
#  XROOTD_LIBRARIES - The libraries needed to use XROOTD
#  XROOTD_CFLAGS - Additional compilation flags (defines)
#  XROOTD_OLDPACK - old-style packaging for XROOTD libraries
#

if(XROOTD_XrdClient_LIBRARY AND XROOTD_INCLUDE_DIR)
  set(XROOTD_FIND_QUIETLY TRUE)
endif()

find_path(
  XROOTD_INCTMP_DIR
  NAMES XrdVersion.hh
   HINTS
     ${XROOTD_INC_DIR}
     ${XROOTD_ROOT_DIR}
     $ENV{XRDSYS}
     /opt/xrootd
     /usr/local
     /usr
   PATH_SUFFIXES
     include include/xrootd
)
set(XROOTD_INCLUDE_DIR ${XROOTD_INCTMP_DIR})

if (XROOTD_INCLUDE_DIR)
  file(STRINGS ${XROOTD_INCLUDE_DIR}/XrdVersion.hh xrdvers REGEX "^#define XrdVERSION")
  string(REGEX REPLACE "#define[ ]+XrdVERSION[ ]+" "" xrdvers ${xrdvers})
  string(REGEX REPLACE "[^v\\.]+" "" xrdversdots ${xrdvers})
  if (${xrdversdots} STREQUAL "v..")
    # Regular version string; parse it out
    string(REGEX MATCH "[0-9\\.]+" xrdvers ${xrdvers})
    string(REGEX MATCH "[0-9]" xrdversmajor ${xrdvers})
    string(REPLACE "${xrdversmajor}." "" xrdversminor ${xrdvers})
    string(REGEX MATCH "[0-9]" xrdversminor ${xrdversminor})
    string(REPLACE "${xrdversmajor}.${xrdversminor}." "" xrdverspatch ${xrdvers})
    string(REGEX MATCH "[0-9]+" xrdverspatch ${xrdverspatch})
    math(EXPR xrdversnum ${xrdversmajor}*100000000+${xrdversminor}*10000+${xrdverspatch})
  else ()
    # Old version string: we keep only the first numerics, i.e. the date
    string(REGEX REPLACE "[v\"]" "" xrdvers ${xrdvers})
    message(STATUS "Found Xrootd version ${xrdvers}")
    string(REGEX REPLACE "[^0-9-]+" " " xrdvers ${xrdvers})
    string(SUBSTRING ${xrdvers} 0 8 xrdversnum)
  endif ()
  # This we used as a compiler macro variable
  if(NOT XROOTD_FIND_QUIETLY )
    message(STATUS "Found Xrootd version num: ${xrdvers}")
  endif()
  SET(XROOTD_CFLAGS "-DROOTXRDVERS=${xrdversnum}")

  if ( ${xrdversnum} LESS 300010000 )
     SET(XROOTD_OLDPACK TRUE)
     message(STATUS "Setting OLDPACK TRUE")
  else()
     SET(XROOTD_OLDPACK FALSE)
  endif()

  # Check for additional headers
  if ( ${xrdversnum} LESS 20070723 )
     # Check for additional headers in old directories
     find_path(XROOTD_INCLUDE_DIR
        NAMES
        XrdNet/XrdNetDNS.hh
        XrdOuc/XrdOucError.hh
        XrdOuc/XrdOucLogger.hh
        XrdOuc/XrdOucPlugin.hh
        XrdOuc/XrdOucPthread.hh
        XrdOuc/XrdOucSemWait.hh
        XrdOuc/XrdOucTimer.hh
        ${XROOTD_INCLUDE_DIR}
     )
  else()
     if ( ${xrdversnum} LESS 300010000 )
        # DNS stuff was under XrdNet
        find_path(XROOTD_INCLUDE_DIR
           NAMES
           XrdNet/XrdNetDNS.hh
           ${XROOTD_INCLUDE_DIR}
        )
     else ()
        # DNS stuff is under XrdSys
        find_path(XROOTD_INCLUDE_DIR
           NAMES
           XrdSys/XrdSysDNS.hh
           ${XROOTD_INCLUDE_DIR}
        )
     endif ()

     if (XROOTD_INCLUDE_DIR)
        # Check for additional headers in new directories
        find_path(XROOTD_INCLUDE_DIR
            NAMES
            XrdSys/XrdSysError.hh
            XrdSys/XrdSysLogger.hh
            XrdSys/XrdSysPlugin.hh
            XrdSys/XrdSysPthread.hh
            XrdSys/XrdSysSemWait.hh
            XrdSys/XrdSysTimer.hh
            ${XROOTD_INCLUDE_DIR}
        )
     endif()
  endif()
  if (XROOTD_INCLUDE_DIR)
     SET(XROOTD_FOUND TRUE)
  else ()
     SET(XROOTD_FOUND FALSE)
  endif ()
else()
  SET(XROOTD_FOUND FALSE)
endif()

if(XROOTD_FOUND)
  # Search for the required libraries; this depends on packaging ...

  if(XROOTD_OLDPACK)
    foreach(l XrdNet XrdOuc XrdSys XrdClient Xrd)
      find_library(XROOTD_${l}_LIBRARY
         NAMES ${l} 
         PATHS ${XROOTD_LIB_DIR}
               ${XROOTD_ROOT_DIR}/lib64 ${XROOTD_ROOT_DIR}/lib
               $ENV{XRDSYS}/lib64 $ENV{XRDSYS}/lib
               /opt/xrootd/lib64 /opt/xrootd/lib
               /usr/local/lib64 /usr/local/lib
               /usr/lib64 /usr/lib)
      list(APPEND XROOTD_LIBRARIES ${XROOTD_${l}_LIBRARY})
    endforeach()

    if(${xrdversnum} GREATER 20100729)
      find_library(XROOTD_XrdNetUtil_LIBRARY
        NAMES XrdNetUtil
        PATHS ${XROOTD_LIB_DIR}
              ${XROOTD_ROOT_DIR}/lib64 ${XROOTD_ROOT_DIR}/lib
              $ENV{XRDSYS}/lib64 $ENV{XRDSYS}/lib
              /opt/xrootd/lib64 /opt/xrootd/lib
              /usr/local/lib64 /usr/local/lib
              /usr/lib64 /usr/lib)
      list(APPEND XROOTD_LIBRARIES ${XROOTD_XrdNetUtil_LIBRARY})
    endif ()
    execute_process(COMMAND dirname ${XROOTD_XrdNet_LIBRARY} OUTPUT_VARIABLE XROOTD_LIBRARY_DIR OUTPUT_STRIP_TRAILING_WHITESPACE)
  else()
    foreach(l XrdMain XrdUtils XrdClient)
      find_library(XROOTD_${l}_LIBRARY
         NAMES ${l} 
         PATHS ${XROOTD_LIB_DIR}
               ${XROOTD_ROOT_DIR}/lib64 ${XROOTD_ROOT_DIR}/lib
               $ENV{XRDSYS}/lib64 $ENV{XRDSYS}/lib
               /opt/xrootd/lib64 /opt/xrootd/lib
               /usr/local/lib64 /usr/local/lib
               /usr/lib64 /usr/lib)
      list(APPEND XROOTD_LIBRARIES ${XROOTD_${l}_LIBRARY})
    endforeach()
    execute_process(COMMAND dirname ${XROOTD_XrdMain_LIBRARY} OUTPUT_VARIABLE XROOTD_LIBRARY_DIR OUTPUT_STRIP_TRAILING_WHITESPACE)
  endif()

  find_package_handle_standard_args(
    XROOTD
    DEFAULT_MSG
    XROOT_INCLUDE_DIR XROOTD_LIBRARY_DIR)

#   if(XROOTD_LIBRARIES)
#     set(XROOTD_FOUND TRUE)
#     if(NOT XROOTD_FIND_QUIETLY )
#       message(STATUS "             include_dir: ${XROOTD_INCLUDE_DIR}")
#       message(STATUS "             libraries: ${XROOTD_LIBRARIES}")
#     endif() 
#   else ()
#     set(XROOTD_FOUND FALSE)
#   endif ()
endif()

mark_as_advanced(XROOTD_INCLUDE_DIR 
                 XROOTD_XrdMain_LIBRARY
                 XROOTD_XrdUtils_LIBRARY
                 XROOTD_XrdClient_LIBRARY
                 XROOTD_XrdNetUtils_LIBRARY
                 XROOTD_XrdNet_LIBRARY
                 XROOTD_XrdSys_LIBRARY
                 XROOTD_XrdOuc_LIBRARY
                 XROOTD_Xrd_LIBRARY )

