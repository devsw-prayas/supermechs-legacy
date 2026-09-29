package net.battleMechsMulti.screens.adminTools
{
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import net.battleMechsMulti.managers.BMScreensManager;
   import net.battleMechsMulti.mobiles.BMItem;
   import net.battleMechsMulti.mobiles.BMItemData;
   import net.battleMechsMulti.mobiles.BMMechStructure;
   import net.battleMechsMulti.mobiles.BMMechView;
   import net.battleMechsMulti.mobiles.BMTileList;
   import net.battleMechsMulti.mobiles.BMTileListItem;
   import net.battleMechsMulti.mobiles.buttons.BMButton_pictureE;
   import net.battleMechsMulti.screens.BMBaseScreen;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol4159")]
   public class BMScreenMechGenerator extends BMBaseScreen
   {
      
      public var mcButtonsHolder:Sprite;
      
      public var mcMechHolder:Sprite;
      
      public var mcSizer_btnBack:Sprite;
      
      public var mcSizer_btnColor1:Sprite;
      
      public var mcSizer_btnColor2:Sprite;
      
      public var mcSizer_btnColor3:Sprite;
      
      public var mcSizer_btnColor4:Sprite;
      
      public var mcSizer_btnColor5:Sprite;
      
      public var mcSizer_btnColor6:Sprite;
      
      public var mcSizer_btnColor7:Sprite;
      
      public var mcSizer_btnColor8:Sprite;
      
      public var mcSizer_btnColor9:Sprite;
      
      public var mcSizer_btnColor10:Sprite;
      
      public var mcSizer_btnColor11:Sprite;
      
      public var mcSizer_btnColor12:Sprite;
      
      public var mcSizer_btnColor13:Sprite;
      
      public var mcSizer_btnColor14:Sprite;
      
      public var mcSizer_btnColor15:Sprite;
      
      public var mcSizer_btnColor16:Sprite;
      
      public var mcSizer_btnColor17:Sprite;
      
      public var mcSizer_btnColor18:Sprite;
      
      public var mcSizer_btnColor19:Sprite;
      
      public var mcSizer_btnColor20:Sprite;
      
      public var mcSizer_btnColor21:Sprite;
      
      public var mcSizer_btnEquip_leg:Sprite;
      
      public var mcSizer_btnEquip_torso:Sprite;
      
      public var mcSizer_btnEquip_sideWeapon1:Sprite;
      
      public var mcSizer_btnEquip_sideWeapon2:Sprite;
      
      public var mcSizer_btnEquip_sideWeapon3:Sprite;
      
      public var mcSizer_btnEquip_sideWeapon4:Sprite;
      
      public var mcSizer_btnEquip_topWeapon1:Sprite;
      
      public var mcSizer_btnEquip_topWeapon2:Sprite;
      
      public var mcSizer_btnRemove_sideWeapon1:Sprite;
      
      public var mcSizer_btnRemove_sideWeapon2:Sprite;
      
      public var mcSizer_btnRemove_sideWeapon3:Sprite;
      
      public var mcSizer_btnRemove_sideWeapon4:Sprite;
      
      public var mcSizer_btnRemove_topWeapon1:Sprite;
      
      public var mcSizer_btnRemove_topWeapon2:Sprite;
      
      public var mcSizer_btnSelectItem:Sprite;
      
      public var mcSizer_btnPaint:Sprite;
      
      public var mcMechPosition:Sprite;
      
      public var btnEquip_torso:BMButton_pictureE;
      
      public var btnEquip_leg:BMButton_pictureE;
      
      public var btnEquip_sideWeapon1:BMButton_pictureE;
      
      public var btnEquip_sideWeapon2:BMButton_pictureE;
      
      public var btnEquip_sideWeapon3:BMButton_pictureE;
      
      public var btnEquip_sideWeapon4:BMButton_pictureE;
      
      public var btnEquip_topWeapon1:BMButton_pictureE;
      
      public var btnEquip_topWeapon2:BMButton_pictureE;
      
      public var btnRemove_sideWeapon1:BMButton_pictureE;
      
      public var btnRemove_sideWeapon2:BMButton_pictureE;
      
      public var btnRemove_sideWeapon3:BMButton_pictureE;
      
      public var btnRemove_sideWeapon4:BMButton_pictureE;
      
      public var btnRemove_topWeapon1:BMButton_pictureE;
      
      public var btnRemove_topWeapon2:BMButton_pictureE;
      
      public var btnColor1:BMButton_pictureE;
      
      public var btnColor2:BMButton_pictureE;
      
      public var btnColor3:BMButton_pictureE;
      
      public var btnColor4:BMButton_pictureE;
      
      public var btnColor5:BMButton_pictureE;
      
      public var btnColor6:BMButton_pictureE;
      
      public var btnColor7:BMButton_pictureE;
      
      public var btnColor8:BMButton_pictureE;
      
      public var btnColor9:BMButton_pictureE;
      
      public var btnColor10:BMButton_pictureE;
      
      public var btnColor11:BMButton_pictureE;
      
      public var btnColor12:BMButton_pictureE;
      
      public var btnColor13:BMButton_pictureE;
      
      public var btnColor14:BMButton_pictureE;
      
      public var btnColor15:BMButton_pictureE;
      
      public var btnColor16:BMButton_pictureE;
      
      public var btnColor17:BMButton_pictureE;
      
      public var btnColor18:BMButton_pictureE;
      
      public var btnColor19:BMButton_pictureE;
      
      public var btnColor20:BMButton_pictureE;
      
      public var btnColor21:BMButton_pictureE;
      
      public var btnSelectItem:BMButton_pictureE;
      
      public var btnPaint:BMButton_pictureE;
      
      public var btnBack:BMButton_pictureE;
      
      public var mcColorMarker:Sprite;
      
      public var mcEquipmentMarker:Sprite;
      
      public var mcMechHeight:Sprite;
      
      private var mechView:BMMechView;
      
      private var itemsTileList:BMTileList;
      
      private var _mechStructure:BMMechStructure;
      
      private var _sortedItems:Object;
      
      private var _lastEquipmentType:String = "torso";
      
      private var _lastEquipmentID:uint = 0;
      
      private var _lastColorID:uint = 1;
      
      private var _firstRefresh:Boolean = true;
      
      private var _removed_sideWeapon1:Number = 0;
      
      private var _removed_sideWeapon2:Number = 0;
      
      private var _removed_sideWeapon3:Number = 0;
      
      private var _removed_sideWeapon4:Number = 0;
      
      private var _removed_topWeapon1:Number = 0;
      
      private var _removed_topWeapon2:Number = 0;
      
      public function BMScreenMechGenerator()
      {
         super();
      }
      
      public function initialize() : void
      {
         var _loc1_:uint = 0;
         generateSingletonClassesPointers("");
         screensM.createButtonFromSizer(BMScreensManager.SCR_MECH_GENERATOR,"btnBack","pictureE");
         screensM.createButtonFromSizer(BMScreensManager.SCR_MECH_GENERATOR,"btnEquip_torso","pictureE");
         screensM.createButtonFromSizer(BMScreensManager.SCR_MECH_GENERATOR,"btnEquip_leg","pictureE");
         screensM.createButtonFromSizer(BMScreensManager.SCR_MECH_GENERATOR,"btnEquip_sideWeapon1","pictureE");
         screensM.createButtonFromSizer(BMScreensManager.SCR_MECH_GENERATOR,"btnEquip_sideWeapon2","pictureE");
         screensM.createButtonFromSizer(BMScreensManager.SCR_MECH_GENERATOR,"btnEquip_sideWeapon3","pictureE");
         screensM.createButtonFromSizer(BMScreensManager.SCR_MECH_GENERATOR,"btnEquip_sideWeapon4","pictureE");
         screensM.createButtonFromSizer(BMScreensManager.SCR_MECH_GENERATOR,"btnEquip_topWeapon1","pictureE");
         screensM.createButtonFromSizer(BMScreensManager.SCR_MECH_GENERATOR,"btnEquip_topWeapon2","pictureE");
         screensM.createButtonFromSizer(BMScreensManager.SCR_MECH_GENERATOR,"btnRemove_sideWeapon1","pictureE");
         screensM.createButtonFromSizer(BMScreensManager.SCR_MECH_GENERATOR,"btnRemove_sideWeapon2","pictureE");
         screensM.createButtonFromSizer(BMScreensManager.SCR_MECH_GENERATOR,"btnRemove_sideWeapon3","pictureE");
         screensM.createButtonFromSizer(BMScreensManager.SCR_MECH_GENERATOR,"btnRemove_sideWeapon4","pictureE");
         screensM.createButtonFromSizer(BMScreensManager.SCR_MECH_GENERATOR,"btnRemove_topWeapon1","pictureE");
         screensM.createButtonFromSizer(BMScreensManager.SCR_MECH_GENERATOR,"btnRemove_topWeapon2","pictureE");
         screensM.createButtonFromSizer(BMScreensManager.SCR_MECH_GENERATOR,"btnPaint","pictureE");
         screensM.createButtonFromSizer(BMScreensManager.SCR_MECH_GENERATOR,"btnSelectItem","pictureE");
         _loc1_ = 1;
         while(_loc1_ <= 21)
         {
            screensM.createButtonFromSizer(BMScreensManager.SCR_MECH_GENERATOR,"btnColor" + _loc1_,"pictureE");
            _loc1_++;
         }
         this.btnEquip_torso.initialize("","",null,["torso",0],this.equipClicked,dataM.runAsMobile);
         this.btnEquip_leg.initialize("","",null,["leg",0],this.equipClicked,dataM.runAsMobile);
         this.btnEquip_sideWeapon1.initialize("","",null,["sideWeapon",1],this.equipClicked,dataM.runAsMobile);
         this.btnEquip_sideWeapon2.initialize("","",null,["sideWeapon",2],this.equipClicked,dataM.runAsMobile);
         this.btnEquip_sideWeapon3.initialize("","",null,["sideWeapon",3],this.equipClicked,dataM.runAsMobile);
         this.btnEquip_sideWeapon4.initialize("","",null,["sideWeapon",4],this.equipClicked,dataM.runAsMobile);
         this.btnEquip_topWeapon1.initialize("","",null,["topWeapon",1],this.equipClicked,dataM.runAsMobile);
         this.btnEquip_topWeapon2.initialize("","",null,["topWeapon",2],this.equipClicked,dataM.runAsMobile);
         this.btnRemove_sideWeapon1.initialize("","",null,["sideWeapon",1],this.removeClicked,dataM.runAsMobile);
         this.btnRemove_sideWeapon2.initialize("","",null,["sideWeapon",2],this.removeClicked,dataM.runAsMobile);
         this.btnRemove_sideWeapon3.initialize("","",null,["sideWeapon",3],this.removeClicked,dataM.runAsMobile);
         this.btnRemove_sideWeapon4.initialize("","",null,["sideWeapon",4],this.removeClicked,dataM.runAsMobile);
         this.btnRemove_topWeapon1.initialize("","",null,["topWeapon",1],this.removeClicked,dataM.runAsMobile);
         this.btnRemove_topWeapon2.initialize("","",null,["topWeapon",2],this.removeClicked,dataM.runAsMobile);
         this.btnPaint.initialize("","",null,null,this.paintClicked,dataM.runAsMobile);
         this.btnSelectItem.initialize("","",null,null,this.selectItemClicked,dataM.runAsMobile);
         _loc1_ = 1;
         while(_loc1_ <= 21)
         {
            this["btnColor" + _loc1_].initialize("","",null,[_loc1_],this.colorClicked,dataM.runAsMobile);
            _loc1_++;
         }
         this.btnBack.initialize("","",externalAssetsM.getAsset("general","interface_cancel",0,0,false,false),null,this.backClicked,dataM.runAsMobile);
      }
      
      public function refreshScreen() : void
      {
         var _loc1_:BMItemData = null;
         if(this._firstRefresh)
         {
            this._sortedItems = new Object();
            for each(_loc1_ in dataM.itemsDB)
            {
               if(_loc1_.displayLevel == 1)
               {
                  if(this._sortedItems[_loc1_.type] == null)
                  {
                     this._sortedItems[_loc1_.type] = new Array();
                  }
                  if(this._sortedItems[_loc1_.type][_loc1_.level] == null)
                  {
                     this._sortedItems[_loc1_.type][_loc1_.level] = new Array();
                  }
                  this._sortedItems[_loc1_.type][_loc1_.level].push(_loc1_.itemID);
               }
            }
            this._firstRefresh = false;
         }
         this._mechStructure = new BMMechStructure(BMMechStructure.ITEM_TYPE_ITEM_ID);
         this._mechStructure.initialize(1,0);
         this._mechStructure.resetStructure();
         this.refreshColorMarker();
         this.refreshEquipmentMarker();
      }
      
      private function equipClicked(param1:String, param2:Number) : void
      {
         this._lastEquipmentType = param1;
         this._lastEquipmentID = param2;
         this.refreshEquipmentMarker();
         trace("torso:" + this._mechStructure.torso + " leg:" + this._mechStructure.leg + " sideWeapon1:" + this._mechStructure.sideWeapon1 + " sideWeapon2:" + this._mechStructure.sideWeapon2 + " sideWeapon3:" + this._mechStructure.sideWeapon3 + " sideWeapon4:" + this._mechStructure.sideWeapon4);
         trace("topWeapon1:" + this._mechStructure.topWeapon1 + " topWeapon2:" + this._mechStructure.topWeapon2);
      }
      
      private function removeClicked(param1:String, param2:Number) : void
      {
         var _loc3_:String = param1 + param2;
         var _loc4_:String = "_removed_" + param1 + param2;
         if(this._mechStructure[_loc3_] == 0)
         {
            if(this[_loc4_] > 0)
            {
               this._mechStructure[_loc3_] = this[_loc4_];
               this[_loc4_] = 0;
            }
         }
         else
         {
            this[_loc4_] = this._mechStructure[_loc3_];
            this._mechStructure[_loc3_] = 0;
         }
         this.createMech();
      }
      
      private function createMech() : void
      {
         if(this.mechView != null)
         {
            this.mechView.removeMe();
            this.mechView = null;
         }
         this.mechView = new BMMechView();
         this.mechView.initialize(100,"hanger",BMMechStructure.ITEM_TYPE_ITEM_ID,1,false);
         this.mechView.buildMech(this._mechStructure);
         this.mechView.y = -(this.mechView.mechSizer.height + this.mechView.mechSizer.y) + this.mcMechPosition.y;
         this.mechView.x = this.mcMechPosition.x;
         this.mcMechHolder.addChild(this.mechView);
         var _loc1_:Number = 250;
         var _loc2_:Number = 100;
         this._removed_sideWeapon1 = 0;
         this._removed_sideWeapon2 = 0;
         this._removed_sideWeapon3 = 0;
         this._removed_sideWeapon4 = 0;
         this._removed_topWeapon1 = 0;
         this._removed_topWeapon2 = 0;
      }
      
      private function refreshEquipmentMarker() : void
      {
         var _loc1_:Sprite = null;
         switch(this._lastEquipmentType)
         {
            case "torso":
            case "leg":
               _loc1_ = this["mcSizer_btnEquip_" + this._lastEquipmentType];
               break;
            default:
               _loc1_ = this["mcSizer_btnEquip_" + this._lastEquipmentType + this._lastEquipmentID];
         }
         this.mcEquipmentMarker.x = _loc1_.x - 3;
         this.mcEquipmentMarker.y = _loc1_.y - 3;
      }
      
      private function colorClicked(param1:uint) : void
      {
         this._lastColorID = param1;
         this.refreshColorMarker();
      }
      
      private function paintClicked() : void
      {
         switch(this._lastEquipmentType)
         {
            case "torso":
            case "leg":
               this._mechStructure[this._lastEquipmentType + "_colorID"] = this._lastColorID;
               break;
            default:
               this._mechStructure[this._lastEquipmentType + this._lastEquipmentID + "_colorID"] = this._lastColorID;
         }
         this.createMech();
      }
      
      private function refreshColorMarker() : void
      {
         this.mcColorMarker.x = this["mcSizer_btnColor" + this._lastColorID].x - 2;
         this.mcColorMarker.y = this["mcSizer_btnColor" + this._lastColorID].y - 2;
      }
      
      private function addAndRefreshTileList(param1:*) : void
      {
         var _loc2_:Array = null;
         var _loc9_:BMItemData = null;
         var _loc10_:MovieClip = null;
         var _loc11_:BMItem = null;
         var _loc12_:BMTileListItem = null;
         var _loc13_:MovieClip = null;
         var _loc14_:Number = NaN;
         var _loc15_:MovieClip = null;
         var _loc16_:Number = NaN;
         if(this.itemsTileList != null)
         {
            this.itemsTileList.removeMe();
         }
         this.itemsTileList = new BMTileList();
         _loc2_ = new Array();
         var _loc3_:Array = new Array();
         var _loc4_:Boolean = true;
         var _loc5_:uint = dataM.MECH_GENERATOR_TILE_LIST_ITEM_SIZE;
         var _loc6_:uint = dataM.MECH_GENERATOR_TILE_LIST_ITEM_SIZE;
         var _loc7_:uint = 8;
         var _loc8_:uint = 13;
         if(_loc4_)
         {
            _loc5_ = 100;
            _loc6_ = 50;
            _loc7_ = 9;
            _loc8_ = 7;
         }
         for each(_loc9_ in dataM.itemsDB)
         {
            if(_loc9_.isDeprecated == 0 && _loc9_.displayLevel == 1 && _loc9_.type == param1)
            {
               _loc11_ = new BMItem();
               _loc12_ = new BMTileListItem();
               _loc13_ = new mcItemGrpWithText();
               if(_loc9_.damageType == 0)
               {
                  _loc13_.mcBackground.gotoAndStop(4);
               }
               else
               {
                  _loc13_.mcBackground.gotoAndStop(_loc9_.damageType);
               }
               _loc14_ = Number(_loc13_.mcSizer_item.width);
               _loc15_ = externalAssetsM.getAsset(dataM.itemTypeSourceDB[_loc9_.type],_loc9_.grp);
               if(_loc15_.width > _loc15_.height)
               {
                  _loc16_ = _loc14_ / _loc15_.width;
               }
               else
               {
                  _loc16_ = _loc14_ / _loc15_.height;
               }
               _loc15_.width *= _loc16_;
               _loc15_.height *= _loc16_;
               _loc13_.addChild(_loc15_);
               _loc15_.x = _loc13_.mcSizer_item.x;
               _loc15_.y = _loc13_.mcSizer_item.y;
               _loc13_.txtItem.text = _loc9_.fullName;
               _loc11_.initialize(_loc9_.itemID,_loc5_,_loc6_,_loc13_,0,0,false,null,false);
               _loc12_.initialize(_loc5_,_loc6_,_loc11_,"","","",0,this.tileListItemClicked,null,null,null,null,false);
               _loc2_.push(_loc12_);
            }
         }
         _loc10_ = new Grp_scrollerContent();
         this.itemsTileList.initialize(screensM.stagePointer,_loc2_,_loc7_,_loc8_,_loc5_,_loc6_,null,true,_loc10_,null,null,true,100,0.5,false,false,false);
         addChild(this.itemsTileList);
      }
      
      private function tileListItemClicked(param1:uint, param2:uint) : void
      {
         trace("ITEM ID : " + param2);
         switch(this._lastEquipmentType)
         {
            case "torso":
            case "leg":
               this._mechStructure[this._lastEquipmentType] = param2;
               break;
            default:
               this._mechStructure[this._lastEquipmentType + this._lastEquipmentID] = param2;
         }
         this.createMech();
         this.itemsTileList.removeMe();
      }
      
      private function selectItemClicked() : void
      {
         this.addAndRefreshTileList(this._lastEquipmentType);
      }
      
      private function backClicked() : void
      {
         screensM.removeScreen(BMScreensManager.SCR_MECH_GENERATOR);
      }
   }
}

