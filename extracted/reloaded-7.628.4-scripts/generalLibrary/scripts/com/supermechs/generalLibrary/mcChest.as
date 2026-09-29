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
   
   [Embed(source="/_assets/assets.swf", symbol="symbol1355")]
   public dynamic class mcChest extends BMUncachedMovieClip
   {
      
      public function mcChest()
      {
         super();
         addFrameScript(0,this.frame1,84,this.frame85);
      }
      
      internal function frame1() : *
      {
         stop();
      }
      
      internal function frame85() : *
      {
         stop();
         this["parent"].chestOpened();
      }
   }
}

