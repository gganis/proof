/* @(#)src/proof:$Id */

/*************************************************************************
 * Copyright (C) 1995-2000, Rene Brun and Fons Rademakers.               *
 * All rights reserved.                                                  *
 *                                                                       *
 * For the licensing terms see $ROOTSYS/LICENSE.                         *
 * For the list of contributors see $ROOTSYS/README/CREDITS.             *
 *************************************************************************/

#ifndef ROOT_ProofProtocol
#define ROOT_ProofProtocol


//////////////////////////////////////////////////////////////////////////
//                                                                      //
// ProofProtocol                                                        //
//                                                                      //
// Message types defining the PROOF protocol.                           //
// The message type is the fWhat field of the TBuffer derived TMessage. //
//                                                                      //
//////////////////////////////////////////////////////////////////////////

namespace PROOF {

enum EProofProtocol {

   //---- PROOF message opcodes (1000 - 1999)
   kPROOF_GROUPVIEW      = 1000,         //groupview follows
   kPROOF_STOP           = 1001,         //stop proof server
   kPROOF_FATAL          = 1002,         //server got fatal error and died
   kPROOF_LOGLEVEL       = 1003,         //loglevel follows
   kPROOF_LOGFILE        = 1004,         //log file length and content follows
   kPROOF_LOGDONE        = 1005,         //log file received, status follows
   kPROOF_STATUS         = 1006,         //print status of worker - (OBSOLETE Message)
   kPROOF_PING           = 1007,         //ping worker
   kPROOF_PRINT          = 1008,         //ask master to print config
   kPROOF_RESET          = 1009,         //reset worker
   kPROOF_GETOBJECT      = 1010,         //ask for object with given name
   kPROOF_GETPACKET      = 1011,         //ask for next packet
   kPROOF_CHECKFILE      = 1012,         //filename and md5 follows
   kPROOF_SENDFILE       = 1013,         //filename, length and file follows
   kPROOF_PARALLEL       = 1014,         //number of parallel workers follows
   kPROOF_PROCESS        = 1015,         //process events, DSet and input list follow
   kPROOF_OUTPUTLIST     = 1016,         //return the output list from Process()
   kPROOF_AUTOBIN        = 1017,         //callback for auto binning
   kPROOF_CACHE          = 1018,         //cache and package handling messages
   kPROOF_GETENTRIES     = 1019,         //report back number of entries to master
   kPROOF_PROGRESS       = 1020,         //event loop progress
   kPROOF_FEEDBACK       = 1021,         //intermediate version of objects
   kPROOF_STOPPROCESS    = 1022,         //stop or abort the current process call
   kPROOF_HOSTAUTH       = 1023,         //HostAuth info follows
   kPROOF_GETSLAVEINFO   = 1024,         //get worker info from master
   kPROOF_GETTREEHEADER  = 1025,         //get tree object
   kPROOF_GETOUTPUTLIST  = 1026,         //get the output list
   kPROOF_GETSTATS       = 1027,         //get statistics of workers
   kPROOF_GETPARALLEL    = 1028,         //get number of parallel workers
   kPROOF_VALIDATE_DSET  = 1029,         //validate a TDSet
   kPROOF_DATA_READY     = 1030,         //ask if the data is ready on nodes
   kPROOF_QUERYLIST      = 1031,         //ask/send the list of queries
   kPROOF_RETRIEVE       = 1032,         //asynchronous retrieve of query results
   kPROOF_ARCHIVE        = 1033,         //archive query results
   kPROOF_REMOVE         = 1034,         //remove query results from the lists
   kPROOF_STARTPROCESS   = 1035,         //signals the start of query processing
   kPROOF_SETIDLE        = 1036,         //signals idle state of session
   kPROOF_QUERYSUBMITTED = 1037,         //signals querysubmission
   kPROOF_SESSIONTAG     = 1038,         //message with unique session tag
   kPROOF_MAXQUERIES     = 1039,         //message with max number of queries
   kPROOF_CLEANUPSESSION = 1040,         //cleanup session query area
   kPROOF_SERVERSTARTED  = 1041,         //signal completion of a server startup
   kPROOF_DATASETS       = 1042,         //dataset management
   kPROOF_PACKAGE_LIST   = 1043,         //a list of package names (TObjString's) follows
   kPROOF_MESSAGE        = 1044,         //a message for the client follows
   kPROOF_LIB_INC_PATH   = 1045,         //a list of lib/inc paths follows
   kPROOF_WORKERLISTS    = 1046,         //an action on any of the worker list follows
   kPROOF_DATASET_STATUS = 1047,         //status of data set preparation before processing
   kPROOF_OUTPUTOBJECT   = 1048,         //output object follows
   kPROOF_SETENV         = 1049,         //buffer with env vars to set
   kPROOF_REALTIMELOG    = 1050,         //switch on/off real-time retrieval of log messages
   kPROOF_VERSARCHCOMP   = 1051,         //String with worker version/architecture/compiler follows
   kPROOF_ENDINIT        = 1052,         //signals end of initialization on worker
   kPROOF_TOUCH          = 1053,         //touch the client admin file
   kPROOF_FORK           = 1054,         //ask the worker to clone itself
   kPROOF_GOASYNC        = 1055,         //switch to asynchronous mode
   kPROOF_SUBMERGER      = 1056,         //sub-merger based approach in finalization
};
}
#endif
