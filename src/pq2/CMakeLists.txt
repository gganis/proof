
############################################################################
# CMakeLists.txt file for building ROOT pq2 package
# @author G. Ganis, CERN (following examples from P. Mato, CERN)
############################################################################

ROOT_GLOB_HEADERS(headers *.h)
ROOT_GLOB_SOURCES(sources *.cxx)

include_directories(${ROOT_INCLUDE_DIR})

ROOT_EXECUTABLE(pq2 ${sources} LIBRARIES ${ROOT_LIBRARIES})
#add_directory(${CMAKE_BINARY_DIR}/lib)
target_link_libraries(pq2 ${CMAKE_BINARY_DIR}/lib/libProof.so ${ROOT_LIBRARIES})