############################################################################
# CMakeLists.txt file for building ROOT proof/proofplayer package
# @author Pere Mato, CERN
############################################################################

# ROOT_USE_PACKAGE(proof)
# ROOT_USE_PACKAGE(tree/treeplayer)
include_directories(BEFORE ${ROOT_INCLUDE_DIR} ../proof) # To avoid circular dependencies :-(

ROOT_GLOB_HEADERS(headers *.h)
list(REMOVE_ITEM headers ${CMAKE_CURRENT_SOURCE_DIR}/TProofDraw.h
                         ${CMAKE_CURRENT_SOURCE_DIR}/LinkDef.h
                         ${CMAKE_CURRENT_SOURCE_DIR}/LinkDefDraw.h)

ROOT_GLOB_SOURCES(sources *.cxx)
list(REMOVE_ITEM sources ${CMAKE_CURRENT_SOURCE_DIR}/TProofDraw.cxx)


ROOT_GENERATE_DICTIONARY(G__ProofPlayer ${headers} LINKDEF LinkDef.h)
ROOT_GENERATE_ROOTMAP(ProofPlayer LINKDEF LinkDef.h DEPENDENCIES  Proof Hist RIO Tree Net Thread MathCore)
ROOT_LINKER_LIBRARY(ProofPlayer ${sources} G__ProofPlayer.cxx DEPENDENCIES Proof Hist RIO Tree Net Thread MathCore)

ROOT_GENERATE_DICTIONARY(G__ProofDraw TProofDraw.h LINKDEF LinkDefDraw.h)
ROOT_GENERATE_ROOTMAP(ProofDraw LINKDEF LinkDefDraw.h DEPENDENCIES  ProofPlayer TreePlayer)
ROOT_LINKER_LIBRARY(ProofDraw TProofDraw.cxx G__ProofDraw.cxx DEPENDENCIES ProofPlayer TreePlayer)

ROOT_INSTALL_HEADERS()



