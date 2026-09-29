package net.battleMechsMulti.mobiles.buttons
{
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.text.TextField;
   import net.battleMechsMulti.mobiles.BMBaseClass;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol2434")]
   public class BMButtonBattle extends BMBaseClass
   {
      
      public var buttonCore:BMButtonCore;
      
      public var type:String;
      
      public var buttonID:Number;
      
      public var equipmentID:Number;
      
      private var _mouseClickedFunction:Function;
      
      private var _pictureMC:MovieClip;
      
      private var _mouseOverFunction:Function;
      
      private var _mouseOutFunction:Function;
      
      private var _clickFunctionEnabled:Boolean;
      
      private var _blocked:Boolean;
      
      private var _blockIcons:Number;
      
      private var _runAsMobile:Boolean;
      
      public var mouseHitArea:Sprite;
      
      public var selectedEffect:Sprite;
      
      public var mouseOverEffect:Sprite;
      
      public var disabledEffect:Sprite;
      
      public var pictureHolder:Sprite;
      
      public var pictureSizer:Sprite;
      
      public var mcBlockedBackground:Sprite;
      
      public var mcBackgroundDown:Sprite;
      
      public var mcBackgroundUp:Sprite;
      
      public var mcBlockedIcon:Sprite;
      
      public var mcBullets:Sprite;
      
      public var mcRockets:Sprite;
      
      public var mcEnergy:Sprite;
      
      public var mcRange:Sprite;
      
      public var mcActivate:Sprite;
      
      public var mcDeactivate:Sprite;
      
      public var mcMechDestroyed:Sprite;
      
      public var mcUses1:MovieClip;
      
      public var mcUses2:MovieClip;
      
      public var mcUses3:MovieClip;
      
      public var mcUses4:MovieClip;
      
      public var txtButtonName:TextField;
      
      public var txtButtonNumber:TextField;
      
      public function BMButtonBattle()
      {
         super();
      }
      
      public function initialize(param1:String, param2:Number, param3:String, param4:Number, param5:Function, param6:Function, param7:Function, param8:Boolean) : void
      {
         generateSingletonClassesPointers("");
         name = param1;
         this._mouseClickedFunction = param5;
         this._mouseOverFunction = param6;
         this._mouseOutFunction = param7;
         this._runAsMobile = param8;
         this.buttonID = param2;
         this.type = param3;
         this.equipmentID = param4;
         this.buttonCore = new BMButtonCore();
         var _loc9_:Function = this.buttonMouseOver;
         var _loc10_:Function = this.buttonMouseOut;
         if(dataM.runAsMobile)
         {
            _loc9_ = null;
            _loc10_ = null;
         }
         this.buttonCore.initialize(this.mouseHitArea,this.buttonMouseClicked,null,null,null,_loc9_,_loc10_,this._runAsMobile);
         if(dataM.runAsMobile)
         {
            this.mouseOverEffect.visible = false;
         }
         else
         {
            this.buttonCore.setMouseOverEffect(this.mouseOverEffect);
         }
         this.buttonCore.setSelectedEffect(this.selectedEffect);
         this.buttonCore.setDisabledEffect(this.disabledEffect);
         this.txtButtonNumber.text = "";
         this._clickFunctionEnabled = true;
         this.removeBlocks();
      }
      
      private function buttonMouseClicked() : void
      {
         if(this._clickFunctionEnabled && this._blocked == false)
         {
            if(this._mouseClickedFunction != null)
            {
               this._mouseClickedFunction(this.buttonID,this.type,this.equipmentID);
            }
         }
      }
      
      private function buttonMouseOver() : void
      {
         if(this._mouseOverFunction != null)
         {
            this._mouseOverFunction(this.buttonID,this.type,this.equipmentID);
         }
      }
      
      private function buttonMouseOut() : void
      {
         if(this._mouseOutFunction != null)
         {
            this._mouseOutFunction(this.buttonID,this.type,this.equipmentID);
         }
      }
      
      public function setPicture(param1:MovieClip, param2:Number) : void
      {
         var _loc3_:Number = NaN;
         var _loc4_:Number = NaN;
         var _loc5_:Number = NaN;
         if(this._pictureMC != null)
         {
            this.pictureHolder.removeChild(this._pictureMC);
            this._pictureMC = null;
         }
         this._pictureMC = param1;
         if(this._pictureMC.width > this._pictureMC.height)
         {
            _loc3_ = this.pictureSizer.width / this._pictureMC.width;
         }
         else
         {
            _loc3_ = this.pictureSizer.height / this._pictureMC.height;
         }
         this._pictureMC.width *= _loc3_;
         this._pictureMC.height *= _loc3_;
         this._pictureMC.x = (this.pictureSizer.width - this._pictureMC.width) / 2;
         this._pictureMC.y = (this.pictureSizer.height - this._pictureMC.height) / 2;
         if(param2 > 0)
         {
            if(this._pictureMC.width > this._pictureMC.height)
            {
               _loc3_ = 1 - param2 * 2 / this._pictureMC.width;
               _loc4_ = this._pictureMC.width;
               this._pictureMC.width *= _loc3_;
               this._pictureMC.x += (_loc4_ - this._pictureMC.width) / 2;
               _loc5_ = this._pictureMC.height;
               this._pictureMC.height *= _loc3_;
               this._pictureMC.y += (_loc5_ - this._pictureMC.height) / 2;
            }
            else
            {
               _loc3_ = 1 - param2 * 2 / this._pictureMC.height;
               _loc5_ = this._pictureMC.height;
               this._pictureMC.height *= _loc3_;
               this._pictureMC.y += (_loc5_ - this._pictureMC.height) / 2;
               _loc4_ = this._pictureMC.width;
               this._pictureMC.width *= _loc3_;
               this._pictureMC.x += (_loc4_ - this._pictureMC.width) / 2;
            }
         }
         this.pictureHolder.addChild(this._pictureMC);
      }
      
      public function removeBlocks() : void
      {
         this._blocked = false;
         this.mcActivate.visible = false;
         this.mcDeactivate.visible = false;
         this.mcMechDestroyed.visible = false;
         this.mcBlockedBackground.visible = false;
         this.mcBlockedIcon.visible = false;
         this.mcBullets.visible = false;
         this.mcRockets.visible = false;
         this.mcEnergy.visible = false;
         this.mcRange.visible = false;
         this.mcUses1.visible = false;
         this.mcUses2.visible = false;
         this.mcUses3.visible = false;
         this.mcUses4.visible = false;
         this._blockIcons = 0;
         this.enableMouseEffects();
      }
      
      public function showUses(param1:Number, param2:Number) : void
      {
         var _loc3_:Number = NaN;
         var _loc4_:uint = 0;
         var _loc5_:MovieClip = null;
         if(param2 > 0)
         {
            _loc3_ = param2 - param1;
            _loc4_ = 1;
            while(_loc4_ <= param2)
            {
               _loc5_ = this["mcUses" + _loc4_];
               _loc5_.visible = true;
               if(_loc3_ >= _loc4_)
               {
                  _loc5_.gotoAndStop("available");
               }
               else
               {
                  _loc5_.gotoAndStop("used");
               }
               _loc4_++;
            }
         }
      }
      
      public function showOutOfRangeBlock() : void
      {
         this._blocked = true;
         this.mcBlockedBackground.visible = true;
         this.mcRange.x = 57 - 24 * this._blockIcons;
         this.mcRange.visible = true;
         ++this._blockIcons;
         this.disableMouseEffects();
      }
      
      public function showUsesDepletedBlock() : void
      {
         this.showGeneralBlock();
      }
      
      public function showWeaponAlreadyFiredBlock() : void
      {
         this.showGeneralBlock();
      }
      
      public function showNotEnoughEnergyBlock() : void
      {
         this._blocked = true;
         this.mcBlockedBackground.visible = true;
         this.mcEnergy.x = 57 - 24 * this._blockIcons;
         this.mcEnergy.visible = true;
         ++this._blockIcons;
         this.disableMouseEffects();
      }
      
      public function showNotEnoughBulletsBlock() : void
      {
         this._blocked = true;
         this.mcBlockedBackground.visible = true;
         this.mcBullets.x = 57 - 24 * this._blockIcons;
         this.mcBullets.visible = true;
         ++this._blockIcons;
         this.disableMouseEffects();
      }
      
      public function showNotEnoughRocketsBlock() : void
      {
         this._blocked = true;
         this.mcBlockedBackground.visible = true;
         this.mcRockets.x = 57 - 24 * this._blockIcons;
         this.mcRockets.visible = true;
         ++this._blockIcons;
         this.disableMouseEffects();
      }
      
      public function showGeneralBlock() : void
      {
         this._blocked = true;
         this.mcBlockedBackground.visible = true;
         this.mcBlockedIcon.x = 57;
         this.mcBlockedIcon.visible = true;
         this.disableMouseEffects();
      }
      
      public function showMechDestroyedBlock() : void
      {
         this.mcMechDestroyed.visible = true;
         this._blocked = true;
      }
      
      public function showActivate() : void
      {
         this.mcActivate.visible = true;
      }
      
      public function showDeactivate() : void
      {
         this.mcDeactivate.visible = true;
      }
      
      public function isButtonBlocked() : Boolean
      {
         return this._blocked;
      }
      
      private function disableMouseEffects() : void
      {
         this.buttonCore.disableMouseOverEffect();
         this.buttonCore.disableMouseDownEffect();
      }
      
      private function enableMouseEffects() : void
      {
         this.buttonCore.enableMouseOverEffect();
         this.buttonCore.enableMouseDownEffect();
      }
      
      public function activatePressedEffect() : void
      {
         this.mcBackgroundDown.visible = true;
         this.mcBackgroundUp.visible = false;
      }
      
      public function deactivatePressedEffect() : void
      {
         this.mcBackgroundDown.visible = false;
         this.mcBackgroundUp.visible = true;
      }
      
      public function setButtonNumber(param1:Number) : void
      {
         this.txtButtonNumber.text = String(param1);
      }
      
      public function activateSoundFunctions(param1:Function, param2:Function) : void
      {
         this.buttonCore.activateSoundFunctions(param1,param2);
      }
      
      public function enableClickFunction() : void
      {
         this._clickFunctionEnabled = true;
      }
      
      public function disableClickFunction() : void
      {
         this._clickFunctionEnabled = false;
      }
      
      public function disableMe() : void
      {
         this.buttonCore.disableMe(true);
      }
      
      public function enableMe() : void
      {
         this.buttonCore.enableMe();
      }
   }
}

