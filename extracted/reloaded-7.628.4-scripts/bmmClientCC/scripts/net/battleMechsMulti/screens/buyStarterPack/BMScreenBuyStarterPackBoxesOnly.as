package net.battleMechsMulti.screens.buyStarterPack
{
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import net.battleMechsMulti.data.ItemRarityResolver;
   import net.battleMechsMulti.managers.BMScreensManager;
   import net.battleMechsMulti.mobiles.BMPlayerProfile;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol1460")]
   public class BMScreenBuyStarterPackBoxesOnly extends BMScreenBuyStarterPack
   {
      
      public var mcBoxesPosition:Sprite;
      
      public var mcBoxes_premiumBox:MovieClip;
      
      public var mcBoxes_premiumPack:MovieClip;
      
      public var mcBoxes_mandatoryLegendary:MovieClip;
      
      private var _boxesRotation:Boolean = false;
      
      private var _boxesRotationFrameCounter:uint;
      
      private var _boxesRotationXSpeed:uint;
      
      private var _boxMcsToShake:Array;
      
      private var _boxRaysToRotate:Sprite;
      
      public function BMScreenBuyStarterPackBoxesOnly()
      {
         super();
      }
      
      public function initialize() : void
      {
         generateSingletonClassesPointers("");
         setLanguageManagerScreenName("buyStarterPack");
         var _loc1_:String = getScreenText("title");
         updateTextAndFormat(txtTitle,_loc1_);
         this.boxesAndCurencyOperations();
      }
      
      public function boxesAndCurencyOperations() : void
      {
      }
      
      public function refreshScreen(param1:String) : void
      {
         refreshScreenSub(param1);
         this.displayItemBoxes();
      }
      
      public function onEnterFrameTrigger() : void
      {
         if(parent == null)
         {
            return;
         }
         this.boxesRotationHandler();
      }
      
      private function boxesRotationHandler() : void
      {
         if(this._boxesRotation == false)
         {
            return;
         }
         if(this._boxRaysToRotate == null)
         {
            return;
         }
         ++this._boxesRotationFrameCounter;
         this._boxRaysToRotate.rotation += 0.5;
         if(this._boxesRotationFrameCounter == 100)
         {
            this._boxesRotationXSpeed = 20;
         }
         if(this._boxesRotationFrameCounter < 100)
         {
            return;
         }
         var _loc1_:uint = 0;
         while(_loc1_ < this._boxMcsToShake.length)
         {
            if(this._boxesRotationXSpeed % 2 == 0)
            {
               this._boxMcsToShake[_loc1_].x = this._boxesRotationXSpeed;
            }
            else
            {
               this._boxMcsToShake[_loc1_].x = -this._boxesRotationXSpeed;
            }
            _loc1_++;
         }
         --this._boxesRotationXSpeed;
         if(this._boxesRotationXSpeed <= 0)
         {
            this._boxesRotationFrameCounter = 0;
         }
      }
      
      private function displayItemBoxes() : void
      {
         var _loc4_:String = null;
         var _loc5_:String = null;
         var _loc6_:String = null;
         var _loc7_:String = null;
         var _loc8_:String = null;
         var _loc9_:uint = 0;
         var _loc10_:uint = 0;
         var _loc11_:uint = 0;
         var _loc12_:MovieClip = null;
         var _loc1_:BMPlayerProfile = dataM["player" + dataM.player1PlayerID + "Profile"];
         var _loc2_:Array = new Array();
         if(_loc1_.starterPackData.isMandatoryLegendaryBox())
         {
            _loc2_.push(this.mcBoxes_premiumBox);
            _loc2_.push(this.mcBoxes_premiumPack);
         }
         else if(_loc1_.starterPackData.boostID == 2)
         {
            _loc2_.push(this.mcBoxes_premiumPack);
            _loc2_.push(this.mcBoxes_mandatoryLegendary);
            this.mcBoxes_premiumBox.mcGold1.visible = false;
            this.mcBoxes_premiumBox.mcGold2.visible = false;
            this.mcBoxes_premiumBox.mcGold3.visible = false;
            this.mcBoxes_premiumBox.mcGold4.visible = false;
            this.mcBoxes_premiumBox.mcGold5.visible = false;
         }
         else
         {
            _loc2_.push(this.mcBoxes_premiumBox);
            _loc2_.push(this.mcBoxes_mandatoryLegendary);
            this.mcBoxes_premiumPack.mcGold1.visible = false;
            this.mcBoxes_premiumPack.mcGold2.visible = false;
            this.mcBoxes_premiumPack.mcGold3.visible = false;
            this.mcBoxes_premiumPack.mcGold4.visible = false;
            this.mcBoxes_premiumPack.mcGold5.visible = false;
            this.mcBoxes_premiumPack.mcGold15.visible = false;
         }
         var _loc3_:uint = 0;
         while(_loc3_ < _loc2_.length)
         {
            if(_loc2_[_loc3_] != null)
            {
               _loc2_[_loc3_].visible = false;
            }
            _loc3_++;
         }
         this._boxMcsToShake = new Array();
         if(_loc1_.starterPackData.isMandatoryLegendaryBox())
         {
            _loc4_ = getSpecificText("gachaMachine_guaranteedLegendaryBox");
            updateTextAndFormat(txtDescription,_loc4_);
            _loc5_ = getScreenText("guaranteedLegendaryDesc1");
            _loc5_ = dataM.replaceStringInText(_loc5_,"%ITEMS%",String(15));
            _loc6_ = getScreenText("guaranteedLegendaryDesc2");
            _loc6_ = dataM.replaceStringInText(_loc6_,"%LEGENDARIES%","<FONT COLOR=\'#" + ItemRarityResolver.COLOR_LEGENDARY_ITEM + "\'>" + String(3));
            _loc7_ = _loc5_ + "<BR>" + _loc6_;
            updateTextAndFormat(txtDescription2,_loc7_);
            this.mcBoxes_mandatoryLegendary.mcLegendary1.mcBox1A.mcGlow.visible = false;
            this.mcBoxes_mandatoryLegendary.mcLegendary1.mcBox1B.mcGlow.visible = false;
            this._boxRaysToRotate = this.mcBoxes_mandatoryLegendary.mcLegendary1.mcRays;
            this._boxMcsToShake.push(this.mcBoxes_mandatoryLegendary.mcLegendary1.mcBox1A,this.mcBoxes_mandatoryLegendary.mcLegendary1.mcBox1B);
         }
         else
         {
            _loc8_ = "";
            _loc9_ = _loc1_.starterPackData.boostID;
            if(_loc9_ == 2 || _loc9_ == 5)
            {
               _loc11_ = _loc1_.starterPackData.boostAmount;
               if(_loc1_.starterPackData.boostAmount == 1)
               {
                  if(_loc9_ == 5)
                  {
                     _loc8_ = dataM.replaceStringInText(getScreenText("getGachaMachine_pack"),"%COLOR%","<FONT COLOR=\'#" + ItemRarityResolver.COLOR_LEGENDARY_ITEM + "\'>");
                  }
                  else
                  {
                     _loc8_ = dataM.replaceStringInText(getScreenText("getGachaMachine_box"),"%COLOR%","<FONT COLOR=\'#" + ItemRarityResolver.COLOR_LEGENDARY_ITEM + "\'>");
                  }
               }
               else
               {
                  if(_loc9_ == 5)
                  {
                     _loc8_ = dataM.replaceStringInText(getScreenText("getGachaMachines_packs"),"%COLOR%","<FONT COLOR=\'#" + ItemRarityResolver.COLOR_LEGENDARY_ITEM + "\'>");
                  }
                  else
                  {
                     _loc8_ = dataM.replaceStringInText(getScreenText("getGachaMachines_boxes"),"%COLOR%","<FONT COLOR=\'#" + ItemRarityResolver.COLOR_LEGENDARY_ITEM + "\'>");
                  }
                  _loc8_ = dataM.replaceStringInText(_loc8_,"%AMOUNT%",String(_loc11_));
               }
               if(_loc1_.starterPackData.boostID == 2)
               {
                  _loc12_ = this.mcBoxes_premiumBox["mcGold" + _loc11_];
               }
               else
               {
                  _loc12_ = this.mcBoxes_premiumPack["mcGold" + _loc11_];
               }
               _loc12_.visible = true;
               this._boxRaysToRotate = _loc12_.mcRays;
               this._boxMcsToShake.push(_loc12_.mcBox1A,_loc12_.mcBox1B);
            }
            _loc10_ = 20;
            switch(dataM.languageID)
            {
               case 3:
                  _loc10_ = 18;
                  break;
               case 5:
                  _loc10_ = 16;
                  break;
               case 7:
                  _loc10_ = 18;
                  break;
               case 9:
                  _loc10_ = 15;
            }
            updateTextAndFormat(txtDescription,_loc8_);
            if(dataM.runAsMobile)
            {
               screensM.createMultipleTextsBitmap("buyStarterPack_description",[txtDescription],"",this);
            }
         }
         this._boxesRotation = true;
         this._boxesRotationFrameCounter = 0;
      }
      
      private function hideAllBoxes() : void
      {
      }
      
      override public function removeMe() : void
      {
         if(screensM.isScreenOpened(BMScreensManager.SCR_BUY_STARTER_PACK_GUARANTEED_LEGENDARY_BOX))
         {
            screensM.removeScreen(BMScreensManager.SCR_BUY_STARTER_PACK_GUARANTEED_LEGENDARY_BOX);
         }
         else if(screensM.isScreenOpened(BMScreensManager.SCR_BUY_STARTER_PACK_BOXES_ONLY))
         {
            screensM.removeScreen(BMScreensManager.SCR_BUY_STARTER_PACK_BOXES_ONLY);
         }
         else
         {
            screensM.removeScreen(BMScreensManager.SCR_BUY_STARTER_PACK_BOXES_AND_CURRENCY);
         }
      }
   }
}

