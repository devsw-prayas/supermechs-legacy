package net.battleMechsMulti.screens.shop
{
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.text.TextField;
   import net.battleMechsMulti.managers.BMScreensManager;
   import net.battleMechsMulti.managers.singlePlayer.BMSinglePlayerManager;
   import net.battleMechsMulti.mobiles.BMItemData;
   import net.battleMechsMulti.mobiles.BMMechStructure;
   import net.battleMechsMulti.mobiles.BMMechView;
   import net.battleMechsMulti.mobiles.BMTileListItem;
   
   public class BMScreenShopItemInfoMech extends BMScreenShopItemInfo
   {
      
      public var mcMechHolder:Sprite;
      
      public var mcItemsHolder:Sprite;
      
      public var txtMechlDesc:TextField;
      
      public var txtGeneralDesc:TextField;
      
      public var mcItemsBackground:MovieClip;
      
      private var tileListItems:Array = new Array();
      
      private var _mechView:BMMechView;
      
      private var totalTokensCost:Number;
      
      public function BMScreenShopItemInfoMech()
      {
         super();
      }
      
      override public function initMech() : void
      {
         this.updateTexts();
         this.addMech();
         this.addItemsTileList();
      }
      
      private function updateTexts() : void
      {
         updateTextAndFormat(txtTitle,getShopItemData().infoOnlyText1);
         updateTextAndFormat(this.txtMechlDesc,getShopItemData().infoOnlyText2);
      }
      
      private function addMech() : void
      {
         this._mechView = new BMMechView();
         var _loc1_:Number = 0.7;
         this._mechView.initialize(100,"hanger",BMMechStructure.ITEM_TYPE_ITEM_ID,_loc1_);
         this._mechView.buildMech(getShopItemData().mechStructure);
         this._mechView.activateBreathing();
         this.mcMechHolder.addChild(this._mechView);
         this._mechView.resetYPos();
      }
      
      private function addItemsTileList() : void
      {
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         var _loc8_:* = 0;
         var _loc10_:uint = 0;
         var _loc12_:BMItemData = null;
         var _loc13_:uint = 0;
         var _loc14_:uint = 0;
         var _loc15_:BMItemData = null;
         var _loc16_:BMItemData = null;
         var _loc17_:String = null;
         var _loc18_:BMTileListItem = null;
         var _loc1_:Array = new Array();
         var _loc2_:Array = ["torso","leg","sideWeapon1","sideWeapon2","sideWeapon3","sideWeapon4","topWeapon1","topWeapon2","drone","teleport","charge","harpoon","module1","module2","module3","module4","module5","module6","module7","module8"];
         var _loc5_:Object = new Object();
         this.totalTokensCost = 0;
         var _loc6_:Object = {
            "2":{
               "0_2":40,
               "0_3":50,
               "0_4":60,
               "1_2":40,
               "1_3":50,
               "1_4":75,
               "2_3":50,
               "2_4":250
            },
            "3":{
               "0_3":500,
               "0_4":500,
               "1_3":500,
               "1_4":600,
               "2_3":500,
               "2_4":750,
               "3_4":1500
            }
         };
         _loc3_ = 0;
         while(_loc3_ < _loc2_.length)
         {
            if(getShopItemData().mechStructure[_loc2_[_loc3_]] > 0)
            {
               _loc4_ = uint(getShopItemData().mechStructure[_loc2_[_loc3_]]);
               if(_loc4_ > 0)
               {
                  _loc1_.push(_loc4_);
                  _loc12_ = dataM.itemsDB[_loc4_];
                  _loc13_ = BMSinglePlayerManager.gi().getItemFromChainByPowerRating(_loc12_.itemID,1);
                  _loc14_ = BMSinglePlayerManager.gi().getItemFromChainByPowerRating(_loc12_.itemID,uint.MAX_VALUE);
                  _loc15_ = dataM.itemsDB[_loc13_];
                  _loc16_ = dataM.itemsDB[_loc14_];
                  if(_loc16_.specialStatus < 4)
                  {
                     _loc5_[_loc4_] = true;
                  }
                  _loc17_ = _loc15_.specialStatus + "_" + _loc16_.specialStatus;
                  if(_loc6_[_loc12_.specialStatus][_loc17_] == null)
                  {
                     trace("MISSING COST FOR " + _loc17_);
                  }
                  else
                  {
                     this.totalTokensCost += _loc6_[_loc12_.specialStatus][_loc17_];
                  }
               }
            }
            _loc3_++;
         }
         trace("TOTAL TOKENS COST: " + this.totalTokensCost);
         var _loc7_:uint = 65;
         if(_loc1_.length <= 5)
         {
            this.mcItemsBackground.gotoAndStop(4);
            this.mcItemsBackground.y += 1.5 * _loc7_;
            this.mcItemsHolder.y += 1.5 * _loc7_;
         }
         else if(_loc1_.length <= 10)
         {
            this.mcItemsBackground.gotoAndStop(3);
            this.mcItemsBackground.y += 1 * _loc7_;
            this.mcItemsHolder.y += 1 * _loc7_;
         }
         else if(_loc1_.length <= 15)
         {
            this.mcItemsBackground.gotoAndStop(2);
            this.mcItemsBackground.y += 0.5 * _loc7_;
            this.mcItemsHolder.y += 0.5 * _loc7_;
         }
         _loc8_ = 0;
         var _loc9_:uint = 0;
         _loc10_ = 5;
         var _loc11_:uint = getShopItemData().mechStructure.torso_colorID;
         _loc3_ = 0;
         while(_loc3_ < _loc1_.length)
         {
            _loc4_ = uint(_loc1_[_loc3_]);
            _loc18_ = dataM.createItemTileListItem(_loc4_,_loc7_,_loc11_,false,this.tileListItemClicked,null,null,true);
            if(!_loc5_[_loc4_])
            {
            }
            _loc18_.x = _loc8_ * _loc7_;
            _loc18_.y = _loc9_ * _loc7_;
            this.tileListItems.push(_loc18_);
            this.mcItemsHolder.addChild(_loc18_);
            if(++_loc8_ >= _loc10_)
            {
               _loc8_ = 0;
               _loc9_++;
            }
            _loc3_++;
         }
      }
      
      private function tileListItemClicked(param1:uint, param2:uint) : void
      {
         screensM.addScreen(BMScreensManager.SCR_CONTENT_PACK_ITEM_INFO);
         screensM.screenContentPackItemInfo.showItemInfo(param2,false);
      }
      
      override public function onEnterFrameTriggerSub() : void
      {
         this._mechView.onEnterFrameTrigger();
      }
      
      override public function removedFromStageSub() : void
      {
         if(this._mechView != null)
         {
            this._mechView.removeMe();
            this._mechView = null;
         }
      }
   }
}

