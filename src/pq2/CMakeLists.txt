
############################################################################
# CMakeLists.txt file for building ROOT pq2 package
# @author G. Ganis, CERN (following examples from P. Mato, CERN)
############################################################################

ROOT_GLOB_HEADERS(headers *.h)
ROOT_GLOB_SOURCES(sources *.cxx)

include_directories(${ROOT_INCLUDE_DIR})

ROOT_EXECUTABLE(pq2 ${sources} LIBRARIES Proof Hist Matrix Tree RIO Net Thread MathCore Core)
