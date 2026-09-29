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
   
   [Embed(source="/_assets/assets.swf", symbol="symbol1492")]
   public dynamic class shutDownAnim_fast extends MovieClip
   {
      
      public function shutDownAnim_fast()
      {
         super();
         addFrameScript(21,this.frame22);
      }
      
      internal function frame22() : *
      {
         this["parent"].triggerMe();
         stop();
      }
   }
}

