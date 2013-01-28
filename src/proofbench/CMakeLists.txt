
############################################################################
# CMakeLists.txt file for building ROOT proofbench package
# @author G. Ganis, CERN (following examples from P. Mato, CERN)
############################################################################

ROOT_GLOB_HEADERS(headers *.h)
list(REMOVE_ITEM headers ${CMAKE_CURRENT_SOURCE_DIR}/TSelEvent.h ${CMAKE_CURRENT_SOURCE_DIR}/TSelEventGen.h)

ROOT_GLOB_SOURCES(sources *.cxx)
list(REMOVE_ITEM sources ${CMAKE_CURRENT_SOURCE_DIR}/TSelEvent.cxx ${CMAKE_CURRENT_SOURCE_DIR}/TSelEventGen.cxx)

include_directories(BEFORE ../proof ../proofplayer ${ROOT_INCLUDE_DIR})

ROOT_GENERATE_DICTIONARY(G__ProofBench ${headers} LINKDEF LinkDef.h)
ROOT_GENERATE_ROOTMAP(ProofBench LINKDEF LinkDef.h DEPENDENCIES Proof ProofDraw ProofPlayer Tree Hist Gpad RIO )
ROOT_LINKER_LIBRARY(ProofBench ${sources} G__ProofBench.cxx DEPENDENCIES Proof ProofDraw ProofPlayer Tree Hist Gpad RIO )

# We miss the creation of PAR files

ROOT_INSTALL_HEADERS()
