package net.battleMechsMulti.screens
{
   import flash.display.Sprite;
   import flash.text.TextField;
   import net.battleMechsMulti.mobiles.BMPlayerItemData;
   import net.battleMechsMulti.mobiles.BMTileListItem;
   import net.battleMechsMulti.mobiles.buttons.BMButton;
   import net.battleMechsMulti.utils.TextUtils;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol1095")]
   public class BMScreenMythicalCrafted extends BMBaseScreen
   {
      
      public var mcButtonsHolder:Sprite;
      
      public var mcIconsHolder:Sprite;
      
      public var txtTitle:TextField;
      
      public var txtDurability:TextField;
      
      public var mcSizer_btnClose:Sprite;
      
      public var mcSizer_item:Sprite;
      
      public var btnClose:BMButton;
      
      private var newMythItem:BMTileListItem;
      
      private var _firstRefresh:Boolean = true;
      
      public function BMScreenMythicalCrafted()
      {
         super();
      }
      
      public function initialize() : void
      {
         generateSingletonClassesPointers("");
      }
      
      public function refreshScreen(param1:Number) : void
      {
         var _loc7_:Function = null;
         if(this._firstRefresh)
         {
            setLanguageManagerScreenName("mythicalCrafted");
            screensM.createButtonFromSizer("screenMythicalCrafted","btnClose","regular");
            _loc7_ = this.closeClicked;
            if(dataM.runAsMobile)
            {
               _loc7_ = null;
            }
            this.btnClose.initialize(getGeneralText("OK"),"green",null,null,_loc7_,dataM.runAsMobile);
            this.btnClose.activateSoundFunctions(screensM.sound_buttonClicked,screensM.sound_buttonRollover);
            this.languageUpdate();
            this._firstRefresh = false;
         }
         else if(lastLanguageID != dataM.languageID)
         {
            this.languageUpdate(true);
         }
         if(this.newMythItem != null)
         {
            this.newMythItem.removeMe();
            this.newMythItem = null;
         }
         var _loc2_:Function = this.tileListItemMouseOver;
         var _loc3_:Function = this.tileListItemMouseOut;
         if(dataM.runAsMobile)
         {
            _loc2_ = null;
            _loc3_ = null;
         }
         this.newMythItem = dataM.createInventoryTileListItem(param1,false,null,null,null,_loc2_,_loc3_,true);
         this.newMythItem.width = this.mcSizer_item.width;
         this.newMythItem.height = this.mcSizer_item.height;
         this.newMythItem.x = this.mcSizer_item.x;
         this.newMythItem.y = this.mcSizer_item.y;
         this.mcButtonsHolder.addChild(this.newMythItem);
         var _loc4_:BMPlayerItemData = dataM.getPlayerItemData(dataM.player1PlayerID,param1);
         var _loc5_:String = getScreenText("durability");
         _loc5_ = dataM.replaceStringInText(_loc5_,"%DURABILITY%",String(_loc4_.durability));
         _loc5_ = dataM.replaceStringInText(_loc5_,"%COLOR1%","<FONT COLOR=\'#" + dataM.COLOR_LEGENDARY_ITEM + "\'>");
         _loc5_ = dataM.replaceStringInText(_loc5_,"%COLOR2%","<FONT COLOR=\'#CCCCCC\'>");
         var _loc6_:uint = 20;
         switch(dataM.languageID)
         {
            case 3:
               _loc6_ = 14;
         }
         this.txtDurability.htmlText = TextUtils.getTextFont(_loc6_) + _loc5_;
         if(dataM.runAsMobile)
         {
            screensM.createMultipleTextsBitmap("mythicalCrafted_durability",[this.txtDurability],"",this);
         }
      }
      
      private function languageUpdate(param1:Boolean = false) : void
      {
         var _loc2_:uint = 0;
         if(lastLanguageID != dataM.languageID)
         {
            lastLanguageID = dataM.languageID;
            _loc2_ = 20;
            switch(dataM.languageID)
            {
               case 3:
                  _loc2_ = 14;
            }
            TextUtils.updateTextFormat(this.txtDurability,_loc2_);
            TextUtils.updateTextFormat(this.txtTitle,20);
            TextUtils.updateTextFormat(this.btnClose.txtButtonName,33);
            param1 = true;
         }
         if(param1)
         {
            this.btnClose.changeFontSize(33);
            this.btnClose.setButtonName(getGeneralText("OK"));
         }
         this.txtTitle.text = getScreenText("title");
         if(dataM.runAsMobile)
         {
            screensM.createMultipleTextsBitmap("mythicalCrafted_title",[this.txtTitle],"",this);
         }
      }
      
      public function onEnterFrameTrigger() : void
      {
      }
      
      private function tileListItemMouseOver(param1:uint, param2:Number) : void
      {
         tooltip.showToolTip("inventory","",param2);
      }
      
      private function tileListItemMouseOut(param1:uint, param2:Number) : void
      {
         tooltip.hideToolTip();
      }
      
      public function closeClicked() : void
      {
         this.removeMe();
      }
      
      public function removeMe() : void
      {
         if(this.newMythItem != null)
         {
            this.newMythItem.removeMe();
            this.newMythItem = null;
         }
         screensM.removeScreen("screenMythicalCrafted");
      }
   }
}

