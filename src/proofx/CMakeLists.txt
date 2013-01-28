
############################################################################
# CMakeLists.txt file for building ROOT proof/proofx package
# @author Pere Mato, CERN
############################################################################

# ROOT_USE_PACKAGE(proofd)
# ROOT_USE_PACKAGE(proofplayer)

  ROOT_GLOB_HEADERS(headers *.h)
  ROOT_GLOB_SOURCES(sources *.cxx)

include_directories(BEFORE ../proof ../proofd ${XROOTD_INCLUDE_DIR} ${ROOT_INCLUDE_DIR})
link_directories(${XROOTD_LIBRARY_DIR})
add_definitions(${XROOTD_CFLAGS})

ROOT_GENERATE_DICTIONARY(G__Proofx ${headers} LINKDEF LinkDef.h)
ROOT_GENERATE_ROOTMAP(Proofx LINKDEF LinkDef.h DEPENDENCIES Net Proof Thread)
ROOT_LINKER_LIBRARY(Proofx ${sources} G__Proofx.cxx LIBRARIES ${XROOTD_LIBRARIES} XrdProofd DEPENDENCIES Net Proof Thread )

ROOT_INSTALL_HEADERS()
