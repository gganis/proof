// @(#)root/proofx:$Id: TXHandler.h 30815 2009-10-20 13:49:22Z rdm $
// Author: G. Ganis Mar 2006

/*************************************************************************
 * Copyright (C) 1995-2006, Rene Brun and Fons Rademakers.               *
 * All rights reserved.                                                  *
 *                                                                       *
 * For the licensing terms see $ROOTSYS/LICENSE.                         *
 * For the list of contributors see $ROOTSYS/README/CREDITS.             *
 *************************************************************************/

#ifndef ROOT_TXHandler
#define ROOT_TXHandler

//////////////////////////////////////////////////////////////////////////
//                                                                      //
// TXHandler                                                            //
//                                                                      //
// Handler of asynchronous events for xproofd sockets.                  //
// Classes which need this should inherit from it and overload the      //
// relevant methods.                                                    //
//                                                                      //
//////////////////////////////////////////////////////////////////////////

#ifndef ROOT_Rtypes
#include "Rtypes.h"
#endif


class TXHandler {

public:
   TXHandler() { }
   virtual ~TXHandler() { }

   virtual Bool_t HandleInput(const void *in = 0);
   virtual Bool_t HandleError(const void *in = 0);

   ClassDef(TXHandler, 0) //Template class for handling of async events
};

#endif
