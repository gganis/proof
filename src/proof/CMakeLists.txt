############################################################################
# CMakeLists.txt file for building ROOT proof/proof package
# @author Pere Mato, CERN
############################################################################

# ROOT_USE_PACKAGE(net/net)
# ROOT_USE_PACKAGE(tree/tree)
# ROOT_USE_PACKAGE(io/io)
# ROOT_USE_PACKAGE(core/thread)
include_directories(BEFORE ${ROOT_INCLUDE_DIR}) # To avoid circular dependencies :-(

ROOT_GLOB_HEADERS(headers RELATIVE ${CMAKE_CURRENT_SOURCE_DIR} *.h)
ROOT_GLOB_SOURCES(sources RELATIVE ${CMAKE_CURRENT_SOURCE_DIR} *.cxx)
# ROOT_GLOB_HEADERS(headers *.h)
# ROOT_GLOB_SOURCES(sources *.cxx)

#--- AliEn Dataset manager only if AliEn is available
if(alien)
  add_definitions(-DALIENDSMGR)
else()
  list(REMOVE_ITEM headers TDataSetManagerAliEn.h)
  list(REMOVE_ITEM sources TDataSetManagerAliEn.cxx)
endif()

message(STATUS "sources" ${sources})

#--- if gcc 4.5.2 on Linux (Debian) use -O instead of -O2 (compiler bug)
if(ROOT_PLATFORM MATCHES "linux" AND CMAKE_COMPILER_IS_GNUCXX AND 
   GCC_VERSION VERSION_GREATER 4.5 AND GCC_VERSION VERSION_LESS 4.6)
  set_source_files_properties(TDataSetManager.cxx TDSet.cxx PROPERTIES COMPILE_FLAGS "-O")
endif()

ROOT_GENERATE_DICTIONARY(G__Proof ${headers} LINKDEF LinkDef.h)
ROOT_GENERATE_ROOTMAP(Proof LINKDEF LinkDef.h DEPENDENCIES Net Tree Thread RIO MathCore)
ROOT_LINKER_LIBRARY(Proof ${sources} G__Proof.cxx DEPENDENCIES Net Tree Thread RIO MathCore)
ROOT_INSTALL_HEADERS()


