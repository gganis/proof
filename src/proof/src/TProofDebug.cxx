// @(#)root/proof:$Id: TProofDebug.cxx 20882 2007-11-19 11:31:26Z rdm $
// Author: Maarten Ballintijn 19/6/2002

/*************************************************************************
 * Copyright (C) 1995-2000, Rene Brun and Fons Rademakers.               *
 * All rights reserved.                                                  *
 *                                                                       *
 * For the licensing terms see $ROOTSYS/LICENSE.                         *
 * For the list of contributors see $ROOTSYS/README/CREDITS.             *
 *************************************************************************/

//////////////////////////////////////////////////////////////////////////
//                                                                      //
// TProofDebug                                                          //
//                                                                      //
// Detailed logging / debug scheme.                                     //
//                                                                      //
//////////////////////////////////////////////////////////////////////////


#include "TProofDebug.h"

TProofDebug::EProofDebugMask gProofDebugMask = TProofDebug::kAll;
Int_t gProofDebugLevel = 0;
