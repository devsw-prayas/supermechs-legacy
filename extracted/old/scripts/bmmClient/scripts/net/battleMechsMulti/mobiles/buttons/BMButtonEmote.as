package net.battleMechsMulti.mobiles.buttons
{
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import net.battleMechsMulti.mobiles.BMBaseClass;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol2419")]
   public class BMButtonEmote extends BMBaseClass
   {
      
      public var buttonCore:BMButtonCore;
      
      public var buttonID:Number;
      
      private var _mouseClickedFunction:Function;
      
      private var _pictureMC:MovieClip;
      
      private var _mouseOverFunction:Function;
      
      private var _mouseOutFunction:Function;
      
      private var _clickFunctionEnabled:Boolean;
      
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
      
      public function BMButtonEmote()
      {
         super();
      }
      
      public function initialize(param1:String, param2:Number, param3:Function, param4:Function, param5:Function, param6:Boolean) : void
      {
         generateSingletonClassesPointers("");
         name = param1;
         this._mouseClickedFunction = param3;
         this._mouseOverFunction = param4;
         this._mouseOutFunction = param5;
         this._runAsMobile = param6;
         this.buttonID = param2;
         this.buttonCore = new BMButtonCore();
         var _loc7_:Function = this.buttonMouseOver;
         var _loc8_:Function = this.buttonMouseOut;
         if(dataM.runAsMobile)
         {
            _loc7_ = null;
            _loc8_ = null;
         }
         this.buttonCore.initialize(this.mouseHitArea,this.buttonMouseClicked,null,null,null,_loc7_,_loc8_,this._runAsMobile);
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
         this._clickFunctionEnabled = true;
      }
      
      private function buttonMouseClicked() : void
      {
         if(this._clickFunctionEnabled)
         {
            if(this._mouseClickedFunction != null)
            {
               this._mouseClickedFunction(this.buttonID);
            }
         }
      }
      
      private function buttonMouseOver() : void
      {
         if(this._mouseOverFunction != null)
         {
            this._mouseOverFunction(this.buttonID);
         }
      }
      
      private function buttonMouseOut() : void
      {
         if(this._mouseOutFunction != null)
         {
            this._mouseOutFunction(this.buttonID);
         }
      }
      
      public function setPicture(param1:MovieClip, param2:Number = 0) : void
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

