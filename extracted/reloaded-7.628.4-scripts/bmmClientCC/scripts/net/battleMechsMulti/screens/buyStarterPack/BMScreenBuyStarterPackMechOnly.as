package net.battleMechsMulti.screens.buyStarterPack
{
   import flash.display.Sprite;
   import net.battleMechsMulti.data.ItemRarityResolver;
   import net.battleMechsMulti.managers.BMScreensManager;
   import net.battleMechsMulti.mobiles.BMMechStructure;
   import net.battleMechsMulti.mobiles.BMMechView;
   import net.battleMechsMulti.mobiles.BMPlayerProfile;
   import net.battleMechsMulti.mobiles.BMTileListItem;
   import net.battleMechsMulti.mobiles.mechView.BMMechViewManualColors;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol1381")]
   public class BMScreenBuyStarterPackMechOnly extends BMScreenBuyStarterPack
   {
      
      public var mcMechHolder:Sprite;
      
      public var mcItemsPosition:Sprite;
      
      public var mcMechPosition:Sprite;
      
      private var mechView:BMMechView;
      
      public var tileListItems:Array = new Array();
      
      public function BMScreenBuyStarterPackMechOnly()
      {
         super();
      }
      
      public function initialize() : void
      {
         generateSingletonClassesPointers("");
         setLanguageManagerScreenName("buyStarterPack");
         dataM.trackScreenView("buyStarterPack");
         dataM.updateStarterPackActive();
         var _loc1_:String = getScreenText("title");
         updateTextAndFormat(txtTitle,_loc1_);
         this.mechAndCurrencyOperations();
      }
      
      public function mechAndCurrencyOperations() : void
      {
      }
      
      public function refreshScreen(param1:String) : void
      {
         refreshScreenSub(param1);
         this.displayMech();
      }
      
      public function onEnterFrameTrigger() : void
      {
         if(parent == null)
         {
            return;
         }
         if(this.mechView != null)
         {
            this.mechView.onEnterFrameTrigger();
         }
      }
      
      private function displayMech() : void
      {
         var _loc3_:BMMechViewManualColors = null;
         var _loc6_:uint = 0;
         var _loc7_:* = 0;
         var _loc8_:uint = 0;
         var _loc12_:Number = NaN;
         var _loc13_:Boolean = false;
         var _loc14_:Boolean = false;
         var _loc15_:BMTileListItem = null;
         var _loc1_:BMPlayerProfile = dataM["player" + dataM.player1PlayerID + "Profile"];
         this.mechView = new BMMechView();
         this.mechView.initialize(0,"battle",BMMechStructure.ITEM_TYPE_ITEM_ID,0.8,false);
         var _loc2_:BMMechStructure = new BMMechStructure(BMMechStructure.ITEM_TYPE_ITEM_ID);
         _loc2_.torso = dataM.myProfile.starterPackData.torso;
         _loc2_.leg = dataM.myProfile.starterPackData.leg;
         _loc2_.sideWeapon1 = dataM.myProfile.starterPackData.sideWeapon1;
         _loc2_.sideWeapon2 = dataM.myProfile.starterPackData.sideWeapon2;
         _loc2_.sideWeapon3 = dataM.myProfile.starterPackData.sideWeapon3;
         _loc2_.sideWeapon4 = dataM.myProfile.starterPackData.sideWeapon4;
         _loc2_.topWeapon1 = dataM.myProfile.starterPackData.topWeapon1;
         _loc2_.topWeapon2 = dataM.myProfile.starterPackData.topWeapon2;
         _loc3_ = new BMMechViewManualColors();
         _loc3_.torso = dataM.myProfile.starterPackData.mechColorID;
         _loc3_.leg = dataM.myProfile.starterPackData.mechColorID;
         _loc3_.sideWeapon = dataM.myProfile.starterPackData.mechColorID;
         _loc3_.topWeapon = dataM.myProfile.starterPackData.mechColorID;
         this.mechView.setManualColors(_loc3_);
         this.mechView.buildMech(_loc2_);
         this.mechView.activateBreathing();
         this.mechView.x = this.mcMechPosition.x;
         this.mechView.y = this.mcMechPosition.y - (this.mechView.mechSizer.height + this.mechView.mechSizer.y);
         this.mcMechHolder.addChild(this.mechView);
         var _loc4_:Array = new Array();
         var _loc5_:Array = ["torso","leg","sideWeapon1","sideWeapon2","sideWeapon3","sideWeapon4","topWeapon1","topWeapon2","drone","module1","module2","module3","module4","module5","module6","module7","module8"];
         _loc6_ = 0;
         while(_loc6_ < _loc5_.length)
         {
            if(dataM.myProfile.starterPackData[_loc5_[_loc6_]] > 0)
            {
               _loc4_.push(dataM.myProfile.starterPackData[_loc5_[_loc6_]]);
            }
            _loc6_++;
         }
         _loc7_ = 0;
         _loc8_ = 0;
         _loc6_ = 0;
         while(_loc6_ < _loc4_.length)
         {
            _loc12_ = Number(_loc4_[_loc6_]);
            if(_loc12_ > 0)
            {
               _loc13_ = false;
               _loc14_ = true;
               _loc15_ = dataM.createItemTileListItem(_loc12_,dataM.STARTER_PACK_SIZE,dataM.myProfile.starterPackData.mechColorID,_loc13_,this.itemClicked,this.itemMouseOver,this.itemMouseOut,_loc14_);
               _loc15_.x = this.mcItemsPosition.x + _loc7_ * dataM.STARTER_PACK_SIZE;
               _loc15_.y = this.mcItemsPosition.y + _loc8_ * dataM.STARTER_PACK_SIZE;
               this.tileListItems.push(_loc15_);
               addChild(_loc15_);
               if(++_loc7_ >= 3)
               {
                  _loc7_ = 0;
                  _loc8_++;
               }
            }
            _loc6_++;
         }
         var _loc9_:uint = 20;
         switch(dataM.languageID)
         {
            case 3:
               _loc9_ = 18;
               break;
            case 5:
               _loc9_ = 16;
               break;
            case 7:
               _loc9_ = 18;
               break;
            case 9:
               _loc9_ = 15;
         }
         var _loc10_:String = ItemRarityResolver.COLOR_LEGENDARY_ITEM;
         if(dataM.myProfile.starterPackData.packID >= 2000)
         {
            _loc10_ = "FF0000";
         }
         var _loc11_:String = getScreenText("description_items");
         _loc11_ = dataM.replaceStringInText(_loc11_,"%COLOR%","<FONT COLOR=\'#" + _loc10_ + "\'>");
         _loc11_ = dataM.replaceStringInText(_loc11_,"%AMOUNT%",String(_loc4_.length));
         updateTextAndFormat(txtDescription,_loc11_);
      }
      
      public function itemClicked(param1:Number, param2:Number) : void
      {
         screensM.addScreen(BMScreensManager.SCR_CONTENT_PACK_ITEM_INFO);
         screensM.screenContentPackItemInfo.showItemInfo(param2,false);
      }
      
      public function itemMouseOver(param1:Number, param2:Number) : void
      {
      }
      
      private function itemMouseOut(param1:Number, param2:Number) : void
      {
      }
      
      override public function removeMe() : void
      {
         if(this.mechView != null)
         {
            this.mechView.removeMe();
            this.mechView = null;
         }
         if(screensM.isScreenOpened(BMScreensManager.SCR_BUY_STARTER_PACK_MECH_ONLY))
         {
            screensM.removeScreen(BMScreensManager.SCR_BUY_STARTER_PACK_MECH_ONLY);
         }
         else
         {
            screensM.removeScreen(BMScreensManager.SCR_BUY_STARTER_PACK_MECH_AND_CURRENCY);
         }
      }
   }
}

