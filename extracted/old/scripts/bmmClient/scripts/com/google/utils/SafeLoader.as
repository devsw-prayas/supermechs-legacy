package com.google.utils
{
   import flash.display.Loader;
   import flash.net.URLRequest;
   import flash.system.LoaderContext;
   import flash.utils.ByteArray;
   
   public class SafeLoader extends Loader
   {
      
      public static var uncaughtErrorEventHandler:Function;
      
      private var disableLoaderContext:Boolean;
      
      public function SafeLoader(param1:Boolean = false)
      {
         super();
         this.disableLoaderContext = param1;
         if(uncaughtErrorEventHandler != null && hasOwnProperty("uncaughtErrorEvents"))
         {
            Object(this).uncaughtErrorEvents.addEventListener("uncaughtError",uncaughtErrorEventHandler,false,-1);
         }
      }
      
      override public function loadBytes(param1:ByteArray, param2:LoaderContext = null) : void
      {
         throw new SecurityError();
      }
      
      override public function load(param1:URLRequest, param2:LoaderContext = null) : void
      {
         if(disableLoaderContext)
         {
            super.load(param1,new LoaderContext(false));
         }
         else
         {
            super.load(param1,param2);
         }
      }
   }
}

