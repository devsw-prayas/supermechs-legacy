package com.supermechs.generalLibrary
{
   import adobe.utils.*;
   import flash.accessibility.*;
   import flash.desktop.*;
   import flash.display.*;
   import flash.errors.*;
   import flash.events.*;
   import flash.external.*;
   import flash.filters.*;
   import flash.geom.*;
   import flash.globalization.*;
   import flash.media.*;
   import flash.net.*;
   import flash.net.drm.*;
   import flash.printing.*;
   import flash.profiler.*;
   import flash.sampler.*;
   import flash.sensors.*;
   import flash.system.*;
   import flash.text.*;
   import flash.text.engine.*;
   import flash.text.ime.*;
   import flash.ui.*;
   import flash.utils.*;
   import flash.xml.*;
   import net.tacticsoft.mobileOpt.BMUncachedMovieClip;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol1530")]
   public dynamic class glowOrange extends BMUncachedMovieClip
   {
      
      public function glowOrange()
      {
         super();
         addFrameScript(9,this.frame10);
      }
      
      internal function frame10() : *
      {
         stop();
         if(this["parent"] != null)
         {
            this["parent"].removeMe();
         }
      }
   }
}

