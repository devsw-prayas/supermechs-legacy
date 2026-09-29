package net.battleMechsMulti.screens.adminTools
{
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.text.TextField;
   import net.battleMechsMulti.mobiles.BMItem;
   import net.battleMechsMulti.mobiles.BMItemData;
   import net.battleMechsMulti.mobiles.BMTileList;
   import net.battleMechsMulti.mobiles.BMTileListItem;
   import net.battleMechsMulti.mobiles.buttons.BMButton_pictureE;
   import net.battleMechsMulti.screens.BMBaseScreen;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol1877")]
   public class BMScreenAdminItemTierList extends BMBaseScreen
   {
      
      public var mcButtonsHolder:Sprite;
      
      public var mcSizer_btnBack:Sprite;
      
      public var mcSizer_btnType_torso:Sprite;
      
      public var mcSizer_btnType_leg:Sprite;
      
      public var mcSizer_btnType_sideWeapon:Sprite;
      
      public var mcSizer_btnType_topWeapon:Sprite;
      
      public var mcSizer_btnType_charge:Sprite;
      
      public var mcSizer_btnType_drone:Sprite;
      
      public var mcSizer_btnType_harpoon:Sprite;
      
      public var mcSizer_btnType_shield:Sprite;
      
      public var mcSizer_btnType_teleport:Sprite;
      
      public var mcSizer_btnType_module:Sprite;
      
      public var btnBack:BMButton_pictureE;
      
      public var btnType_torso:BMButton_pictureE;
      
      public var btnType_leg:BMButton_pictureE;
      
      public var btnType_sideWeapon:BMButton_pictureE;
      
      public var btnType_topWeapon:BMButton_pictureE;
      
      public var btnType_charge:BMButton_pictureE;
      
      public var btnType_drone:BMButton_pictureE;
      
      public var btnType_harpoon:BMButton_pictureE;
      
      public var btnType_shield:BMButton_pictureE;
      
      public var btnType_teleport:BMButton_pictureE;
      
      public var btnType_module:BMButton_pictureE;
      
      public var txtItemID:TextField;
      
      public var txtGrpTarget:TextField;
      
      public var txtGrpOrigin:TextField;
      
      public var txtItemName:TextField;
      
      private var _itemsList:Object;
      
      private var _finalItemsToShow_chains:Object;
      
      private var _finalItemsToShow_lone:Object;
      
      private var _visualAssetsDB:Object;
      
      private var _lastVisualAssetsType:String;
      
      private var _originItemID:Number;
      
      private var _targetItemItemID:Number;
      
      private var _lastEquipmentType:String;
      
      private var itemsTileList:BMTileList;
      
      private var visualAssetsTileList:BMTileList;
      
      private var _topWeaponsArray:Array = new Array();
      
      private var _firstRefresh:Boolean = true;
      
      public function BMScreenAdminItemTierList()
      {
         super();
      }
      
      public function initialize() : void
      {
         generateSingletonClassesPointers("");
      }
      
      public function refreshScreen() : void
      {
         if(this._firstRefresh)
         {
            screensM.createButtonFromSizer("screenAdminItemTierList","btnBack","pictureE");
            screensM.createButtonFromSizer("screenAdminItemTierList","btnType_torso","pictureE");
            screensM.createButtonFromSizer("screenAdminItemTierList","btnType_leg","pictureE");
            screensM.createButtonFromSizer("screenAdminItemTierList","btnType_sideWeapon","pictureE");
            screensM.createButtonFromSizer("screenAdminItemTierList","btnType_topWeapon","pictureE");
            screensM.createButtonFromSizer("screenAdminItemTierList","btnType_drone","pictureE");
            screensM.createButtonFromSizer("screenAdminItemTierList","btnType_teleport","pictureE");
            screensM.createButtonFromSizer("screenAdminItemTierList","btnType_charge","pictureE");
            screensM.createButtonFromSizer("screenAdminItemTierList","btnType_shield","pictureE");
            screensM.createButtonFromSizer("screenAdminItemTierList","btnType_harpoon","pictureE");
            screensM.createButtonFromSizer("screenAdminItemTierList","btnType_module","pictureE");
            this.btnBack.initialize("","",externalAssetsM.getAsset("general","interface_cancel"),null,this.backClicked,dataM.runAsMobile);
            this.btnType_torso.initialize("","",externalAssetsM.getAsset("general","emptyItem_torso"),["torso"],this.typeClicked,dataM.runAsMobile);
            this.btnType_leg.initialize("","",externalAssetsM.getAsset("general","emptyItem_leg"),["leg"],this.typeClicked,dataM.runAsMobile);
            this.btnType_sideWeapon.initialize("","",externalAssetsM.getAsset("general","emptyItem_sideWeaponLeft"),["sideWeapon"],this.typeClicked,dataM.runAsMobile);
            this.btnType_topWeapon.initialize("","",externalAssetsM.getAsset("general","emptyItem_topWeaponLeft"),["topWeapon"],this.typeClicked,dataM.runAsMobile);
            this.btnType_charge.initialize("","",externalAssetsM.getAsset("general","emptyItem_charge"),["charge"],this.typeClicked,dataM.runAsMobile);
            this.btnType_drone.initialize("","",externalAssetsM.getAsset("general","emptyItem_drone"),["drone"],this.typeClicked,dataM.runAsMobile);
            this.btnType_harpoon.initialize("","",externalAssetsM.getAsset("general","emptyItem_harpoon"),["harpoon"],this.typeClicked,dataM.runAsMobile);
            this.btnType_shield.initialize("","",externalAssetsM.getAsset("general","emptyItem_shield"),["shield"],this.typeClicked,dataM.runAsMobile);
            this.btnType_teleport.initialize("","",externalAssetsM.getAsset("general","emptyItem_teleport"),["teleport"],this.typeClicked,dataM.runAsMobile);
            this.btnType_module.initialize("","",externalAssetsM.getAsset("general","emptyItem_module"),["module"],this.typeClicked,dataM.runAsMobile);
            this.createVisualAssets();
            this.createItemsData();
            this._firstRefresh = false;
         }
      }
      
      private function createItemsData() : void
      {
         var _loc1_:BMItemData = null;
         var _loc2_:Object = null;
         var _loc3_:uint = 0;
         var _loc4_:Object = null;
         var _loc5_:Boolean = false;
         var _loc6_:BMItemData = null;
         var _loc7_:Array = null;
         var _loc8_:uint = 0;
         var _loc9_:uint = 0;
         var _loc10_:* = undefined;
         this._itemsList = new Object();
         for each(_loc1_ in dataM.itemsDB)
         {
            if(_loc1_.specialStatus <= 4 && _loc1_.displayLevel == 1)
            {
               if(this._itemsList[_loc1_.type] == null)
               {
                  this._itemsList[_loc1_.type] = new Object();
                  this._itemsList[_loc1_.type].type = _loc1_.type;
                  this._itemsList[_loc1_.type].tier = new Array();
                  this._itemsList[_loc1_.type].tier[0] = new Object();
                  this._itemsList[_loc1_.type].tier[1] = new Object();
                  this._itemsList[_loc1_.type].tier[2] = new Object();
                  this._itemsList[_loc1_.type].tier[3] = new Object();
                  this._itemsList[_loc1_.type].tier[4] = new Object();
               }
               this._itemsList[_loc1_.type].tier[_loc1_.specialStatus][_loc1_.itemID] = {
                  "itemID":_loc1_.itemID,
                  "upgradeToItemID":_loc1_.upgradeToItemID,
                  "head":true
               };
            }
         }
         for each(_loc2_ in this._itemsList)
         {
            _loc3_ = 0;
            while(_loc3_ <= 4)
            {
               for each(_loc4_ in _loc2_.tier[_loc3_])
               {
                  _loc1_ = dataM.itemsDB[_loc4_.itemID];
                  _loc5_ = false;
                  while(_loc5_ == false)
                  {
                     if(_loc4_.upgradeToItemID <= 0)
                     {
                        _loc5_ = true;
                     }
                     else
                     {
                        _loc6_ = dataM.itemsDB[_loc4_.upgradeToItemID];
                        if(_loc6_.specialStatus == _loc1_.specialStatus + 1 && _loc6_.displayLevel == 1)
                        {
                           if(_loc3_ < 4)
                           {
                              _loc2_.tier[_loc3_ + 1][_loc4_.upgradeToItemID].head = false;
                           }
                           _loc5_ = true;
                        }
                        else
                        {
                           _loc2_.tier[_loc3_][_loc4_.itemID].upgradeToItemID = _loc6_.upgradeToItemID;
                        }
                     }
                  }
               }
               _loc3_++;
            }
         }
         this._finalItemsToShow_chains = new Object();
         this._finalItemsToShow_lone = new Object();
         for each(_loc2_ in this._itemsList)
         {
            _loc3_ = 0;
            while(_loc3_ <= 4)
            {
               for each(_loc4_ in _loc2_.tier[_loc3_])
               {
                  if(_loc4_.head)
                  {
                     _loc7_ = new Array();
                     _loc9_ = 1;
                     if(_loc3_ > 0)
                     {
                        _loc8_ = 0;
                        while(_loc8_ < _loc3_)
                        {
                           _loc7_.push(0);
                           _loc8_++;
                        }
                     }
                     _loc7_.push(_loc4_.itemID);
                     _loc10_ = _loc4_.upgradeToItemID;
                     if(_loc3_ < 4)
                     {
                        _loc8_ = _loc3_ + 1;
                        while(_loc8_ <= 4)
                        {
                           if(_loc2_.tier[_loc8_][_loc10_] != null)
                           {
                              _loc7_.push(_loc10_);
                              _loc2_.tier[_loc8_][_loc10_].head = false;
                              _loc10_ = _loc2_.tier[_loc8_][_loc10_].upgradeToItemID;
                              _loc9_++;
                           }
                           else
                           {
                              _loc7_.push(0);
                           }
                           _loc8_++;
                        }
                     }
                     if(_loc9_ > 1)
                     {
                        if(this._finalItemsToShow_chains[_loc2_.type] == null)
                        {
                           this._finalItemsToShow_chains[_loc2_.type] = new Array();
                        }
                        this._finalItemsToShow_chains[_loc2_.type].push(_loc7_);
                     }
                     else
                     {
                        if(this._finalItemsToShow_lone[_loc2_.type] == null)
                        {
                           this._finalItemsToShow_lone[_loc2_.type] = new Array();
                        }
                        this._finalItemsToShow_lone[_loc2_.type].push(_loc7_);
                     }
                  }
               }
               _loc3_++;
            }
         }
         this.addAndRefreshItemsTileList("torso");
      }
      
      private function addAndRefreshItemsTileList(param1:String = "") : void
      {
         var _loc4_:BMItemData = null;
         var _loc6_:uint = 0;
         var _loc7_:uint = 0;
         var _loc9_:Number = NaN;
         var _loc10_:BMTileListItem = null;
         var _loc11_:BMItem = null;
         var _loc12_:MovieClip = null;
         var _loc2_:Number = 0;
         if(param1 == "")
         {
            if(this.itemsTileList != null)
            {
               _loc2_ = this.itemsTileList.getCurrentRow();
            }
            param1 = this._lastEquipmentType;
         }
         else
         {
            this.txtGrpOrigin.text = "";
         }
         this._lastEquipmentType = param1;
         if(this.itemsTileList != null)
         {
            this.itemsTileList.removeMe();
         }
         this.itemsTileList = new BMTileList();
         var _loc3_:Array = new Array();
         var _loc5_:uint = 0;
         var _loc8_:uint = 60;
         if(this._finalItemsToShow_chains[param1] != null)
         {
            _loc6_ = 0;
            while(_loc6_ < this._finalItemsToShow_chains[param1].length)
            {
               _loc7_ = 0;
               while(_loc7_ < this._finalItemsToShow_chains[param1][_loc6_].length)
               {
                  _loc9_ = Number(this._finalItemsToShow_chains[param1][_loc6_][_loc7_]);
                  _loc10_ = null;
                  if(_loc9_ == 0)
                  {
                     _loc11_ = new BMItem();
                     _loc12_ = new MovieClip();
                     _loc12_.graphics.beginFill(0,1);
                     _loc12_.graphics.drawRect(0,0,_loc8_,_loc8_);
                     _loc11_.initialize(0,_loc8_,_loc8_,_loc12_,0,0,false,null,dataM.runAsMobile);
                     _loc10_ = new BMTileListItem();
                     _loc10_.initialize(_loc8_,_loc8_,_loc11_,"","","",0,null,null,null,null,null,dataM.runAsMobile);
                  }
                  else
                  {
                     _loc10_ = dataM.createShopTileListItem_basedOnItemID(_loc9_,"mechGenerator",this.tileListItemClicked,null,null,null,null,true);
                  }
                  _loc3_.push(_loc10_);
                  _loc7_++;
               }
               _loc6_++;
            }
         }
         if(this._finalItemsToShow_lone[param1] != null)
         {
            _loc6_ = 0;
            while(_loc6_ < this._finalItemsToShow_lone[param1].length)
            {
               _loc7_ = 0;
               while(_loc7_ < this._finalItemsToShow_lone[param1][_loc6_].length)
               {
                  _loc9_ = Number(this._finalItemsToShow_lone[param1][_loc6_][_loc7_]);
                  _loc10_ = null;
                  if(_loc9_ == 0)
                  {
                     _loc11_ = new BMItem();
                     _loc12_ = new MovieClip();
                     _loc12_.graphics.beginFill(0,1);
                     _loc12_.graphics.drawRect(0,0,_loc8_,_loc8_);
                     _loc11_.initialize(0,_loc8_,_loc8_,_loc12_,0,0,false,null,dataM.runAsMobile);
                     _loc10_ = new BMTileListItem();
                     _loc10_.initialize(_loc8_,_loc8_,_loc11_,"","","",0,null,null,null,null,null,dataM.runAsMobile);
                  }
                  else
                  {
                     _loc10_ = dataM.createShopTileListItem_basedOnItemID(_loc9_,"mechGenerator",this.tileListItemClicked,null,null,null,null,true);
                  }
                  _loc3_.push(_loc10_);
                  _loc7_++;
               }
               _loc6_++;
            }
         }
         var _loc13_:MovieClip = new Grp_scrollerContent();
         this.itemsTileList.initialize(screensM.stagePointer,_loc3_,10,5,_loc8_,_loc8_,null,true,_loc13_,null,null,true,_loc2_,0.5,false,false,false);
         this.itemsTileList.scaleX = 0.8;
         this.itemsTileList.scaleY = 0.8;
         this.itemsTileList.x = 55;
         addChild(this.itemsTileList);
      }
      
      private function typeClicked(param1:String) : void
      {
         if(this.visualAssetsTileList != null)
         {
            this.visualAssetsTileList.removeMe();
         }
         this.addAndRefreshItemsTileList(param1);
      }
      
      private function tileListItemClicked(param1:uint, param2:uint) : void
      {
         var _loc4_:String = null;
         this._originItemID = param2;
         var _loc3_:BMItemData = dataM.itemsDB[this._originItemID];
         this.txtGrpOrigin.text = _loc3_.grp;
         this.txtItemID.text = String(param2);
         this.txtItemName.text = String(_loc3_.fullName);
         this.txtGrpTarget.text = "";
         this._lastVisualAssetsType = _loc3_.type;
         switch(_loc3_.type)
         {
            case "torso":
            case "leg":
            case "drone":
               _loc4_ = "items1";
               break;
            case "module":
            case "kit":
               _loc4_ = "items3";
               break;
            default:
               _loc4_ = "items2";
         }
         this.addAndRefreshVisualAssetsTileList(_loc4_,this._visualAssetsDB[this._lastVisualAssetsType]);
      }
      
      private function addAndRefreshVisualAssetsTileList(param1:String, param2:Array) : void
      {
         var _loc7_:String = null;
         var _loc8_:BMItem = null;
         var _loc9_:MovieClip = null;
         var _loc10_:BMTileListItem = null;
         if(this.visualAssetsTileList != null)
         {
            this.visualAssetsTileList.removeMe();
         }
         this.visualAssetsTileList = new BMTileList();
         var _loc3_:Array = new Array();
         var _loc4_:uint = 40;
         var _loc5_:uint = 0;
         while(_loc5_ < param2.length)
         {
            _loc7_ = param2[_loc5_];
            _loc8_ = new BMItem();
            _loc9_ = externalAssetsM.getAsset(param1,_loc7_);
            _loc8_.initialize(_loc5_,_loc4_,_loc4_,_loc9_,0,0,false,null,dataM.runAsMobile);
            _loc10_ = new BMTileListItem();
            _loc10_.initialize(_loc4_,_loc4_,_loc8_,"","","",0,this.visualAssetClicked,null,null,null,null,dataM.runAsMobile);
            _loc3_.push(_loc10_);
            _loc5_++;
         }
         var _loc6_:MovieClip = new Grp_scrollerContent();
         this.visualAssetsTileList.initialize(screensM.stagePointer,_loc3_,11,11,_loc4_,_loc4_,null,true,_loc6_,null,null,true,0,0.5,false,false,false);
         this.visualAssetsTileList.x = 335;
         addChild(this.visualAssetsTileList);
      }
      
      private function visualAssetClicked(param1:uint, param2:uint) : void
      {
         var _loc5_:Boolean = false;
         var _loc6_:uint = 0;
         this._targetItemItemID = param2;
         this.txtGrpTarget.text = this._visualAssetsDB[this._lastVisualAssetsType][this._targetItemItemID];
         var _loc3_:uint = 0;
         while(_loc3_ < this._visualAssetsDB.weapon.length)
         {
            _loc5_ = false;
            _loc6_ = 0;
            while(_loc6_ < this._visualAssetsDB.topWeapon.length)
            {
               if(this._visualAssetsDB.weapon[_loc3_] == this._visualAssetsDB.topWeapon[_loc6_])
               {
                  _loc5_ = true;
                  _loc6_ = uint(this._visualAssetsDB.topWeapon.length);
               }
               _loc6_++;
            }
            if(_loc5_ == false)
            {
               trace("_visualAssetsDB.sideWeapon.push(\'" + this._visualAssetsDB.weapon[_loc3_] + "\');");
            }
            _loc3_++;
         }
         var _loc4_:BMItemData = dataM.itemsDB[this._originItemID];
         _loc4_.grp = this._visualAssetsDB[this._lastVisualAssetsType][this._targetItemItemID];
         this.addAndRefreshItemsTileList();
      }
      
      private function backClicked() : void
      {
         screensM.removeScreen("screenAdminItemTierList");
      }
      
      private function createVisualAssets() : void
      {
         this._visualAssetsDB = new Object();
         this._visualAssetsDB.torso = new Array();
         this._visualAssetsDB.torso.push("torso1");
         this._visualAssetsDB.torso.push("torso1B");
         this._visualAssetsDB.torso.push("torso2");
         this._visualAssetsDB.torso.push("torso2B");
         this._visualAssetsDB.torso.push("torso3");
         this._visualAssetsDB.torso.push("torso3B");
         this._visualAssetsDB.torso.push("torso4");
         this._visualAssetsDB.torso.push("torso4B");
         this._visualAssetsDB.torso.push("torso5");
         this._visualAssetsDB.torso.push("torso5B");
         this._visualAssetsDB.torso.push("torso6");
         this._visualAssetsDB.torso.push("torso6B");
         this._visualAssetsDB.torso.push("torso7");
         this._visualAssetsDB.torso.push("torso7B");
         this._visualAssetsDB.torso.push("torso8");
         this._visualAssetsDB.torso.push("torso8B");
         this._visualAssetsDB.torso.push("torso9");
         this._visualAssetsDB.torso.push("torso9B");
         this._visualAssetsDB.torso.push("torso10");
         this._visualAssetsDB.torso.push("torso10B");
         this._visualAssetsDB.torso.push("torso11");
         this._visualAssetsDB.torso.push("torso11B");
         this._visualAssetsDB.torso.push("torso12");
         this._visualAssetsDB.torso.push("torso12B");
         this._visualAssetsDB.torso.push("torso13");
         this._visualAssetsDB.torso.push("torso13B");
         this._visualAssetsDB.torso.push("torso14");
         this._visualAssetsDB.torso.push("torso14B");
         this._visualAssetsDB.torso.push("torso15");
         this._visualAssetsDB.torso.push("torso15B");
         this._visualAssetsDB.torso.push("torso16");
         this._visualAssetsDB.torso.push("torso16B");
         this._visualAssetsDB.torso.push("torso17");
         this._visualAssetsDB.torso.push("torso17B");
         this._visualAssetsDB.torso.push("torso18");
         this._visualAssetsDB.torso.push("torso18B");
         this._visualAssetsDB.torso.push("torso19");
         this._visualAssetsDB.torso.push("torso19B");
         this._visualAssetsDB.torso.push("torso20");
         this._visualAssetsDB.torso.push("torso20B");
         this._visualAssetsDB.torso.push("torso21");
         this._visualAssetsDB.torso.push("torso21B");
         this._visualAssetsDB.torso.push("torso22");
         this._visualAssetsDB.torso.push("torso22B");
         this._visualAssetsDB.torso.push("torso23");
         this._visualAssetsDB.torso.push("torso23B");
         this._visualAssetsDB.torso.push("torso24");
         this._visualAssetsDB.torso.push("torso24B");
         this._visualAssetsDB.torso.push("torso25");
         this._visualAssetsDB.torso.push("torso26");
         this._visualAssetsDB.torso.push("torso26B");
         this._visualAssetsDB.torso.push("torso27");
         this._visualAssetsDB.torso.push("torso28");
         this._visualAssetsDB.torso.push("torso29A");
         this._visualAssetsDB.torso.push("torso29B");
         this._visualAssetsDB.torso.push("torso30");
         this._visualAssetsDB.torso.push("torso31");
         this._visualAssetsDB.torso.push("torso32");
         this._visualAssetsDB.torso.push("torso33");
         this._visualAssetsDB.torso.push("torso34");
         this._visualAssetsDB.torso.push("torso35");
         this._visualAssetsDB.torso.push("torso36");
         this._visualAssetsDB.torso.push("torso37");
         this._visualAssetsDB.torso.push("torso38");
         this._visualAssetsDB.torso.push("torso39");
         this._visualAssetsDB.torso.push("torso40");
         this._visualAssetsDB.torso.push("torso41");
         this._visualAssetsDB.torso.push("torso42A");
         this._visualAssetsDB.torso.push("torso42B");
         this._visualAssetsDB.torso.push("torso42C");
         this._visualAssetsDB.torso.push("torso43");
         this._visualAssetsDB.torso.push("torso44");
         this._visualAssetsDB.torso.push("torso45");
         this._visualAssetsDB.torso.push("torso46");
         this._visualAssetsDB.torso.push("torso47");
         this._visualAssetsDB.torso.push("torso48");
         this._visualAssetsDB.torso.push("torso49");
         this._visualAssetsDB.torso.push("torso50");
         this._visualAssetsDB.torso.push("torso51");
         this._visualAssetsDB.torso.push("torso52");
         this._visualAssetsDB.torso.push("torso53");
         this._visualAssetsDB.torso.push("torso54");
         this._visualAssetsDB.torso.push("torso55");
         this._visualAssetsDB.torso.push("torso56A");
         this._visualAssetsDB.torso.push("torso57A");
         this._visualAssetsDB.torso.push("torso57B");
         this._visualAssetsDB.torso.push("torso1000");
         this._visualAssetsDB.torso.push("torso1001");
         this._visualAssetsDB.torso.push("torso1002");
         this._visualAssetsDB.torso.push("torso1003");
         this._visualAssetsDB.torso.push("torso1004");
         this._visualAssetsDB.leg = new Array();
         this._visualAssetsDB.leg.push("leg1");
         this._visualAssetsDB.leg.push("leg2");
         this._visualAssetsDB.leg.push("leg3");
         this._visualAssetsDB.leg.push("leg4");
         this._visualAssetsDB.leg.push("leg5");
         this._visualAssetsDB.leg.push("leg6");
         this._visualAssetsDB.leg.push("leg7");
         this._visualAssetsDB.leg.push("leg8");
         this._visualAssetsDB.leg.push("leg9");
         this._visualAssetsDB.leg.push("leg10");
         this._visualAssetsDB.leg.push("leg11");
         this._visualAssetsDB.leg.push("leg12");
         this._visualAssetsDB.leg.push("leg13");
         this._visualAssetsDB.leg.push("leg14");
         this._visualAssetsDB.leg.push("leg15");
         this._visualAssetsDB.leg.push("leg16");
         this._visualAssetsDB.leg.push("leg17");
         this._visualAssetsDB.leg.push("leg18");
         this._visualAssetsDB.leg.push("leg19");
         this._visualAssetsDB.leg.push("leg20");
         this._visualAssetsDB.leg.push("leg21");
         this._visualAssetsDB.leg.push("leg22");
         this._visualAssetsDB.leg.push("leg23");
         this._visualAssetsDB.leg.push("leg24");
         this._visualAssetsDB.leg.push("leg25");
         this._visualAssetsDB.leg.push("leg26");
         this._visualAssetsDB.leg.push("leg27A");
         this._visualAssetsDB.leg.push("leg27B");
         this._visualAssetsDB.leg.push("leg27C");
         this._visualAssetsDB.leg.push("leg28");
         this._visualAssetsDB.leg.push("leg29");
         this._visualAssetsDB.leg.push("leg30A");
         this._visualAssetsDB.leg.push("leg30B");
         this._visualAssetsDB.leg.push("leg30C");
         this._visualAssetsDB.leg.push("leg31");
         this._visualAssetsDB.leg.push("leg32");
         this._visualAssetsDB.leg.push("leg32B");
         this._visualAssetsDB.leg.push("leg32C");
         this._visualAssetsDB.leg.push("leg33");
         this._visualAssetsDB.leg.push("leg34");
         this._visualAssetsDB.leg.push("leg35");
         this._visualAssetsDB.leg.push("leg1000");
         this._visualAssetsDB.leg.push("leg1001");
         this._visualAssetsDB.leg.push("leg1002");
         this._visualAssetsDB.leg.push("leg1003");
         this._visualAssetsDB.leg.push("leg1004");
         this._visualAssetsDB.leg.push("wheels1");
         this._visualAssetsDB.leg.push("wheels2");
         this._visualAssetsDB.leg.push("wheels3");
         this._visualAssetsDB.leg.push("wheels4");
         this._visualAssetsDB.leg.push("wheels5A");
         this._visualAssetsDB.leg.push("wheels5B");
         this._visualAssetsDB.leg.push("wheels6");
         this._visualAssetsDB.leg.push("wheels7");
         this._visualAssetsDB.leg.push("wheels8A");
         this._visualAssetsDB.leg.push("wheels8B");
         this._visualAssetsDB.leg.push("wheels8C");
         this._visualAssetsDB.leg.push("wheels9");
         this._visualAssetsDB.leg.push("jet1");
         this._visualAssetsDB.weapon = new Array();
         this._visualAssetsDB.weapon.push("laser1A");
         this._visualAssetsDB.weapon.push("laser1B");
         this._visualAssetsDB.weapon.push("laser1C");
         this._visualAssetsDB.weapon.push("laser2A");
         this._visualAssetsDB.weapon.push("laser2B");
         this._visualAssetsDB.weapon.push("laser2C");
         this._visualAssetsDB.weapon.push("laser3");
         this._visualAssetsDB.weapon.push("laser4A");
         this._visualAssetsDB.weapon.push("laser4B");
         this._visualAssetsDB.weapon.push("laser5A");
         this._visualAssetsDB.weapon.push("laser5B");
         this._visualAssetsDB.weapon.push("laser6");
         this._visualAssetsDB.weapon.push("laser7A");
         this._visualAssetsDB.weapon.push("laser7B");
         this._visualAssetsDB.weapon.push("laser8A");
         this._visualAssetsDB.weapon.push("laser8B");
         this._visualAssetsDB.weapon.push("laser9");
         this._visualAssetsDB.weapon.push("laser10");
         this._visualAssetsDB.weapon.push("laser11A");
         this._visualAssetsDB.weapon.push("laser11B");
         this._visualAssetsDB.weapon.push("laser12A");
         this._visualAssetsDB.weapon.push("laser12B");
         this._visualAssetsDB.weapon.push("laser12C");
         this._visualAssetsDB.weapon.push("laser13");
         this._visualAssetsDB.weapon.push("laser14");
         this._visualAssetsDB.weapon.push("laser15");
         this._visualAssetsDB.weapon.push("laser16");
         this._visualAssetsDB.weapon.push("laser17A");
         this._visualAssetsDB.weapon.push("laser17B");
         this._visualAssetsDB.weapon.push("laser18");
         this._visualAssetsDB.weapon.push("laser19");
         this._visualAssetsDB.weapon.push("laser20A");
         this._visualAssetsDB.weapon.push("laser20B");
         this._visualAssetsDB.weapon.push("laser21A");
         this._visualAssetsDB.weapon.push("laser21B");
         this._visualAssetsDB.weapon.push("laser22A");
         this._visualAssetsDB.weapon.push("laser22B");
         this._visualAssetsDB.weapon.push("laser23A");
         this._visualAssetsDB.weapon.push("laser23B");
         this._visualAssetsDB.weapon.push("laser24A");
         this._visualAssetsDB.weapon.push("laser24B");
         this._visualAssetsDB.weapon.push("laser24C");
         this._visualAssetsDB.weapon.push("laser25A");
         this._visualAssetsDB.weapon.push("laser25B");
         this._visualAssetsDB.weapon.push("laser26A");
         this._visualAssetsDB.weapon.push("laser26B");
         this._visualAssetsDB.weapon.push("laser27A");
         this._visualAssetsDB.weapon.push("laser27B");
         this._visualAssetsDB.weapon.push("laser27C");
         this._visualAssetsDB.weapon.push("laser28A");
         this._visualAssetsDB.weapon.push("laser28B");
         this._visualAssetsDB.weapon.push("laser28C");
         this._visualAssetsDB.weapon.push("laser29A");
         this._visualAssetsDB.weapon.push("laser29B");
         this._visualAssetsDB.weapon.push("laser29C");
         this._visualAssetsDB.weapon.push("laser30A");
         this._visualAssetsDB.weapon.push("laser30B");
         this._visualAssetsDB.weapon.push("laser30C");
         this._visualAssetsDB.weapon.push("laser31A");
         this._visualAssetsDB.weapon.push("laser31B");
         this._visualAssetsDB.weapon.push("laser31C");
         this._visualAssetsDB.weapon.push("laser32A");
         this._visualAssetsDB.weapon.push("laser32B");
         this._visualAssetsDB.weapon.push("laser32C");
         this._visualAssetsDB.weapon.push("laser33A");
         this._visualAssetsDB.weapon.push("laser33B");
         this._visualAssetsDB.weapon.push("laser33C");
         this._visualAssetsDB.weapon.push("laser34A");
         this._visualAssetsDB.weapon.push("laser34B");
         this._visualAssetsDB.weapon.push("laser35");
         this._visualAssetsDB.weapon.push("laser36A");
         this._visualAssetsDB.weapon.push("laser36B");
         this._visualAssetsDB.weapon.push("laser36C");
         this._visualAssetsDB.weapon.push("laser37A");
         this._visualAssetsDB.weapon.push("laser37B");
         this._visualAssetsDB.weapon.push("laser38A");
         this._visualAssetsDB.weapon.push("laser38B");
         this._visualAssetsDB.weapon.push("laser39A");
         this._visualAssetsDB.weapon.push("laser39B");
         this._visualAssetsDB.weapon.push("laser40A");
         this._visualAssetsDB.weapon.push("laser40A2");
         this._visualAssetsDB.weapon.push("laser40A3");
         this._visualAssetsDB.weapon.push("laser40B");
         this._visualAssetsDB.weapon.push("laser40B2");
         this._visualAssetsDB.weapon.push("laser40B3");
         this._visualAssetsDB.weapon.push("laser41A");
         this._visualAssetsDB.weapon.push("laser41B");
         this._visualAssetsDB.weapon.push("laser42A");
         this._visualAssetsDB.weapon.push("laser42B");
         this._visualAssetsDB.weapon.push("laser43A");
         this._visualAssetsDB.weapon.push("laser43B");
         this._visualAssetsDB.weapon.push("laser44A");
         this._visualAssetsDB.weapon.push("laser44B");
         this._visualAssetsDB.weapon.push("laser45");
         this._visualAssetsDB.weapon.push("laser46A");
         this._visualAssetsDB.weapon.push("laser46B");
         this._visualAssetsDB.weapon.push("laser47A");
         this._visualAssetsDB.weapon.push("laser47B");
         this._visualAssetsDB.weapon.push("laser48A");
         this._visualAssetsDB.weapon.push("laser48A2");
         this._visualAssetsDB.weapon.push("laser48A3");
         this._visualAssetsDB.weapon.push("laser48B");
         this._visualAssetsDB.weapon.push("laser48B2");
         this._visualAssetsDB.weapon.push("laser48B3");
         this._visualAssetsDB.weapon.push("laser48C");
         this._visualAssetsDB.weapon.push("laser48C2");
         this._visualAssetsDB.weapon.push("laser48C3");
         this._visualAssetsDB.weapon.push("laser1000");
         this._visualAssetsDB.weapon.push("laser1001A");
         this._visualAssetsDB.weapon.push("laser1001B");
         this._visualAssetsDB.weapon.push("hand1A");
         this._visualAssetsDB.weapon.push("hand1B");
         this._visualAssetsDB.weapon.push("cannon1A");
         this._visualAssetsDB.weapon.push("cannon1B");
         this._visualAssetsDB.weapon.push("cannon1C");
         this._visualAssetsDB.weapon.push("cannon2A");
         this._visualAssetsDB.weapon.push("cannon2B");
         this._visualAssetsDB.weapon.push("cannon3A");
         this._visualAssetsDB.weapon.push("cannon3B");
         this._visualAssetsDB.weapon.push("cannon4A");
         this._visualAssetsDB.weapon.push("cannon4B");
         this._visualAssetsDB.weapon.push("cannon4C");
         this._visualAssetsDB.weapon.push("cannon5A");
         this._visualAssetsDB.weapon.push("cannon5B");
         this._visualAssetsDB.weapon.push("cannon6A");
         this._visualAssetsDB.weapon.push("cannon6B");
         this._visualAssetsDB.weapon.push("cannon6C");
         this._visualAssetsDB.weapon.push("cannon7A");
         this._visualAssetsDB.weapon.push("cannon7B");
         this._visualAssetsDB.weapon.push("cannon7C");
         this._visualAssetsDB.weapon.push("cannon8A");
         this._visualAssetsDB.weapon.push("cannon8A2");
         this._visualAssetsDB.weapon.push("cannon8A3");
         this._visualAssetsDB.weapon.push("cannon8B");
         this._visualAssetsDB.weapon.push("cannon8B2");
         this._visualAssetsDB.weapon.push("cannon8B3");
         this._visualAssetsDB.weapon.push("cannon9A");
         this._visualAssetsDB.weapon.push("cannon9B");
         this._visualAssetsDB.weapon.push("cannon10A");
         this._visualAssetsDB.weapon.push("cannon10A2");
         this._visualAssetsDB.weapon.push("cannon10A3");
         this._visualAssetsDB.weapon.push("cannon10B");
         this._visualAssetsDB.weapon.push("cannon10B2");
         this._visualAssetsDB.weapon.push("cannon10B3");
         this._visualAssetsDB.weapon.push("cannon10C");
         this._visualAssetsDB.weapon.push("cannon10C2");
         this._visualAssetsDB.weapon.push("cannon10C3");
         this._visualAssetsDB.weapon.push("cannon11A1");
         this._visualAssetsDB.weapon.push("cannon11A2");
         this._visualAssetsDB.weapon.push("cannon11A3");
         this._visualAssetsDB.weapon.push("cannon11B1");
         this._visualAssetsDB.weapon.push("cannon11B2");
         this._visualAssetsDB.weapon.push("cannon11B3");
         this._visualAssetsDB.weapon.push("cannon11C1");
         this._visualAssetsDB.weapon.push("cannon11C2");
         this._visualAssetsDB.weapon.push("cannon11C3");
         this._visualAssetsDB.weapon.push("blaster1A");
         this._visualAssetsDB.weapon.push("blaster1B");
         this._visualAssetsDB.weapon.push("blaster2");
         this._visualAssetsDB.weapon.push("blaster3A");
         this._visualAssetsDB.weapon.push("blaster3B");
         this._visualAssetsDB.weapon.push("blaster3C");
         this._visualAssetsDB.weapon.push("blaster4A");
         this._visualAssetsDB.weapon.push("blaster4B");
         this._visualAssetsDB.weapon.push("blaster5A");
         this._visualAssetsDB.weapon.push("blaster5B");
         this._visualAssetsDB.weapon.push("blaster6A");
         this._visualAssetsDB.weapon.push("blaster6B");
         this._visualAssetsDB.weapon.push("blaster7A");
         this._visualAssetsDB.weapon.push("blaster7B");
         this._visualAssetsDB.weapon.push("blaster8A");
         this._visualAssetsDB.weapon.push("blaster8B");
         this._visualAssetsDB.weapon.push("blaster9A");
         this._visualAssetsDB.weapon.push("blaster9B");
         this._visualAssetsDB.weapon.push("blaster10");
         this._visualAssetsDB.weapon.push("blaster11A");
         this._visualAssetsDB.weapon.push("blaster11B");
         this._visualAssetsDB.weapon.push("blaster12A");
         this._visualAssetsDB.weapon.push("blaster12B");
         this._visualAssetsDB.weapon.push("blaster13A");
         this._visualAssetsDB.weapon.push("blaster13B");
         this._visualAssetsDB.weapon.push("blaster14A");
         this._visualAssetsDB.weapon.push("blaster14B");
         this._visualAssetsDB.weapon.push("blaster15A");
         this._visualAssetsDB.weapon.push("blaster15B");
         this._visualAssetsDB.weapon.push("blaster16A");
         this._visualAssetsDB.weapon.push("blaster16B");
         this._visualAssetsDB.weapon.push("blaster17");
         this._visualAssetsDB.weapon.push("blaster18A");
         this._visualAssetsDB.weapon.push("blaster18B");
         this._visualAssetsDB.weapon.push("blaster19A");
         this._visualAssetsDB.weapon.push("blaster19B");
         this._visualAssetsDB.weapon.push("blaster20A");
         this._visualAssetsDB.weapon.push("blaster20B");
         this._visualAssetsDB.weapon.push("blaster21A");
         this._visualAssetsDB.weapon.push("blaster21A2");
         this._visualAssetsDB.weapon.push("blaster21A3");
         this._visualAssetsDB.weapon.push("blaster21B");
         this._visualAssetsDB.weapon.push("blaster21B2");
         this._visualAssetsDB.weapon.push("blaster21B3");
         this._visualAssetsDB.weapon.push("blaster22A");
         this._visualAssetsDB.weapon.push("blaster22B");
         this._visualAssetsDB.weapon.push("blaster22C");
         this._visualAssetsDB.weapon.push("blaster23A");
         this._visualAssetsDB.weapon.push("blaster23B");
         this._visualAssetsDB.weapon.push("blaster23C");
         this._visualAssetsDB.weapon.push("blaster24A");
         this._visualAssetsDB.weapon.push("blaster24B");
         this._visualAssetsDB.weapon.push("blaster24C");
         this._visualAssetsDB.weapon.push("shotgun1A");
         this._visualAssetsDB.weapon.push("shotgun1A2");
         this._visualAssetsDB.weapon.push("shotgun1A3");
         this._visualAssetsDB.weapon.push("shotgun1B");
         this._visualAssetsDB.weapon.push("shotgun1B2");
         this._visualAssetsDB.weapon.push("shotgun1B3");
         this._visualAssetsDB.weapon.push("shotgun1C");
         this._visualAssetsDB.weapon.push("shotgun1C2");
         this._visualAssetsDB.weapon.push("shotgun1C3");
         this._visualAssetsDB.weapon.push("shotgun2A");
         this._visualAssetsDB.weapon.push("shotgun2A2");
         this._visualAssetsDB.weapon.push("shotgun2A3");
         this._visualAssetsDB.weapon.push("shotgun2B");
         this._visualAssetsDB.weapon.push("shotgun2B2");
         this._visualAssetsDB.weapon.push("shotgun2B3");
         this._visualAssetsDB.weapon.push("shotgun3A");
         this._visualAssetsDB.weapon.push("shotgun3B");
         this._visualAssetsDB.weapon.push("grenadeLauncher1A");
         this._visualAssetsDB.weapon.push("grenadeLauncher1A2");
         this._visualAssetsDB.weapon.push("grenadeLauncher1A3");
         this._visualAssetsDB.weapon.push("grenadeLauncher1B");
         this._visualAssetsDB.weapon.push("grenadeLauncher1B2");
         this._visualAssetsDB.weapon.push("grenadeLauncher1B3");
         this._visualAssetsDB.weapon.push("grenadeLauncher2A");
         this._visualAssetsDB.weapon.push("grenadeLauncher2A2");
         this._visualAssetsDB.weapon.push("grenadeLauncher2A3");
         this._visualAssetsDB.weapon.push("grenadeLauncher2B");
         this._visualAssetsDB.weapon.push("grenadeLauncher2B2");
         this._visualAssetsDB.weapon.push("grenadeLauncher2B3");
         this._visualAssetsDB.weapon.push("machineGun1");
         this._visualAssetsDB.weapon.push("machineGun2");
         this._visualAssetsDB.weapon.push("machineGun3A");
         this._visualAssetsDB.weapon.push("machineGun3B");
         this._visualAssetsDB.weapon.push("machineGun3C");
         this._visualAssetsDB.weapon.push("machineGun4A");
         this._visualAssetsDB.weapon.push("machineGun4B");
         this._visualAssetsDB.weapon.push("machineGun4C");
         this._visualAssetsDB.weapon.push("machineGun5A");
         this._visualAssetsDB.weapon.push("machineGun5B");
         this._visualAssetsDB.weapon.push("machineGun6A");
         this._visualAssetsDB.weapon.push("machineGun6B");
         this._visualAssetsDB.weapon.push("machineGun7A");
         this._visualAssetsDB.weapon.push("machineGun7B");
         this._visualAssetsDB.weapon.push("machineGun8A");
         this._visualAssetsDB.weapon.push("machineGun8B");
         this._visualAssetsDB.weapon.push("machineGun9A");
         this._visualAssetsDB.weapon.push("machineGun9B");
         this._visualAssetsDB.weapon.push("machineGun10A");
         this._visualAssetsDB.weapon.push("machineGun10B");
         this._visualAssetsDB.weapon.push("machineGun11A");
         this._visualAssetsDB.weapon.push("machineGun11B");
         this._visualAssetsDB.weapon.push("rocketLauncher1A");
         this._visualAssetsDB.weapon.push("rocketLauncher2A");
         this._visualAssetsDB.weapon.push("rocketLauncher2B");
         this._visualAssetsDB.weapon.push("rocketLauncher3");
         this._visualAssetsDB.weapon.push("rocketLauncher4");
         this._visualAssetsDB.weapon.push("rocketLauncher5");
         this._visualAssetsDB.weapon.push("rocketLauncher6");
         this._visualAssetsDB.weapon.push("rocketLauncher7");
         this._visualAssetsDB.weapon.push("rocketLauncher8A");
         this._visualAssetsDB.weapon.push("rocketLauncher8B");
         this._visualAssetsDB.weapon.push("rocketLauncher9A");
         this._visualAssetsDB.weapon.push("rocketLauncher9B");
         this._visualAssetsDB.weapon.push("rocketLauncher10A");
         this._visualAssetsDB.weapon.push("rocketLauncher10B");
         this._visualAssetsDB.weapon.push("rocketLauncher10C");
         this._visualAssetsDB.weapon.push("rocketLauncher11A");
         this._visualAssetsDB.weapon.push("rocketLauncher11B");
         this._visualAssetsDB.weapon.push("rocketLauncher11C");
         this._visualAssetsDB.weapon.push("rocketLauncher12");
         this._visualAssetsDB.weapon.push("rocketLauncher13");
         this._visualAssetsDB.weapon.push("rocketLauncher14A");
         this._visualAssetsDB.weapon.push("rocketLauncher14B");
         this._visualAssetsDB.weapon.push("rocketLauncher15A");
         this._visualAssetsDB.weapon.push("rocketLauncher15B");
         this._visualAssetsDB.weapon.push("rocketLauncher16A");
         this._visualAssetsDB.weapon.push("rocketLauncher16B");
         this._visualAssetsDB.weapon.push("rocketLauncher16C");
         this._visualAssetsDB.weapon.push("rocketLauncher17A");
         this._visualAssetsDB.weapon.push("rocketLauncher17B");
         this._visualAssetsDB.weapon.push("rocketLauncher17C");
         this._visualAssetsDB.weapon.push("rocketLauncher18A");
         this._visualAssetsDB.weapon.push("rocketLauncher18B");
         this._visualAssetsDB.weapon.push("rocketLauncher18C");
         this._visualAssetsDB.weapon.push("rocketLauncher19");
         this._visualAssetsDB.weapon.push("rocketLauncher20A");
         this._visualAssetsDB.weapon.push("rocketLauncher20B");
         this._visualAssetsDB.weapon.push("rocketLauncher21A");
         this._visualAssetsDB.weapon.push("rocketLauncher21B");
         this._visualAssetsDB.weapon.push("rocketLauncher22A");
         this._visualAssetsDB.weapon.push("rocketLauncher22B");
         this._visualAssetsDB.weapon.push("rocketLauncher22C");
         this._visualAssetsDB.weapon.push("rocketLauncher22D");
         this._visualAssetsDB.weapon.push("rocketLauncher23A");
         this._visualAssetsDB.weapon.push("rocketLauncher23B");
         this._visualAssetsDB.weapon.push("rocketLauncher23C");
         this._visualAssetsDB.weapon.push("rocketLauncher24A");
         this._visualAssetsDB.weapon.push("rocketLauncher24B");
         this._visualAssetsDB.weapon.push("rocketLauncher24C");
         this._visualAssetsDB.weapon.push("rocketLauncher25A");
         this._visualAssetsDB.weapon.push("rocketLauncher25B");
         this._visualAssetsDB.weapon.push("rocketLauncher25C");
         this._visualAssetsDB.weapon.push("rocketLauncher26A");
         this._visualAssetsDB.weapon.push("rocketLauncher26B");
         this._visualAssetsDB.weapon.push("rocketLauncher27A");
         this._visualAssetsDB.weapon.push("rocketLauncher27B");
         this._visualAssetsDB.weapon.push("rocketLauncher28A");
         this._visualAssetsDB.weapon.push("rocketLauncher28B");
         this._visualAssetsDB.weapon.push("rocketLauncher29A1");
         this._visualAssetsDB.weapon.push("rocketLauncher29A2");
         this._visualAssetsDB.weapon.push("rocketLauncher29A3");
         this._visualAssetsDB.weapon.push("rocketLauncher29B1");
         this._visualAssetsDB.weapon.push("rocketLauncher29B2");
         this._visualAssetsDB.weapon.push("rocketLauncher29B3");
         this._visualAssetsDB.weapon.push("rocketLauncher29C1");
         this._visualAssetsDB.weapon.push("rocketLauncher29C2");
         this._visualAssetsDB.weapon.push("rocketLauncher29C3");
         this._visualAssetsDB.weapon.push("flameThrower1");
         this._visualAssetsDB.weapon.push("flameThrower2");
         this._visualAssetsDB.weapon.push("flameThrower3");
         this._visualAssetsDB.weapon.push("flameThrower4");
         this._visualAssetsDB.weapon.push("flameThrower5A");
         this._visualAssetsDB.weapon.push("flameThrower5B");
         this._visualAssetsDB.weapon.push("flameThrower6");
         this._visualAssetsDB.weapon.push("flameThrower7A");
         this._visualAssetsDB.weapon.push("flameThrower7B");
         this._visualAssetsDB.weapon.push("flameThrower8A");
         this._visualAssetsDB.weapon.push("flameThrower8B");
         this._visualAssetsDB.weapon.push("flameThrower9A1");
         this._visualAssetsDB.weapon.push("flameThrower9A2");
         this._visualAssetsDB.weapon.push("flameThrower9B1");
         this._visualAssetsDB.weapon.push("flameThrower9B2");
         this._visualAssetsDB.weapon.push("flameThrower9C1");
         this._visualAssetsDB.weapon.push("flameThrower9C2");
         this._visualAssetsDB.weapon.push("flameThrower9D1");
         this._visualAssetsDB.weapon.push("flameThrower9D2");
         this._visualAssetsDB.weapon.push("sword1A");
         this._visualAssetsDB.weapon.push("sword1B");
         this._visualAssetsDB.weapon.push("sword1C");
         this._visualAssetsDB.weapon.push("sword1D");
         this._visualAssetsDB.weapon.push("sword2A");
         this._visualAssetsDB.weapon.push("sword2B");
         this._visualAssetsDB.weapon.push("sword2C");
         this._visualAssetsDB.weapon.push("sword2D");
         this._visualAssetsDB.weapon.push("sword3A");
         this._visualAssetsDB.weapon.push("sword3B");
         this._visualAssetsDB.weapon.push("sword3C");
         this._visualAssetsDB.weapon.push("sword3D");
         this._visualAssetsDB.weapon.push("sword4A");
         this._visualAssetsDB.weapon.push("sword4B");
         this._visualAssetsDB.weapon.push("sword4C");
         this._visualAssetsDB.weapon.push("sword4D");
         this._visualAssetsDB.weapon.push("sword5A");
         this._visualAssetsDB.weapon.push("sword5B");
         this._visualAssetsDB.weapon.push("sword5C");
         this._visualAssetsDB.weapon.push("sword5D");
         this._visualAssetsDB.weapon.push("sword6A");
         this._visualAssetsDB.weapon.push("sword6B");
         this._visualAssetsDB.weapon.push("sword6C");
         this._visualAssetsDB.weapon.push("sword6D");
         this._visualAssetsDB.weapon.push("sword7A");
         this._visualAssetsDB.weapon.push("sword7B");
         this._visualAssetsDB.weapon.push("sword7C");
         this._visualAssetsDB.weapon.push("sword7D");
         this._visualAssetsDB.weapon.push("sword8");
         this._visualAssetsDB.weapon.push("hammer1A");
         this._visualAssetsDB.weapon.push("hammer1B");
         this._visualAssetsDB.weapon.push("hammer1C");
         this._visualAssetsDB.weapon.push("axe1A");
         this._visualAssetsDB.weapon.push("axe1B");
         this._visualAssetsDB.weapon.push("axe1C");
         this._visualAssetsDB.weapon.push("wand1A");
         this._visualAssetsDB.sideWeapon = new Array();
         this._visualAssetsDB.sideWeapon.push("laser1A");
         this._visualAssetsDB.sideWeapon.push("laser1B");
         this._visualAssetsDB.sideWeapon.push("laser1C");
         this._visualAssetsDB.sideWeapon.push("laser2A");
         this._visualAssetsDB.sideWeapon.push("laser2B");
         this._visualAssetsDB.sideWeapon.push("laser2C");
         this._visualAssetsDB.sideWeapon.push("laser3");
         this._visualAssetsDB.sideWeapon.push("laser4A");
         this._visualAssetsDB.sideWeapon.push("laser4B");
         this._visualAssetsDB.sideWeapon.push("laser5A");
         this._visualAssetsDB.sideWeapon.push("laser5B");
         this._visualAssetsDB.sideWeapon.push("laser6");
         this._visualAssetsDB.sideWeapon.push("laser7A");
         this._visualAssetsDB.sideWeapon.push("laser7B");
         this._visualAssetsDB.sideWeapon.push("laser8A");
         this._visualAssetsDB.sideWeapon.push("laser8B");
         this._visualAssetsDB.sideWeapon.push("laser9");
         this._visualAssetsDB.sideWeapon.push("laser10");
         this._visualAssetsDB.sideWeapon.push("laser11A");
         this._visualAssetsDB.sideWeapon.push("laser11B");
         this._visualAssetsDB.sideWeapon.push("laser13");
         this._visualAssetsDB.sideWeapon.push("laser15");
         this._visualAssetsDB.sideWeapon.push("laser16");
         this._visualAssetsDB.sideWeapon.push("laser17A");
         this._visualAssetsDB.sideWeapon.push("laser17B");
         this._visualAssetsDB.sideWeapon.push("laser18");
         this._visualAssetsDB.sideWeapon.push("laser19");
         this._visualAssetsDB.sideWeapon.push("laser21A");
         this._visualAssetsDB.sideWeapon.push("laser21B");
         this._visualAssetsDB.sideWeapon.push("laser22A");
         this._visualAssetsDB.sideWeapon.push("laser22B");
         this._visualAssetsDB.sideWeapon.push("laser23A");
         this._visualAssetsDB.sideWeapon.push("laser23B");
         this._visualAssetsDB.sideWeapon.push("laser24A");
         this._visualAssetsDB.sideWeapon.push("laser24B");
         this._visualAssetsDB.sideWeapon.push("laser24C");
         this._visualAssetsDB.sideWeapon.push("laser27A");
         this._visualAssetsDB.sideWeapon.push("laser27B");
         this._visualAssetsDB.sideWeapon.push("laser27C");
         this._visualAssetsDB.sideWeapon.push("laser28A");
         this._visualAssetsDB.sideWeapon.push("laser28B");
         this._visualAssetsDB.sideWeapon.push("laser28C");
         this._visualAssetsDB.sideWeapon.push("laser30A");
         this._visualAssetsDB.sideWeapon.push("laser30B");
         this._visualAssetsDB.sideWeapon.push("laser30C");
         this._visualAssetsDB.sideWeapon.push("laser32A");
         this._visualAssetsDB.sideWeapon.push("laser32B");
         this._visualAssetsDB.sideWeapon.push("laser32C");
         this._visualAssetsDB.sideWeapon.push("laser33A");
         this._visualAssetsDB.sideWeapon.push("laser33B");
         this._visualAssetsDB.sideWeapon.push("laser33C");
         this._visualAssetsDB.sideWeapon.push("laser34A");
         this._visualAssetsDB.sideWeapon.push("laser34B");
         this._visualAssetsDB.sideWeapon.push("laser35");
         this._visualAssetsDB.sideWeapon.push("laser39A");
         this._visualAssetsDB.sideWeapon.push("laser39B");
         this._visualAssetsDB.sideWeapon.push("laser41A");
         this._visualAssetsDB.sideWeapon.push("laser41B");
         this._visualAssetsDB.sideWeapon.push("laser42A");
         this._visualAssetsDB.sideWeapon.push("laser42B");
         this._visualAssetsDB.sideWeapon.push("laser43A");
         this._visualAssetsDB.sideWeapon.push("laser43B");
         this._visualAssetsDB.sideWeapon.push("laser44A");
         this._visualAssetsDB.sideWeapon.push("laser44B");
         this._visualAssetsDB.sideWeapon.push("laser46A");
         this._visualAssetsDB.sideWeapon.push("laser46B");
         this._visualAssetsDB.sideWeapon.push("laser47A");
         this._visualAssetsDB.sideWeapon.push("laser47B");
         this._visualAssetsDB.sideWeapon.push("laser48A");
         this._visualAssetsDB.sideWeapon.push("laser48A2");
         this._visualAssetsDB.sideWeapon.push("laser48A3");
         this._visualAssetsDB.sideWeapon.push("laser48B");
         this._visualAssetsDB.sideWeapon.push("laser48B2");
         this._visualAssetsDB.sideWeapon.push("laser48B3");
         this._visualAssetsDB.sideWeapon.push("laser48C");
         this._visualAssetsDB.sideWeapon.push("laser48C2");
         this._visualAssetsDB.sideWeapon.push("laser48C3");
         this._visualAssetsDB.sideWeapon.push("laser1000");
         this._visualAssetsDB.sideWeapon.push("laser1001A");
         this._visualAssetsDB.sideWeapon.push("laser1001B");
         this._visualAssetsDB.sideWeapon.push("hand1A");
         this._visualAssetsDB.sideWeapon.push("hand1B");
         this._visualAssetsDB.sideWeapon.push("cannon3A");
         this._visualAssetsDB.sideWeapon.push("cannon3B");
         this._visualAssetsDB.sideWeapon.push("cannon6A");
         this._visualAssetsDB.sideWeapon.push("cannon6B");
         this._visualAssetsDB.sideWeapon.push("cannon6C");
         this._visualAssetsDB.sideWeapon.push("cannon10A");
         this._visualAssetsDB.sideWeapon.push("cannon10A2");
         this._visualAssetsDB.sideWeapon.push("cannon10A3");
         this._visualAssetsDB.sideWeapon.push("cannon10B");
         this._visualAssetsDB.sideWeapon.push("cannon10B2");
         this._visualAssetsDB.sideWeapon.push("cannon10B3");
         this._visualAssetsDB.sideWeapon.push("cannon10C");
         this._visualAssetsDB.sideWeapon.push("cannon10C2");
         this._visualAssetsDB.sideWeapon.push("cannon10C3");
         this._visualAssetsDB.sideWeapon.push("blaster1A");
         this._visualAssetsDB.sideWeapon.push("blaster1B");
         this._visualAssetsDB.sideWeapon.push("blaster2");
         this._visualAssetsDB.sideWeapon.push("blaster3A");
         this._visualAssetsDB.sideWeapon.push("blaster3B");
         this._visualAssetsDB.sideWeapon.push("blaster3C");
         this._visualAssetsDB.sideWeapon.push("blaster4A");
         this._visualAssetsDB.sideWeapon.push("blaster4B");
         this._visualAssetsDB.sideWeapon.push("blaster5A");
         this._visualAssetsDB.sideWeapon.push("blaster5B");
         this._visualAssetsDB.sideWeapon.push("blaster11A");
         this._visualAssetsDB.sideWeapon.push("blaster11B");
         this._visualAssetsDB.sideWeapon.push("blaster12A");
         this._visualAssetsDB.sideWeapon.push("blaster12B");
         this._visualAssetsDB.sideWeapon.push("blaster16A");
         this._visualAssetsDB.sideWeapon.push("blaster16B");
         this._visualAssetsDB.sideWeapon.push("blaster17");
         this._visualAssetsDB.sideWeapon.push("shotgun1A");
         this._visualAssetsDB.sideWeapon.push("shotgun1A2");
         this._visualAssetsDB.sideWeapon.push("shotgun1A3");
         this._visualAssetsDB.sideWeapon.push("shotgun1B");
         this._visualAssetsDB.sideWeapon.push("shotgun1B2");
         this._visualAssetsDB.sideWeapon.push("shotgun1B3");
         this._visualAssetsDB.sideWeapon.push("shotgun1C");
         this._visualAssetsDB.sideWeapon.push("shotgun1C2");
         this._visualAssetsDB.sideWeapon.push("shotgun1C3");
         this._visualAssetsDB.sideWeapon.push("shotgun2A");
         this._visualAssetsDB.sideWeapon.push("shotgun2A2");
         this._visualAssetsDB.sideWeapon.push("shotgun2A3");
         this._visualAssetsDB.sideWeapon.push("shotgun2B");
         this._visualAssetsDB.sideWeapon.push("shotgun2B2");
         this._visualAssetsDB.sideWeapon.push("shotgun2B3");
         this._visualAssetsDB.sideWeapon.push("shotgun3A");
         this._visualAssetsDB.sideWeapon.push("shotgun3B");
         this._visualAssetsDB.sideWeapon.push("grenadeLauncher2A");
         this._visualAssetsDB.sideWeapon.push("grenadeLauncher2A2");
         this._visualAssetsDB.sideWeapon.push("grenadeLauncher2A3");
         this._visualAssetsDB.sideWeapon.push("grenadeLauncher2B");
         this._visualAssetsDB.sideWeapon.push("grenadeLauncher2B2");
         this._visualAssetsDB.sideWeapon.push("grenadeLauncher2B3");
         this._visualAssetsDB.sideWeapon.push("machineGun1");
         this._visualAssetsDB.sideWeapon.push("machineGun2");
         this._visualAssetsDB.sideWeapon.push("machineGun3A");
         this._visualAssetsDB.sideWeapon.push("machineGun3B");
         this._visualAssetsDB.sideWeapon.push("machineGun3C");
         this._visualAssetsDB.sideWeapon.push("machineGun4A");
         this._visualAssetsDB.sideWeapon.push("machineGun4B");
         this._visualAssetsDB.sideWeapon.push("machineGun4C");
         this._visualAssetsDB.sideWeapon.push("machineGun5A");
         this._visualAssetsDB.sideWeapon.push("machineGun5B");
         this._visualAssetsDB.sideWeapon.push("machineGun8A");
         this._visualAssetsDB.sideWeapon.push("machineGun8B");
         this._visualAssetsDB.sideWeapon.push("machineGun10A");
         this._visualAssetsDB.sideWeapon.push("machineGun10B");
         this._visualAssetsDB.sideWeapon.push("machineGun11A");
         this._visualAssetsDB.sideWeapon.push("machineGun11B");
         this._visualAssetsDB.sideWeapon.push("rocketLauncher4");
         this._visualAssetsDB.sideWeapon.push("rocketLauncher5");
         this._visualAssetsDB.sideWeapon.push("rocketLauncher10A");
         this._visualAssetsDB.sideWeapon.push("rocketLauncher10B");
         this._visualAssetsDB.sideWeapon.push("rocketLauncher10C");
         this._visualAssetsDB.sideWeapon.push("rocketLauncher12");
         this._visualAssetsDB.sideWeapon.push("rocketLauncher13");
         this._visualAssetsDB.sideWeapon.push("rocketLauncher14A");
         this._visualAssetsDB.sideWeapon.push("rocketLauncher14B");
         this._visualAssetsDB.sideWeapon.push("rocketLauncher15A");
         this._visualAssetsDB.sideWeapon.push("rocketLauncher15B");
         this._visualAssetsDB.sideWeapon.push("rocketLauncher16A");
         this._visualAssetsDB.sideWeapon.push("rocketLauncher16B");
         this._visualAssetsDB.sideWeapon.push("rocketLauncher16C");
         this._visualAssetsDB.sideWeapon.push("rocketLauncher17A");
         this._visualAssetsDB.sideWeapon.push("rocketLauncher17B");
         this._visualAssetsDB.sideWeapon.push("rocketLauncher17C");
         this._visualAssetsDB.sideWeapon.push("rocketLauncher29A1");
         this._visualAssetsDB.sideWeapon.push("rocketLauncher29A2");
         this._visualAssetsDB.sideWeapon.push("rocketLauncher29A3");
         this._visualAssetsDB.sideWeapon.push("rocketLauncher29B1");
         this._visualAssetsDB.sideWeapon.push("rocketLauncher29B2");
         this._visualAssetsDB.sideWeapon.push("rocketLauncher29B3");
         this._visualAssetsDB.sideWeapon.push("rocketLauncher29C1");
         this._visualAssetsDB.sideWeapon.push("rocketLauncher29C2");
         this._visualAssetsDB.sideWeapon.push("rocketLauncher29C3");
         this._visualAssetsDB.sideWeapon.push("flameThrower1");
         this._visualAssetsDB.sideWeapon.push("flameThrower2");
         this._visualAssetsDB.sideWeapon.push("flameThrower3");
         this._visualAssetsDB.sideWeapon.push("flameThrower4");
         this._visualAssetsDB.sideWeapon.push("flameThrower5A");
         this._visualAssetsDB.sideWeapon.push("flameThrower5B");
         this._visualAssetsDB.sideWeapon.push("flameThrower6");
         this._visualAssetsDB.sideWeapon.push("flameThrower7A");
         this._visualAssetsDB.sideWeapon.push("flameThrower7B");
         this._visualAssetsDB.sideWeapon.push("flameThrower8A");
         this._visualAssetsDB.sideWeapon.push("flameThrower8B");
         this._visualAssetsDB.sideWeapon.push("flameThrower9A1");
         this._visualAssetsDB.sideWeapon.push("flameThrower9A2");
         this._visualAssetsDB.sideWeapon.push("flameThrower9B1");
         this._visualAssetsDB.sideWeapon.push("flameThrower9B2");
         this._visualAssetsDB.sideWeapon.push("flameThrower9C1");
         this._visualAssetsDB.sideWeapon.push("flameThrower9C2");
         this._visualAssetsDB.sideWeapon.push("flameThrower9D1");
         this._visualAssetsDB.sideWeapon.push("flameThrower9D2");
         this._visualAssetsDB.sideWeapon.push("sword1A");
         this._visualAssetsDB.sideWeapon.push("sword1B");
         this._visualAssetsDB.sideWeapon.push("sword1C");
         this._visualAssetsDB.sideWeapon.push("sword1D");
         this._visualAssetsDB.sideWeapon.push("sword2A");
         this._visualAssetsDB.sideWeapon.push("sword2B");
         this._visualAssetsDB.sideWeapon.push("sword2C");
         this._visualAssetsDB.sideWeapon.push("sword2D");
         this._visualAssetsDB.sideWeapon.push("sword3A");
         this._visualAssetsDB.sideWeapon.push("sword3B");
         this._visualAssetsDB.sideWeapon.push("sword3C");
         this._visualAssetsDB.sideWeapon.push("sword3D");
         this._visualAssetsDB.sideWeapon.push("sword4A");
         this._visualAssetsDB.sideWeapon.push("sword4B");
         this._visualAssetsDB.sideWeapon.push("sword4C");
         this._visualAssetsDB.sideWeapon.push("sword4D");
         this._visualAssetsDB.sideWeapon.push("sword5A");
         this._visualAssetsDB.sideWeapon.push("sword5B");
         this._visualAssetsDB.sideWeapon.push("sword5C");
         this._visualAssetsDB.sideWeapon.push("sword5D");
         this._visualAssetsDB.sideWeapon.push("sword6A");
         this._visualAssetsDB.sideWeapon.push("sword6B");
         this._visualAssetsDB.sideWeapon.push("sword6C");
         this._visualAssetsDB.sideWeapon.push("sword6D");
         this._visualAssetsDB.sideWeapon.push("sword7A");
         this._visualAssetsDB.sideWeapon.push("sword7B");
         this._visualAssetsDB.sideWeapon.push("sword7C");
         this._visualAssetsDB.sideWeapon.push("sword7D");
         this._visualAssetsDB.sideWeapon.push("sword8");
         this._visualAssetsDB.sideWeapon.push("hammer1A");
         this._visualAssetsDB.sideWeapon.push("hammer1B");
         this._visualAssetsDB.sideWeapon.push("hammer1C");
         this._visualAssetsDB.sideWeapon.push("axe1A");
         this._visualAssetsDB.sideWeapon.push("axe1B");
         this._visualAssetsDB.sideWeapon.push("axe1C");
         this._visualAssetsDB.sideWeapon.push("wand1A");
         this._visualAssetsDB.topWeapon = new Array();
         this._visualAssetsDB.topWeapon.push("laser12A");
         this._visualAssetsDB.topWeapon.push("laser12B");
         this._visualAssetsDB.topWeapon.push("laser12C");
         this._visualAssetsDB.topWeapon.push("laser14");
         this._visualAssetsDB.topWeapon.push("laser20A");
         this._visualAssetsDB.topWeapon.push("laser20B");
         this._visualAssetsDB.topWeapon.push("laser25A");
         this._visualAssetsDB.topWeapon.push("laser25B");
         this._visualAssetsDB.topWeapon.push("laser26A");
         this._visualAssetsDB.topWeapon.push("laser26B");
         this._visualAssetsDB.topWeapon.push("laser29A");
         this._visualAssetsDB.topWeapon.push("laser29B");
         this._visualAssetsDB.topWeapon.push("laser29C");
         this._visualAssetsDB.topWeapon.push("laser31A");
         this._visualAssetsDB.topWeapon.push("laser31B");
         this._visualAssetsDB.topWeapon.push("laser31C");
         this._visualAssetsDB.topWeapon.push("laser36A");
         this._visualAssetsDB.topWeapon.push("laser36B");
         this._visualAssetsDB.topWeapon.push("laser36C");
         this._visualAssetsDB.topWeapon.push("laser37A");
         this._visualAssetsDB.topWeapon.push("laser37B");
         this._visualAssetsDB.topWeapon.push("laser38A");
         this._visualAssetsDB.topWeapon.push("laser38B");
         this._visualAssetsDB.topWeapon.push("laser40A");
         this._visualAssetsDB.topWeapon.push("laser40A2");
         this._visualAssetsDB.topWeapon.push("laser40A3");
         this._visualAssetsDB.topWeapon.push("laser40B");
         this._visualAssetsDB.topWeapon.push("laser40B2");
         this._visualAssetsDB.topWeapon.push("laser40B3");
         this._visualAssetsDB.topWeapon.push("laser45");
         this._visualAssetsDB.topWeapon.push("cannon1A");
         this._visualAssetsDB.topWeapon.push("cannon1B");
         this._visualAssetsDB.topWeapon.push("cannon1C");
         this._visualAssetsDB.topWeapon.push("cannon2A");
         this._visualAssetsDB.topWeapon.push("cannon2B");
         this._visualAssetsDB.topWeapon.push("cannon4A");
         this._visualAssetsDB.topWeapon.push("cannon4B");
         this._visualAssetsDB.topWeapon.push("cannon4C");
         this._visualAssetsDB.topWeapon.push("cannon5A");
         this._visualAssetsDB.topWeapon.push("cannon5B");
         this._visualAssetsDB.topWeapon.push("cannon7A");
         this._visualAssetsDB.topWeapon.push("cannon7B");
         this._visualAssetsDB.topWeapon.push("cannon7C");
         this._visualAssetsDB.topWeapon.push("cannon8A");
         this._visualAssetsDB.topWeapon.push("cannon8A2");
         this._visualAssetsDB.topWeapon.push("cannon8A3");
         this._visualAssetsDB.topWeapon.push("cannon8B");
         this._visualAssetsDB.topWeapon.push("cannon8B2");
         this._visualAssetsDB.topWeapon.push("cannon8B3");
         this._visualAssetsDB.topWeapon.push("cannon9A");
         this._visualAssetsDB.topWeapon.push("cannon9B");
         this._visualAssetsDB.topWeapon.push("cannon11A1");
         this._visualAssetsDB.topWeapon.push("cannon11A2");
         this._visualAssetsDB.topWeapon.push("cannon11A3");
         this._visualAssetsDB.topWeapon.push("cannon11B1");
         this._visualAssetsDB.topWeapon.push("cannon11B2");
         this._visualAssetsDB.topWeapon.push("cannon11B3");
         this._visualAssetsDB.topWeapon.push("cannon11C1");
         this._visualAssetsDB.topWeapon.push("cannon11C2");
         this._visualAssetsDB.topWeapon.push("cannon11C3");
         this._visualAssetsDB.topWeapon.push("blaster6A");
         this._visualAssetsDB.topWeapon.push("blaster6B");
         this._visualAssetsDB.topWeapon.push("blaster7A");
         this._visualAssetsDB.topWeapon.push("blaster7B");
         this._visualAssetsDB.topWeapon.push("blaster8A");
         this._visualAssetsDB.topWeapon.push("blaster8B");
         this._visualAssetsDB.topWeapon.push("blaster9A");
         this._visualAssetsDB.topWeapon.push("blaster9B");
         this._visualAssetsDB.topWeapon.push("blaster10");
         this._visualAssetsDB.topWeapon.push("blaster13A");
         this._visualAssetsDB.topWeapon.push("blaster13B");
         this._visualAssetsDB.topWeapon.push("blaster14A");
         this._visualAssetsDB.topWeapon.push("blaster14B");
         this._visualAssetsDB.topWeapon.push("blaster15A");
         this._visualAssetsDB.topWeapon.push("blaster15B");
         this._visualAssetsDB.topWeapon.push("blaster18A");
         this._visualAssetsDB.topWeapon.push("blaster18B");
         this._visualAssetsDB.topWeapon.push("blaster19A");
         this._visualAssetsDB.topWeapon.push("blaster19B");
         this._visualAssetsDB.topWeapon.push("blaster20A");
         this._visualAssetsDB.topWeapon.push("blaster20B");
         this._visualAssetsDB.topWeapon.push("blaster21A");
         this._visualAssetsDB.topWeapon.push("blaster21A2");
         this._visualAssetsDB.topWeapon.push("blaster21A3");
         this._visualAssetsDB.topWeapon.push("blaster21B");
         this._visualAssetsDB.topWeapon.push("blaster21B2");
         this._visualAssetsDB.topWeapon.push("blaster21B3");
         this._visualAssetsDB.topWeapon.push("blaster22A");
         this._visualAssetsDB.topWeapon.push("blaster22B");
         this._visualAssetsDB.topWeapon.push("blaster22C");
         this._visualAssetsDB.topWeapon.push("blaster23A");
         this._visualAssetsDB.topWeapon.push("blaster23B");
         this._visualAssetsDB.topWeapon.push("blaster23C");
         this._visualAssetsDB.topWeapon.push("blaster24A");
         this._visualAssetsDB.topWeapon.push("blaster24B");
         this._visualAssetsDB.topWeapon.push("blaster24C");
         this._visualAssetsDB.topWeapon.push("grenadeLauncher1A");
         this._visualAssetsDB.topWeapon.push("grenadeLauncher1A2");
         this._visualAssetsDB.topWeapon.push("grenadeLauncher1A3");
         this._visualAssetsDB.topWeapon.push("grenadeLauncher1B");
         this._visualAssetsDB.topWeapon.push("grenadeLauncher1B2");
         this._visualAssetsDB.topWeapon.push("grenadeLauncher1B3");
         this._visualAssetsDB.topWeapon.push("machineGun6A");
         this._visualAssetsDB.topWeapon.push("machineGun6B");
         this._visualAssetsDB.topWeapon.push("machineGun7A");
         this._visualAssetsDB.topWeapon.push("machineGun7B");
         this._visualAssetsDB.topWeapon.push("machineGun9A");
         this._visualAssetsDB.topWeapon.push("machineGun9B");
         this._visualAssetsDB.topWeapon.push("rocketLauncher1A");
         this._visualAssetsDB.topWeapon.push("rocketLauncher2A");
         this._visualAssetsDB.topWeapon.push("rocketLauncher2B");
         this._visualAssetsDB.topWeapon.push("rocketLauncher3");
         this._visualAssetsDB.topWeapon.push("rocketLauncher6");
         this._visualAssetsDB.topWeapon.push("rocketLauncher7");
         this._visualAssetsDB.topWeapon.push("rocketLauncher8A");
         this._visualAssetsDB.topWeapon.push("rocketLauncher8B");
         this._visualAssetsDB.topWeapon.push("rocketLauncher9A");
         this._visualAssetsDB.topWeapon.push("rocketLauncher9B");
         this._visualAssetsDB.topWeapon.push("rocketLauncher11A");
         this._visualAssetsDB.topWeapon.push("rocketLauncher11B");
         this._visualAssetsDB.topWeapon.push("rocketLauncher11C");
         this._visualAssetsDB.topWeapon.push("rocketLauncher18A");
         this._visualAssetsDB.topWeapon.push("rocketLauncher18B");
         this._visualAssetsDB.topWeapon.push("rocketLauncher18C");
         this._visualAssetsDB.topWeapon.push("rocketLauncher19");
         this._visualAssetsDB.topWeapon.push("rocketLauncher20A");
         this._visualAssetsDB.topWeapon.push("rocketLauncher20B");
         this._visualAssetsDB.topWeapon.push("rocketLauncher21A");
         this._visualAssetsDB.topWeapon.push("rocketLauncher21B");
         this._visualAssetsDB.topWeapon.push("rocketLauncher22A");
         this._visualAssetsDB.topWeapon.push("rocketLauncher22B");
         this._visualAssetsDB.topWeapon.push("rocketLauncher22C");
         this._visualAssetsDB.topWeapon.push("rocketLauncher22D");
         this._visualAssetsDB.topWeapon.push("rocketLauncher23A");
         this._visualAssetsDB.topWeapon.push("rocketLauncher23B");
         this._visualAssetsDB.topWeapon.push("rocketLauncher23C");
         this._visualAssetsDB.topWeapon.push("rocketLauncher24A");
         this._visualAssetsDB.topWeapon.push("rocketLauncher24B");
         this._visualAssetsDB.topWeapon.push("rocketLauncher24C");
         this._visualAssetsDB.topWeapon.push("rocketLauncher25A");
         this._visualAssetsDB.topWeapon.push("rocketLauncher25B");
         this._visualAssetsDB.topWeapon.push("rocketLauncher25C");
         this._visualAssetsDB.topWeapon.push("rocketLauncher26A");
         this._visualAssetsDB.topWeapon.push("rocketLauncher26B");
         this._visualAssetsDB.topWeapon.push("rocketLauncher27A");
         this._visualAssetsDB.topWeapon.push("rocketLauncher27B");
         this._visualAssetsDB.topWeapon.push("rocketLauncher28A");
         this._visualAssetsDB.topWeapon.push("rocketLauncher28B");
         this._visualAssetsDB.drone = new Array();
         this._visualAssetsDB.drone.push("drone1");
         this._visualAssetsDB.drone.push("drone2");
         this._visualAssetsDB.drone.push("drone3");
         this._visualAssetsDB.drone.push("drone4A");
         this._visualAssetsDB.drone.push("drone4B");
         this._visualAssetsDB.drone.push("drone5A");
         this._visualAssetsDB.drone.push("drone5B");
         this._visualAssetsDB.drone.push("drone6A");
         this._visualAssetsDB.drone.push("drone6B");
         this._visualAssetsDB.drone.push("drone7A");
         this._visualAssetsDB.drone.push("drone7B");
         this._visualAssetsDB.drone.push("drone8");
         this._visualAssetsDB.drone.push("drone9");
         this._visualAssetsDB.drone.push("drone10");
         this._visualAssetsDB.drone.push("drone11");
         this._visualAssetsDB.drone.push("drone12A");
         this._visualAssetsDB.drone.push("drone12B");
         this._visualAssetsDB.drone.push("drone13");
         this._visualAssetsDB.drone.push("drone14");
         this._visualAssetsDB.drone.push("drone15A");
         this._visualAssetsDB.drone.push("drone15B");
         this._visualAssetsDB.drone.push("drone16");
         this._visualAssetsDB.drone.push("drone17");
         this._visualAssetsDB.drone.push("drone18");
         this._visualAssetsDB.drone.push("drone19A");
         this._visualAssetsDB.drone.push("drone19B");
         this._visualAssetsDB.drone.push("drone20");
         this._visualAssetsDB.drone.push("drone21A");
         this._visualAssetsDB.drone.push("drone21B");
         this._visualAssetsDB.drone.push("drone22");
         this._visualAssetsDB.drone.push("drone23");
         this._visualAssetsDB.drone.push("drone24");
         this._visualAssetsDB.drone.push("drone25");
         this._visualAssetsDB.drone.push("drone26A");
         this._visualAssetsDB.drone.push("drone26B");
         this._visualAssetsDB.drone.push("drone26C");
         this._visualAssetsDB.drone.push("drone27A");
         this._visualAssetsDB.drone.push("drone27B");
         this._visualAssetsDB.drone.push("drone27C");
         this._visualAssetsDB.drone.push("drone28");
         this._visualAssetsDB.drone.push("drone29");
         this._visualAssetsDB.drone.push("drone30");
         this._visualAssetsDB.drone.push("drone31A");
         this._visualAssetsDB.drone.push("drone31B");
         this._visualAssetsDB.drone.push("drone32A");
         this._visualAssetsDB.drone.push("drone32B");
         this._visualAssetsDB.drone.push("drone33");
         this._visualAssetsDB.drone.push("drone34");
         this._visualAssetsDB.drone.push("drone34B");
         this._visualAssetsDB.drone.push("drone34C");
         this._visualAssetsDB.drone.push("drone35");
         this._visualAssetsDB.drone.push("drone35B");
         this._visualAssetsDB.drone.push("drone36A");
         this._visualAssetsDB.drone.push("drone36B");
         this._visualAssetsDB.drone.push("drone36C");
         this._visualAssetsDB.drone.push("drone37A");
         this._visualAssetsDB.drone.push("drone37B");
         this._visualAssetsDB.drone.push("drone38A");
         this._visualAssetsDB.drone.push("drone38B");
         this._visualAssetsDB.drone.push("drone39A");
         this._visualAssetsDB.drone.push("drone39B");
         this._visualAssetsDB.drone.push("drone40A");
         this._visualAssetsDB.drone.push("drone40B");
         this._visualAssetsDB.shield = new Array();
         this._visualAssetsDB.shield.push("shield1A");
         this._visualAssetsDB.shield.push("shield1B");
         this._visualAssetsDB.shield.push("shield2A");
         this._visualAssetsDB.shield.push("shield2B");
         this._visualAssetsDB.shield.push("shield3A");
         this._visualAssetsDB.shield.push("shield3B");
         this._visualAssetsDB.shield.push("shield4A");
         this._visualAssetsDB.shield.push("shield4B");
         this._visualAssetsDB.shield.push("shield5A");
         this._visualAssetsDB.shield.push("shield5B");
         this._visualAssetsDB.shield.push("shield6A");
         this._visualAssetsDB.shield.push("shield6B");
         this._visualAssetsDB.shield.push("shield7A");
         this._visualAssetsDB.shield.push("shield7B");
         this._visualAssetsDB.shield.push("shield8A");
         this._visualAssetsDB.shield.push("shield8B");
         this._visualAssetsDB.shield.push("shield9A");
         this._visualAssetsDB.shield.push("shield9B");
         this._visualAssetsDB.teleport = new Array();
         this._visualAssetsDB.teleport.push("teleport1");
         this._visualAssetsDB.teleport.push("teleport2");
         this._visualAssetsDB.teleport.push("teleport3");
         this._visualAssetsDB.teleport.push("teleport4");
         this._visualAssetsDB.teleport.push("teleport5");
         this._visualAssetsDB.teleport.push("teleport6");
         this._visualAssetsDB.teleport.push("teleport7");
         this._visualAssetsDB.teleport.push("teleport8");
         this._visualAssetsDB.teleport.push("teleport9");
         this._visualAssetsDB.charge = new Array();
         this._visualAssetsDB.charge.push("charge1");
         this._visualAssetsDB.charge.push("charge2");
         this._visualAssetsDB.charge.push("charge3");
         this._visualAssetsDB.charge.push("charge4");
         this._visualAssetsDB.charge.push("charge5");
         this._visualAssetsDB.charge.push("charge6");
         this._visualAssetsDB.charge.push("charge7");
         this._visualAssetsDB.charge.push("charge8");
         this._visualAssetsDB.harpoon = new Array();
         this._visualAssetsDB.harpoon.push("harpoon1");
         this._visualAssetsDB.harpoon.push("harpoon2");
         this._visualAssetsDB.harpoon.push("harpoon3");
         this._visualAssetsDB.harpoon.push("harpoon4");
         this._visualAssetsDB.harpoon.push("harpoon5A");
         this._visualAssetsDB.harpoon.push("harpoon5B");
         this._visualAssetsDB.harpoon.push("harpoon5C");
         this._visualAssetsDB.harpoon.push("harpoon5D");
         this._visualAssetsDB.harpoon.push("harpoon6A");
         this._visualAssetsDB.harpoon.push("harpoon6B");
         this._visualAssetsDB.harpoon.push("harpoon6C");
         this._visualAssetsDB.harpoon.push("harpoon6D");
         this._visualAssetsDB.module = new Array();
         this._visualAssetsDB.module.push("module_energy1");
         this._visualAssetsDB.module.push("module_energy2");
         this._visualAssetsDB.module.push("module_energy3");
         this._visualAssetsDB.module.push("module_energy4");
         this._visualAssetsDB.module.push("module_energy5");
         this._visualAssetsDB.module.push("module_energy6");
         this._visualAssetsDB.module.push("module_energy7");
         this._visualAssetsDB.module.push("module_energy8");
         this._visualAssetsDB.module.push("module_energy9");
         this._visualAssetsDB.module.push("module_energy10");
         this._visualAssetsDB.module.push("module_energy11");
         this._visualAssetsDB.module.push("module_energy12");
         this._visualAssetsDB.module.push("module_energy13");
         this._visualAssetsDB.module.push("module_energy14");
         this._visualAssetsDB.module.push("module_energy15");
         this._visualAssetsDB.module.push("module_energy101");
         this._visualAssetsDB.module.push("module_energy102");
         this._visualAssetsDB.module.push("module_energy103");
         this._visualAssetsDB.module.push("module_energy104");
         this._visualAssetsDB.module.push("module_energy105");
         this._visualAssetsDB.module.push("module_energy106");
         this._visualAssetsDB.module.push("module_heat1");
         this._visualAssetsDB.module.push("module_heat2");
         this._visualAssetsDB.module.push("module_heat3");
         this._visualAssetsDB.module.push("module_heat4");
         this._visualAssetsDB.module.push("module_heat5");
         this._visualAssetsDB.module.push("module_heat6");
         this._visualAssetsDB.module.push("module_heat7");
         this._visualAssetsDB.module.push("module_heat8");
         this._visualAssetsDB.module.push("module_heat9");
         this._visualAssetsDB.module.push("module_heat10");
         this._visualAssetsDB.module.push("module_heat11");
         this._visualAssetsDB.module.push("module_heat12");
         this._visualAssetsDB.module.push("module_heat13");
         this._visualAssetsDB.module.push("module_heat14");
         this._visualAssetsDB.module.push("module_heat15");
         this._visualAssetsDB.module.push("module_heat101");
         this._visualAssetsDB.module.push("module_heat102");
         this._visualAssetsDB.module.push("module_heat103");
         this._visualAssetsDB.module.push("module_heat104");
         this._visualAssetsDB.module.push("module_heat105");
         this._visualAssetsDB.module.push("module_heat106");
         this._visualAssetsDB.module.push("module_energyHeat1");
         this._visualAssetsDB.module.push("module_energyHeat2");
         this._visualAssetsDB.module.push("module_energyHeat3");
         this._visualAssetsDB.module.push("module_energyHeat4");
         this._visualAssetsDB.module.push("module_energyHeat5");
         this._visualAssetsDB.module.push("module_energyHeat6");
         this._visualAssetsDB.module.push("module_energyHeat7");
         this._visualAssetsDB.module.push("module_energyHeat8");
         this._visualAssetsDB.module.push("module_energyHeat9");
         this._visualAssetsDB.module.push("module_energyHeat10");
         this._visualAssetsDB.module.push("module_energyHeat11");
         this._visualAssetsDB.module.push("module_energyHeat12");
         this._visualAssetsDB.module.push("module_energyHeat13");
         this._visualAssetsDB.module.push("module_energyHeat14");
         this._visualAssetsDB.module.push("module_energyHeat15");
         this._visualAssetsDB.module.push("module_HP1");
         this._visualAssetsDB.module.push("module_HP2");
         this._visualAssetsDB.module.push("module_HP3");
         this._visualAssetsDB.module.push("module_HP4");
         this._visualAssetsDB.module.push("module_HP5");
         this._visualAssetsDB.module.push("module_HP6");
         this._visualAssetsDB.module.push("module_HP7");
         this._visualAssetsDB.module.push("module_HP8");
         this._visualAssetsDB.module.push("module_HP9");
         this._visualAssetsDB.module.push("module_HP10");
         this._visualAssetsDB.module.push("module_HP11");
         this._visualAssetsDB.module.push("module_HP12");
         this._visualAssetsDB.module.push("module_HP13");
         this._visualAssetsDB.module.push("module_HP14");
         this._visualAssetsDB.module.push("module_HP15");
         this._visualAssetsDB.module.push("module_bullets1");
         this._visualAssetsDB.module.push("module_bullets2");
         this._visualAssetsDB.module.push("module_bullets3");
         this._visualAssetsDB.module.push("module_bullets4");
         this._visualAssetsDB.module.push("module_bullets5");
         this._visualAssetsDB.module.push("module_bullets6");
         this._visualAssetsDB.module.push("module_bullets7");
         this._visualAssetsDB.module.push("module_bullets8");
         this._visualAssetsDB.module.push("module_bullets9");
         this._visualAssetsDB.module.push("module_bullets10");
         this._visualAssetsDB.module.push("module_bullets11");
         this._visualAssetsDB.module.push("module_bullets12");
         this._visualAssetsDB.module.push("module_bullets13");
         this._visualAssetsDB.module.push("module_bullets14");
         this._visualAssetsDB.module.push("module_bullets15");
         this._visualAssetsDB.module.push("module_rockets1");
         this._visualAssetsDB.module.push("module_rockets2");
         this._visualAssetsDB.module.push("module_rockets3");
         this._visualAssetsDB.module.push("module_rockets4");
         this._visualAssetsDB.module.push("module_rockets5");
         this._visualAssetsDB.module.push("module_rockets6");
         this._visualAssetsDB.module.push("module_rockets7");
         this._visualAssetsDB.module.push("module_rockets8");
         this._visualAssetsDB.module.push("module_rockets9");
         this._visualAssetsDB.module.push("module_rockets10");
         this._visualAssetsDB.module.push("module_rockets11");
         this._visualAssetsDB.module.push("module_rockets12");
         this._visualAssetsDB.module.push("module_rockets13");
         this._visualAssetsDB.module.push("module_rockets14");
         this._visualAssetsDB.module.push("module_rockets15");
         this._visualAssetsDB.module.push("module_bulletsRockets_1_1");
         this._visualAssetsDB.module.push("module_bulletsRockets_1_2");
         this._visualAssetsDB.module.push("module_bulletsRockets_1_3");
         this._visualAssetsDB.module.push("module_bulletsRockets_1_4");
         this._visualAssetsDB.module.push("module_bulletsRockets_2_1");
         this._visualAssetsDB.module.push("module_bulletsRockets_2_2");
         this._visualAssetsDB.module.push("module_bulletsRockets_2_3");
         this._visualAssetsDB.module.push("module_bulletsRockets_2_4");
         this._visualAssetsDB.module.push("module_bulletsRockets_3_1");
         this._visualAssetsDB.module.push("module_bulletsRockets_3_2");
         this._visualAssetsDB.module.push("module_bulletsRockets_3_3");
         this._visualAssetsDB.module.push("module_bulletsRockets_3_4");
         this._visualAssetsDB.module.push("module_bulletsRockets_4_1");
         this._visualAssetsDB.module.push("module_bulletsRockets_4_2");
         this._visualAssetsDB.module.push("module_bulletsRockets_4_3");
         this._visualAssetsDB.module.push("module_bulletsRockets_4_4");
         this._visualAssetsDB.module.push("module_bulletsRockets_5_5");
         this._visualAssetsDB.module.push("module_bulletsRockets_5_6");
         this._visualAssetsDB.module.push("module_bulletsRockets_5_7");
         this._visualAssetsDB.module.push("module_bulletsRockets_5_8");
         this._visualAssetsDB.module.push("module_bulletsRockets_6_5");
         this._visualAssetsDB.module.push("module_bulletsRockets_6_6");
         this._visualAssetsDB.module.push("module_bulletsRockets_6_7");
         this._visualAssetsDB.module.push("module_bulletsRockets_6_8");
         this._visualAssetsDB.module.push("module_bulletsRockets_7_5");
         this._visualAssetsDB.module.push("module_bulletsRockets_7_6");
         this._visualAssetsDB.module.push("module_bulletsRockets_7_7");
         this._visualAssetsDB.module.push("module_bulletsRockets_7_8");
         this._visualAssetsDB.module.push("module_bulletsRockets_8_5");
         this._visualAssetsDB.module.push("module_bulletsRockets_8_6");
         this._visualAssetsDB.module.push("module_bulletsRockets_8_7");
         this._visualAssetsDB.module.push("module_bulletsRockets_8_8");
         this._visualAssetsDB.module.push("module_mixed1");
         this._visualAssetsDB.module.push("module_mixed2");
         this._visualAssetsDB.module.push("module_mixed3");
         this._visualAssetsDB.module.push("module_mixed4");
         this._visualAssetsDB.module.push("module_resistanceElectric1");
         this._visualAssetsDB.module.push("module_resistanceElectric2");
         this._visualAssetsDB.module.push("module_resistanceElectric3");
         this._visualAssetsDB.module.push("module_resistanceElectric4");
         this._visualAssetsDB.module.push("module_resistanceElectric5");
         this._visualAssetsDB.module.push("module_resistanceElectric6");
         this._visualAssetsDB.module.push("module_resistanceElectric7");
         this._visualAssetsDB.module.push("module_resistanceElectric8");
         this._visualAssetsDB.module.push("module_resistanceElectric9");
         this._visualAssetsDB.module.push("module_resistanceElectric10");
         this._visualAssetsDB.module.push("module_resistanceElectric11");
         this._visualAssetsDB.module.push("module_resistanceElectric12");
         this._visualAssetsDB.module.push("module_resistanceElectric13");
         this._visualAssetsDB.module.push("module_resistanceElectric14");
         this._visualAssetsDB.module.push("module_resistanceElectric15");
         this._visualAssetsDB.module.push("module_resistanceElectric16");
         this._visualAssetsDB.module.push("module_resistanceElectric17");
         this._visualAssetsDB.module.push("module_resistanceElectric18");
         this._visualAssetsDB.module.push("module_resistanceExplosive1");
         this._visualAssetsDB.module.push("module_resistanceExplosive2");
         this._visualAssetsDB.module.push("module_resistanceExplosive3");
         this._visualAssetsDB.module.push("module_resistanceExplosive4");
         this._visualAssetsDB.module.push("module_resistanceExplosive5");
         this._visualAssetsDB.module.push("module_resistanceExplosive6");
         this._visualAssetsDB.module.push("module_resistanceExplosive7");
         this._visualAssetsDB.module.push("module_resistanceExplosive8");
         this._visualAssetsDB.module.push("module_resistanceExplosive9");
         this._visualAssetsDB.module.push("module_resistanceExplosive10");
         this._visualAssetsDB.module.push("module_resistanceExplosive11");
         this._visualAssetsDB.module.push("module_resistanceExplosive12");
         this._visualAssetsDB.module.push("module_resistanceExplosive13");
         this._visualAssetsDB.module.push("module_resistanceExplosive14");
         this._visualAssetsDB.module.push("module_resistanceExplosive15");
         this._visualAssetsDB.module.push("module_resistanceExplosive16");
         this._visualAssetsDB.module.push("module_resistanceExplosive17");
         this._visualAssetsDB.module.push("module_resistanceExplosive18");
         this._visualAssetsDB.module.push("module_resistancePhysical1");
         this._visualAssetsDB.module.push("module_resistancePhysical2");
         this._visualAssetsDB.module.push("module_resistancePhysical3");
         this._visualAssetsDB.module.push("module_resistancePhysical4");
         this._visualAssetsDB.module.push("module_resistancePhysical5");
         this._visualAssetsDB.module.push("module_resistancePhysical6");
         this._visualAssetsDB.module.push("module_resistancePhysical7");
         this._visualAssetsDB.module.push("module_resistancePhysical8");
         this._visualAssetsDB.module.push("module_resistancePhysical9");
         this._visualAssetsDB.module.push("module_resistancePhysical10");
         this._visualAssetsDB.module.push("module_resistancePhysical11");
         this._visualAssetsDB.module.push("module_resistancePhysical12");
         this._visualAssetsDB.module.push("module_resistancePhysical13");
         this._visualAssetsDB.module.push("module_resistancePhysical14");
         this._visualAssetsDB.module.push("module_resistancePhysical15");
         this._visualAssetsDB.module.push("module_resistancePhysical16");
         this._visualAssetsDB.module.push("module_resistancePhysical17");
         this._visualAssetsDB.module.push("module_resistancePhysical18");
         this._visualAssetsDB.module.push("module_resistanceAll1");
         this._visualAssetsDB.module.push("module_resistanceAll2");
         this._visualAssetsDB.module.push("module_resistanceAll3");
         this._visualAssetsDB.module.push("module_resistanceAll4");
         this._visualAssetsDB.module.push("module_resistanceAll5");
         this._visualAssetsDB.module.push("module_resistanceAll6");
         this._visualAssetsDB.module.push("module_resistanceAll7");
         this._visualAssetsDB.module.push("module_resistanceAll8");
         this._visualAssetsDB.module.push("module_resistanceAll9");
         this._visualAssetsDB.module.push("module_resistanceAll10");
         this._visualAssetsDB.module.push("module_resistanceAll11");
         this._visualAssetsDB.module.push("module_resistanceAll12");
         this._visualAssetsDB.module.push("module_resistanceAll13");
         this._visualAssetsDB.module.push("module_resistanceAll14");
         this._visualAssetsDB.module.push("module_resistanceAll15");
         this._visualAssetsDB.module.push("module_resistanceAll16");
         this._visualAssetsDB.module.push("module_resistanceAll17");
         this._visualAssetsDB.module.push("module_resistanceAll18");
         this._visualAssetsDB.kit = new Array();
         this._visualAssetsDB.kit.push("kit_energy1");
         this._visualAssetsDB.kit.push("kit_energy2");
         this._visualAssetsDB.kit.push("kit_energy3");
         this._visualAssetsDB.kit.push("kit_energy4");
         this._visualAssetsDB.kit.push("kit_energy5");
         this._visualAssetsDB.kit.push("kit_energy6");
         this._visualAssetsDB.kit.push("kit_energy7");
         this._visualAssetsDB.kit.push("kit_energy8");
         this._visualAssetsDB.kit.push("kit_energy9");
         this._visualAssetsDB.kit.push("kit_energy10");
         this._visualAssetsDB.kit.push("kit_energy11");
         this._visualAssetsDB.kit.push("kit_energy12");
         this._visualAssetsDB.kit.push("kit_energy13");
         this._visualAssetsDB.kit.push("kit_energy14");
         this._visualAssetsDB.kit.push("kit_energy15");
         this._visualAssetsDB.kit.push("kit_energy16");
         this._visualAssetsDB.kit.push("kit_energy17");
         this._visualAssetsDB.kit.push("kit_energy18");
         this._visualAssetsDB.kit.push("kit_energy19");
         this._visualAssetsDB.kit.push("kit_energy20");
         this._visualAssetsDB.kit.push("kit_energyS1");
         this._visualAssetsDB.kit.push("kit_energyS2");
         this._visualAssetsDB.kit.push("kit_energyS3");
         this._visualAssetsDB.kit.push("kit_energyS4");
         this._visualAssetsDB.kit.push("kit_energyS5");
         this._visualAssetsDB.kit.push("kit_energyS6");
         this._visualAssetsDB.kit.push("kit_energyS7");
         this._visualAssetsDB.kit.push("kit_heat1");
         this._visualAssetsDB.kit.push("kit_heat2");
         this._visualAssetsDB.kit.push("kit_heat3");
         this._visualAssetsDB.kit.push("kit_heat4");
         this._visualAssetsDB.kit.push("kit_heat5");
         this._visualAssetsDB.kit.push("kit_heat6");
         this._visualAssetsDB.kit.push("kit_heat7");
         this._visualAssetsDB.kit.push("kit_heat8");
         this._visualAssetsDB.kit.push("kit_heat9");
         this._visualAssetsDB.kit.push("kit_heat10");
         this._visualAssetsDB.kit.push("kit_heat11");
         this._visualAssetsDB.kit.push("kit_heat12");
         this._visualAssetsDB.kit.push("kit_heat13");
         this._visualAssetsDB.kit.push("kit_heat14");
         this._visualAssetsDB.kit.push("kit_heat15");
         this._visualAssetsDB.kit.push("kit_heat16");
         this._visualAssetsDB.kit.push("kit_heat17");
         this._visualAssetsDB.kit.push("kit_heat18");
         this._visualAssetsDB.kit.push("kit_heat19");
         this._visualAssetsDB.kit.push("kit_heat20");
         this._visualAssetsDB.kit.push("kit_heatS1");
         this._visualAssetsDB.kit.push("kit_heatS2");
         this._visualAssetsDB.kit.push("kit_heatS3");
         this._visualAssetsDB.kit.push("kit_heatS4");
         this._visualAssetsDB.kit.push("kit_heatS5");
         this._visualAssetsDB.kit.push("kit_heatS6");
         this._visualAssetsDB.kit.push("kit_heatS7");
         this._visualAssetsDB.kit.push("kit_HP1");
         this._visualAssetsDB.kit.push("kit_HP2");
         this._visualAssetsDB.kit.push("kit_HP3");
         this._visualAssetsDB.kit.push("kit_HP4");
         this._visualAssetsDB.kit.push("kit_HP5");
         this._visualAssetsDB.kit.push("kit_HP6");
         this._visualAssetsDB.kit.push("kit_HP7");
         this._visualAssetsDB.kit.push("kit_HP8");
         this._visualAssetsDB.kit.push("kit_HP9");
         this._visualAssetsDB.kit.push("kit_HP10");
         this._visualAssetsDB.kit.push("kit_HP11");
         this._visualAssetsDB.kit.push("kit_HP12");
         this._visualAssetsDB.kit.push("kit_HP13");
         this._visualAssetsDB.kit.push("kit_HP14");
         this._visualAssetsDB.kit.push("kit_HP15");
         this._visualAssetsDB.kit.push("kit_HP16");
         this._visualAssetsDB.kit.push("kit_HP17");
         this._visualAssetsDB.kit.push("kit_HP18");
         this._visualAssetsDB.kit.push("kit_HP19");
         this._visualAssetsDB.kit.push("kit_HP20");
         this._visualAssetsDB.kit.push("kit_HPS1");
         this._visualAssetsDB.kit.push("kit_HPS2");
         this._visualAssetsDB.kit.push("kit_HPS3");
         this._visualAssetsDB.kit.push("kit_HPS4");
         this._visualAssetsDB.kit.push("kit_HPS5");
         this._visualAssetsDB.kit.push("kit_HPS6");
         this._visualAssetsDB.kit.push("kit_HPS7");
         this._visualAssetsDB.kit.push("kit_bullets1");
         this._visualAssetsDB.kit.push("kit_bullets2");
         this._visualAssetsDB.kit.push("kit_bullets3");
         this._visualAssetsDB.kit.push("kit_bullets4");
         this._visualAssetsDB.kit.push("kit_bullets5");
         this._visualAssetsDB.kit.push("kit_bullets6");
         this._visualAssetsDB.kit.push("kit_bullets7");
         this._visualAssetsDB.kit.push("kit_rockets1");
         this._visualAssetsDB.kit.push("kit_rockets2");
         this._visualAssetsDB.kit.push("kit_rockets3");
         this._visualAssetsDB.kit.push("kit_rockets4");
         this._visualAssetsDB.kit.push("kit_rockets5");
         this._visualAssetsDB.kit.push("kit_rockets6");
         this._visualAssetsDB.kit.push("kit_rockets7");
         this._visualAssetsDB.kit.push("kit_resistPhysical1");
         this._visualAssetsDB.kit.push("kit_resistPhysical2");
         this._visualAssetsDB.kit.push("kit_resistPhysical3");
         this._visualAssetsDB.kit.push("kit_resistPhysical4");
         this._visualAssetsDB.kit.push("kit_resistPhysical5");
         this._visualAssetsDB.kit.push("kit_resistPhysical6");
         this._visualAssetsDB.kit.push("kit_resistExplosive1");
         this._visualAssetsDB.kit.push("kit_resistExplosive2");
         this._visualAssetsDB.kit.push("kit_resistExplosive3");
         this._visualAssetsDB.kit.push("kit_resistExplosive4");
         this._visualAssetsDB.kit.push("kit_resistExplosive5");
         this._visualAssetsDB.kit.push("kit_resistExplosive6");
         this._visualAssetsDB.kit.push("kit_resistElectric1");
         this._visualAssetsDB.kit.push("kit_resistElectric2");
         this._visualAssetsDB.kit.push("kit_resistElectric3");
         this._visualAssetsDB.kit.push("kit_resistElectric4");
         this._visualAssetsDB.kit.push("kit_resistElectric5");
         this._visualAssetsDB.kit.push("kit_resistElectric6");
         this._visualAssetsDB.kit.push("kit_resistAll1");
         this._visualAssetsDB.kit.push("kit_resistAll2");
         this._visualAssetsDB.kit.push("kit_resistAll3");
         this._visualAssetsDB.kit.push("kit_resistAll4");
         this._visualAssetsDB.kit.push("kit_resistAll5");
         this._visualAssetsDB.kit.push("kit_resistAll6");
         this._visualAssetsDB.kit.push("kit_power1");
         this._visualAssetsDB.kit.push("kit_power2");
         this._visualAssetsDB.kit.push("kit_power3");
         this._visualAssetsDB.kit.push("kit_power4");
         this._visualAssetsDB.kit.push("kit_power5");
         this._visualAssetsDB.kit.push("kit_power6");
         this._visualAssetsDB.kit.push("kit_power7");
         this._visualAssetsDB.kit.push("kit_power8");
         this._visualAssetsDB.kit.push("kit_power9");
         this._visualAssetsDB.kit.push("kit_power10");
         this._visualAssetsDB.kit.push("kit_power11");
         this._visualAssetsDB.kit.push("kit_power12");
         this._visualAssetsDB.kit.push("kit_power13");
         this._visualAssetsDB.kit.push("kit_power14");
         this._visualAssetsDB.kit.push("kit_powerB1");
         this._visualAssetsDB.kit.push("kit_powerB2");
         this._visualAssetsDB.kit.push("kit_powerB3");
         this._visualAssetsDB.kit.push("kit_powerB4");
         this._visualAssetsDB.kit.push("kit_powerB5");
         this._visualAssetsDB.kit.push("kit_powerB6");
         this._visualAssetsDB.kit.push("kit_powerB7");
         this._visualAssetsDB.kit.push("kit_powerB8");
         this._visualAssetsDB.kit.push("kit_powerB9");
         this._visualAssetsDB.kit.push("kit_powerB10");
         this._visualAssetsDB.kit.push("kit_powerB11");
         this._visualAssetsDB.kit.push("kit_powerB12");
         this._visualAssetsDB.kit.push("kit_powerB13");
         this._visualAssetsDB.kit.push("kit_powerB14");
         this._visualAssetsDB.kit.push("kit_powerB15");
         this._visualAssetsDB.kit.push("kit_color1");
         this._visualAssetsDB.kit.push("kit_color2");
         this._visualAssetsDB.kit.push("kit_color3");
         this._visualAssetsDB.kit.push("kit_color4");
         this._visualAssetsDB.kit.push("kit_color5");
         this._visualAssetsDB.kit.push("kit_color6");
         this._visualAssetsDB.kit.push("kit_color7");
         this._visualAssetsDB.kit.push("kit_color8");
         this._visualAssetsDB.kit.push("kit_color9");
      }
   }
}

