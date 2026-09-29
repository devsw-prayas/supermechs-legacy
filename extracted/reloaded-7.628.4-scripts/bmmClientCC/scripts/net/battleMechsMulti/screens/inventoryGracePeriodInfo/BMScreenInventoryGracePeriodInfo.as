package net.battleMechsMulti.screens.inventoryGracePeriodInfo
{
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.text.TextField;
   import net.battleMechsMulti.mobiles.buttons.BMBasicButton;
   import net.battleMechsMulti.mobiles.buttons.BMIntractable;
   import net.battleMechsMulti.screens.BMBaseScreen;
   import net.battleMechsMulti.utils.TextUtils;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol2149")]
   public class BMScreenInventoryGracePeriodInfo extends BMBaseScreen
   {
      
      public var txtTitle:TextField;
      
      public var txtDesc:TextField;
      
      public var txtCurrentTitle:TextField;
      
      public var txtCurrent:TextField;
      
      public var txtLimitTitle:TextField;
      
      public var txtLimit:TextField;
      
      public var txtWarning:TextField;
      
      public var mcCurrentFrame:MovieClip;
      
      public var btnClose:BMBasicButton;
      
      public var mcTimer:BMInventoryGracePeriodTimer;
      
      private const GOOD_COLOR:String = "00E500";
      
      private const BAD_COLOR:String = "FF3300";
      
      public function BMScreenInventoryGracePeriodInfo()
      {
         super();
      }
      
      public function initialize() : void
      {
         generateSingletonClassesPointers();
         setLanguageManagerScreenName("migration");
         this.btnClose.addEventListener(BMIntractable.HIT,this.closeHit);
         this.initStaticTexts();
         this.refreshInventoryStats();
         this.refreshWarning();
         this.mcTimer.activateTimer();
      }
      
      private function closeHit(param1:Event) : void
      {
         screensM.removeScreen("screenInventoryGracePeriodInfo");
      }
      
      private function initStaticTexts() : void
      {
         updateTextAndFormat(this.txtTitle,getScreenText("inventoryLimitGracePeriodTitle"));
         updateTextAndFormat(this.txtDesc,getScreenText("inventoryLimitGracePeriodDescription"));
         updateTextAndFormat(this.txtCurrentTitle,getScreenText("inventoryLimitGracePeriodCurrentInventorySize"));
         updateTextAndFormat(this.txtLimitTitle,getScreenText("inventoryLimitGracePeriodInventoryLimit"));
      }
      
      private function refreshInventoryStats() : void
      {
         var _loc1_:uint = dataM.myPlayerData.items.length;
         var _loc2_:uint = uint(dataM.myProfile.inventorySizeState.maxSize);
         updateTextAndFormat(this.txtCurrent,"<FONT COLOR=\'#" + this.getStatusColor() + "\'>" + TextUtils.getNumberWithComma(_loc1_));
         updateTextAndFormat(this.txtLimit,TextUtils.getNumberWithComma(_loc2_));
         if(dataM.isAboveInventoryLimit())
         {
            this.mcCurrentFrame.gotoAndStop(2);
         }
      }
      
      private function refreshWarning() : void
      {
         var _loc1_:String = null;
         if(dataM.isAboveInventoryLimit())
         {
            _loc1_ = getScreenText("inventoryLimitGracePeriodPlayerAboveLimit");
            _loc1_ = dataM.replaceStringInText(_loc1_,"%VALUE%",String(this.getItemsAboveLimit()));
            _loc1_ = "<FONT COLOR=\'#" + this.getStatusColor() + "\'>" + _loc1_;
         }
         else
         {
            _loc1_ = "<FONT COLOR=\'#" + this.getStatusColor() + "\'>" + getScreenText("inventoryLimitGracePeriodPlayerUnderLimit");
         }
         updateTextAndFormat(this.txtWarning,_loc1_);
      }
      
      private function getItemsAboveLimit() : uint
      {
         var _loc1_:uint = dataM.myPlayerData.items.length;
         var _loc2_:uint = uint(dataM.myProfile.inventorySizeState.maxSize);
         if(_loc1_ > _loc2_)
         {
            return _loc1_ - _loc2_;
         }
         return 0;
      }
      
      private function getStatusColor() : String
      {
         if(dataM.isAboveInventoryLimit())
         {
            return this.BAD_COLOR;
         }
         return this.GOOD_COLOR;
      }
   }
}

