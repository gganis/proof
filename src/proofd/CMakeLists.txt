############################################################################
# CMakeLists.txt file for building ROOT proof/proofd package
# @author Pere Mato, CERN
############################################################################

# ROOT_USE_PACKAGE(proof)
# ROOT_USE_PACKAGE(net/rpdutils)
# ROOT_USE_PACKAGE(net/auth)

include_directories(${XROOTD_INCLUDE_DIR} ${ROOT_INCLUDE_DIR})
add_definitions(${XROOTD_CFLAGS})

# ROOT_EXECUTABLE(proofd proofd.cxx strlcat.c error.cxx net.cxx rpdutils.cxx
#                        LIBRARIES ${XROOTD_LIBRARIES} ${OPENSSL_LIBRARIES} ${CRYPTLIBS} )
ROOT_EXECUTABLE(xproofd X*.cxx rpdconn.cxx 
                        LIBRARIES ${XROOTD_LIBRARIES} ${SYSLIBS})
ROOT_LINKER_LIBRARY(XrdProofd X*.cxx rpdconn.cxx 
                        LIBRARIES ${XROOTD_LIBRARIES} ${CMAKE_THREAD_LIBS_INIT} ${CMAKE_DL_LIBS})
set_target_properties(XrdProofd PROPERTIES LINK_INTERFACE_LIBRARIES "" )

ROOT_INSTALL_HEADERS()
