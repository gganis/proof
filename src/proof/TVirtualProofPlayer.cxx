// @(#)root/proof:$Id: TVirtualProofPlayer.cxx 21467 2007-12-18 17:44:44Z ganis $
// Author: Fons Rademakers   15/03/07

/*************************************************************************
 * Copyright (C) 1995-2007, Rene Brun and Fons Rademakers.               *
 * All rights reserved.                                                  *
 *                                                                       *
 * For the licensing terms see $ROOTSYS/LICENSE.                         *
 * For the list of contributors see $ROOTSYS/README/CREDITS.             *
 *************************************************************************/

//////////////////////////////////////////////////////////////////////////
//                                                                      //
// TVirtualProofPlayer                                                  //
//                                                                      //
// Abstract interface for the PROOF player.                             //
// See the concrete implementations under 'proofplayer' for details.    //
//                                                                      //
//////////////////////////////////////////////////////////////////////////

#include "TVirtualProofPlayer.h"
#include "TPluginManager.h"
#include "TROOT.h"
#include "TError.h"

//______________________________________________________________________________
TVirtualProofPlayer *TVirtualProofPlayer::Create(const char *player,
                                                 TProof *pr, TSocket *s)
{
   // Create a PROOF player.

   TPluginHandler *h;
   TVirtualProofPlayer *p = 0;

   if (!player || !*player) {
      ::Error("TVirtualProofPlayer::Create", "player name missing");
      return 0;
   }

   if ((h = gROOT->GetPluginManager()->FindHandler("TVirtualProofPlayer", player))) {
      if (h->LoadPlugin() == -1)
         return 0;
      if (!strcmp(player, "slave"))
         p = (TVirtualProofPlayer *) h->ExecPlugin(1, s);
      else
         p = (TVirtualProofPlayer *) h->ExecPlugin(1, pr);
   }

   return p;
}
