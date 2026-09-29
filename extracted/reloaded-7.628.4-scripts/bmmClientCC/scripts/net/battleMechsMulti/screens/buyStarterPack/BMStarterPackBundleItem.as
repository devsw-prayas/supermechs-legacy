package net.battleMechsMulti.screens.buyStarterPack
{
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import net.battleMechsMulti.managers.BMScreensManager;
   import net.battleMechsMulti.mobiles.BMBaseClass;
   import net.battleMechsMulti.mobiles.BMItem;
   import net.battleMechsMulti.mobiles.BMItemData;
   import net.battleMechsMulti.utils.TextUtils;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol1536")]
   public class BMStarterPackBundleItem extends BMBaseClass
   {
      
      public static const TYPE_ITEM:String = "item";
      
      public static const TYPE_RESOURCE:String = "resource";
      
      public static const TYPE_ITEM_BOX:String = "itemBox";
      
      public static const RESOURCE_GOLD:String = "gold";
      
      public static const RESOURCE_TOKENS:String = "tokens";
      
      public static const RESOURCE_BATTLE_CREDITS:String = "battleCredits";
      
      public static const RESOURCE_ARENA_COINS:String = "arenaCoins";
      
      public static const RESOURCE_CLAN_COINS:String = "clanCoins";
      
      public static const RESOURCE_NUKES:String = "nukes";
      
      public var mcFrame:MovieClip;
      
      public var mcIcons:MovieClip;
      
      public var txtItemValue:TextField;
      
      public var txtResourceValue:TextField;
      
      public var mcSizer_item:Sprite;
      
      public var mcItemHolder:Sprite;
      
      public var mcBackground:MovieClip;
      
      public var mcHitArea:Sprite;
      
      private var _itemID:uint;
      
      public function BMStarterPackBundleItem()
      {
         super();
      }
      
      public function initializeResource(param1:String, param2:uint, param3:uint) : void
      {
         this.initialize(TYPE_RESOURCE,0,0,param1,param2,param3);
      }
      
      public function initializeItem(param1:uint, param2:uint, param3:uint, param4:Boolean = true) : void
      {
         this.initialize(TYPE_ITEM,param1,0,"",param2,param3,param4);
      }
      
      public function initializeItemBox(param1:uint, param2:uint, param3:uint) : void
      {
         this.initialize(TYPE_ITEM_BOX,0,param1,"",param2,param3);
      }
      
      private function initialize(param1:String, param2:uint, param3:uint, param4:String, param5:uint, param6:uint, param7:Boolean = true) : void
      {
         var _loc8_:String = null;
         var _loc9_:Array = null;
         var _loc10_:BMItem = null;
         var _loc11_:Number = NaN;
         var _loc12_:BMItemData = null;
         var _loc13_:String = null;
         var _loc14_:MovieClip = null;
         generateSingletonClassesPointers("");
         param6 = Math.max(2,param6);
         param6 = Math.min(5,param6);
         this.mcIcons.visible = true;
         this.mcBackground.gotoAndStop("rarity" + param6);
         if(param1 == TYPE_RESOURCE)
         {
            this.mcIcons.gotoAndStop(param4);
            _loc8_ = "resource";
         }
         else if(param1 == TYPE_ITEM_BOX)
         {
            param4 = "itemBox0";
            _loc9_ = new Array();
            _loc9_.push(1,2,5,19);
            if(_loc9_.indexOf(param3) > -1)
            {
               param4 = "itemBox" + param3;
            }
            this.mcIcons.gotoAndStop(param4);
            _loc8_ = "item";
         }
         else
         {
            this.mcIcons.visible = false;
            _loc10_ = new BMItem();
            _loc11_ = this.mcSizer_item.width;
            _loc12_ = dataM.itemsDB[param2];
            _loc13_ = dataM.itemTypeSourceDB[_loc12_.type];
            _loc14_ = externalAssetsM.getAsset(_loc13_,_loc12_.grp);
            _loc10_.initialize(0,_loc11_,_loc11_,_loc14_,0,0,true,null,dataM.runAsMobile);
            this.mcItemHolder.addChild(_loc10_);
            if(param7)
            {
               this.mcHitArea.addEventListener(MouseEvent.CLICK,this.onHitAreaClicked);
            }
            addEventListener(Event.REMOVED_FROM_STAGE,this.onRemovedFromStage);
            this._itemID = param2;
            _loc8_ = "item";
         }
         if(_loc8_ == "item")
         {
            updateTextAndFormat(this.txtItemValue,TextUtils.getNumberWithComma(param5));
            this.txtResourceValue.text = "";
         }
         else
         {
            updateTextAndFormat(this.txtResourceValue,TextUtils.getNumberWithComma(param5));
            this.txtItemValue.text = "";
         }
         _loc8_ = param6 + "_" + _loc8_;
         this.mcFrame.gotoAndStop(_loc8_);
      }
      
      private function onHitAreaClicked(param1:MouseEvent) : void
      {
         screensM.addScreen(BMScreensManager.SCR_CONTENT_PACK_ITEM_INFO);
         screensM.screenContentPackItemInfo.showItemInfo(this._itemID,false);
      }
      
      private function onRemovedFromStage(param1:Event) : void
      {
         this.mcHitArea.removeEventListener(MouseEvent.CLICK,this.onHitAreaClicked);
      }
   }
}

