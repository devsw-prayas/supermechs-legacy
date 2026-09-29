package net.battleMechsMulti.screens.loadExternalLibrary
{
   import com.greensock.TweenMax;
   import flash.events.Event;
   import flash.text.TextField;
   import net.battleMechsMulti.managers.BMScreensManager;
   import net.battleMechsMulti.mobiles.BMBar;
   import net.battleMechsMulti.mobiles.buttons.BMBasicButton;
   import net.battleMechsMulti.screens.BMBaseScreen;
   import net.battleMechsMulti.utils.TextUtils;
   
   public class BMScreenLoadExternalLibrary extends BMBaseScreen
   {
      
      public var btnOK:BMBasicButton;
      
      public var txtTitle:TextField;
      
      public var txtDesc:TextField;
      
      public var txtLoadingInfo:TextField;
      
      public var mcBar:BMBar;
      
      private var _callback:Function;
      
      private var _bytesTotal:Number = 0;
      
      public function BMScreenLoadExternalLibrary()
      {
         super();
      }
      
      public function initialize() : void
      {
         generateSingletonClassesPointers();
         setLanguageManagerScreenName("loadExternalLibrary");
         this.mcBar.initialize(BMBar.COLOR_BLUE);
         this.mcBar.addSeparateorLines(5);
         this.mcBar.setFill(0);
         updateTextAndFormat(this.txtTitle,getScreenText("title"));
         var _loc1_:String = getScreenText("desc");
         var _loc2_:String = String(dataM.getGeneralSetting("externalLibrarySwfSize","1MB"));
         _loc1_ = dataM.replaceStringInText(_loc1_,"%NICKNAME%",dataM.myProfile.playerName);
         _loc1_ = dataM.replaceStringInText(_loc1_,"%SIZE%",_loc2_);
         updateTextAndFormat(this.txtDesc,_loc1_);
         updateTextAndFormat(this.txtLoadingInfo,"");
         this.btnOK.visible = false;
         this.startDownload();
      }
      
      public function setCallback(param1:Function) : void
      {
         this._callback = param1;
      }
      
      private function okClicked(param1:Event) : void
      {
         this.btnOK.disableMe();
         this.startDownload();
      }
      
      private function startDownload() : void
      {
         externalAssetsM.loadExternalLibrary(this.onExternalAssetsLoadProgress,this.onExternalAssetsLoadComplete);
      }
      
      private function onExternalAssetsLoadProgress(param1:Number, param2:Number) : void
      {
         if(this._bytesTotal == 0)
         {
            this._bytesTotal = param2;
         }
         var _loc3_:Number = Math.ceil(param1 / param2 * 100);
         _loc3_ = Math.max(0,_loc3_);
         _loc3_ = Math.min(100,_loc3_);
         this.mcBar.setFill(_loc3_,true);
         var _loc4_:String = TextUtils.getNumberWithComma(param1) + " / " + TextUtils.getNumberWithComma(param2) + " bytes";
         this.txtLoadingInfo.text = _loc4_;
         screensM.createMultipleTextsBitmap("loadExternalLibrary_loadingInfo",[this.txtLoadingInfo],"",this);
      }
      
      private function onExternalAssetsLoadComplete() : void
      {
         var _loc1_:Number = 0.4;
         if(this._bytesTotal == 0)
         {
            visible = false;
            _loc1_ = 0.1;
         }
         TweenMax.delayedCall(_loc1_,this.removeMe);
      }
      
      private function removeMe() : void
      {
         if(this._callback != null)
         {
            this._callback();
         }
         screensM.removeScreen(BMScreensManager.SCR_LOAD_EXTERNAL_LIBRARY);
      }
   }
}

