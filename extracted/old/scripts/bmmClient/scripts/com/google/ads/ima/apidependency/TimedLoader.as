package com.google.ads.ima.apidependency
{
   import com.google.utils.SafeLoader;
   import com.google.utils.Trace;
   import flash.net.URLRequest;
   import flash.system.LoaderContext;
   
   public class TimedLoader extends SafeLoader
   {
      
      private var resourceLoadLogger:ResourceLoadLogger;
      
      public function TimedLoader(param1:ResourceLoadLogger = null)
      {
         super();
         Trace.traceUncaughtErrors(this);
         if(param1 == null)
         {
            param1 = new ResourceLoadLogger(contentLoaderInfo);
         }
         this.resourceLoadLogger = param1;
      }
      
      override public function load(param1:URLRequest, param2:LoaderContext = null) : void
      {
         resourceLoadLogger.aboutToLoad(param1);
         doActualLoad(param1,param2);
      }
      
      protected function doActualLoad(param1:URLRequest, param2:LoaderContext = null) : void
      {
         super.load(param1,param2);
      }
   }
}

