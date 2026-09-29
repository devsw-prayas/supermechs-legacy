package net.battleMechsMulti.mobiles.buttons
{
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import net.battleMechsMulti.managers.BMScreensManager;
   import net.battleMechsMulti.managers.BMTutorialManager;
   
   public class BMButtonCore extends Sprite
   {
      
      private var _initialized:Boolean = false;
      
      private var _enabled:Boolean;
      
      private var _click:Function;
      
      private var _mouseDown:Function;
      
      private var _mouseUp:Function;
      
      private var _mouseOver:Function;
      
      private var _mouseOut:Function;
      
      private var _clickedParams:Array;
      
      private var _enableMouseUpWhileDisabled:Boolean;
      
      private var _enableMouseOverAndOutWhileDisabled:Boolean;
      
      private var mouseHitArea:Sprite;
      
      private var mcMouseOverEffect:Sprite;
      
      private var mcSelectedEffect:Sprite;
      
      private var mcDisabledEffect:Sprite;
      
      private var _mouseOverEffectEnabled:Boolean;
      
      private var _mouseDownEffectEnabled:Boolean;
      
      private var _sound_clickFunction:Function;
      
      private var _sound_rolloverFunction:Function;
      
      private var _runAsMobile:Boolean;
      
      private var _ignoreScreensDirectorTasks:Boolean = false;
      
      public function BMButtonCore()
      {
         super();
      }
      
      public function initialize(param1:Sprite, param2:Function, param3:Array, param4:Function, param5:Function, param6:Function, param7:Function, param8:Boolean) : void
      {
         this._enabled = true;
         this._runAsMobile = param8;
         this.mouseHitArea = param1;
         this._click = param2;
         this._mouseDown = param4;
         this._mouseUp = param5;
         this._mouseOver = param6;
         this._mouseOut = param7;
         this._clickedParams = param3;
         this._enableMouseUpWhileDisabled = false;
         this._enableMouseOverAndOutWhileDisabled = false;
         this.addAllListeners();
         this._mouseOverEffectEnabled = true;
         this._mouseDownEffectEnabled = true;
         this._initialized = true;
      }
      
      public function addAllListeners() : void
      {
         if(this._runAsMobile)
         {
            return;
         }
         if(this._click != null)
         {
            this.mouseHitArea.addEventListener(MouseEvent.CLICK,this.hitAreaClicked);
         }
         if(this._mouseDown != null)
         {
            this.mouseHitArea.addEventListener(MouseEvent.MOUSE_DOWN,this.hitAreaMouseDown);
         }
         if(this._mouseUp != null)
         {
            this.mouseHitArea.addEventListener(MouseEvent.MOUSE_UP,this.hitAreaMouseUp);
         }
         if(this._mouseOver != null)
         {
            this.mouseHitArea.addEventListener(MouseEvent.MOUSE_OVER,this.hitAreaMouseOver);
         }
         if(this._mouseOut != null)
         {
            this.mouseHitArea.addEventListener(MouseEvent.MOUSE_OUT,this.hitAreaMouseOut);
         }
      }
      
      public function removeAllListeners() : void
      {
         if(this._runAsMobile)
         {
            return;
         }
         this.mouseHitArea.removeEventListener(MouseEvent.CLICK,this.hitAreaClicked);
         this.mouseHitArea.removeEventListener(MouseEvent.MOUSE_DOWN,this.hitAreaMouseDown);
         this.mouseHitArea.removeEventListener(MouseEvent.MOUSE_UP,this.hitAreaMouseUp);
         this.mouseHitArea.removeEventListener(MouseEvent.MOUSE_OVER,this.hitAreaMouseOver);
         this.mouseHitArea.removeEventListener(MouseEvent.MOUSE_OUT,this.hitAreaMouseOut);
      }
      
      public function addMouseOverListerner(param1:Function) : void
      {
         if(this._runAsMobile)
         {
            return;
         }
         this._mouseOver = param1;
         this.mouseHitArea.addEventListener(MouseEvent.MOUSE_OVER,this.hitAreaMouseOver);
      }
      
      public function addMouseOutListerner(param1:Function) : void
      {
         if(this._runAsMobile)
         {
            return;
         }
         this._mouseOut = param1;
         this.mouseHitArea.addEventListener(MouseEvent.MOUSE_OUT,this.hitAreaMouseOut);
      }
      
      public function isButtonClickable() : Boolean
      {
         if(BMTutorialManager.gi().isAllowedToClickOnMovieClip(this) == false)
         {
            return false;
         }
         if(this._ignoreScreensDirectorTasks == false && BMScreensManager.getInstance().screensDirector.hasTasks())
         {
            return false;
         }
         if(this._enabled == false)
         {
            return false;
         }
         return true;
      }
      
      private function hitAreaClicked(param1:MouseEvent) : void
      {
         if(this.isButtonClickable() == false)
         {
            return;
         }
         if(this._click == null)
         {
            return;
         }
         if(this._clickedParams == null)
         {
            this._click();
            return;
         }
         switch(this._clickedParams.length)
         {
            case 0:
               this._click();
               break;
            case 1:
               this._click(this._clickedParams[0]);
               break;
            case 2:
               this._click(this._clickedParams[0],this._clickedParams[1]);
               break;
            case 3:
               this._click(this._clickedParams[0],this._clickedParams[1],this._clickedParams[2]);
         }
      }
      
      private function hitAreaMouseDown(param1:MouseEvent) : void
      {
         this.hitAreaMouseDownSub();
      }
      
      public function hitAreaMouseDownSub() : void
      {
         if(this._ignoreScreensDirectorTasks == false && BMScreensManager.getInstance().screensDirector.hasTasks())
         {
            return;
         }
         if(this._enabled == false)
         {
            return;
         }
         if(this._mouseDown != null)
         {
            this._mouseDown();
         }
         if(this._mouseDownEffectEnabled)
         {
            this.addSelectedEffect();
         }
         if(this._sound_clickFunction != null)
         {
            this._sound_clickFunction();
         }
      }
      
      private function hitAreaMouseUp(param1:MouseEvent) : void
      {
         this.hitAreaMouseUpSub();
      }
      
      public function hitAreaMouseUpSub() : void
      {
         if(this._ignoreScreensDirectorTasks == false && BMScreensManager.getInstance().screensDirector.hasTasks())
         {
            return;
         }
         if(this._enabled || this._enableMouseUpWhileDisabled)
         {
            if(this._mouseUp != null)
            {
               this._mouseUp();
            }
         }
         this.removeSelectedEffect();
      }
      
      private function hitAreaMouseOver(param1:MouseEvent) : void
      {
         if(this._ignoreScreensDirectorTasks == false && BMScreensManager.getInstance().screensDirector.hasTasks())
         {
            return;
         }
         if(this._enabled || this._enableMouseOverAndOutWhileDisabled)
         {
            if(this._mouseOver != null)
            {
               if(this._clickedParams != null)
               {
                  switch(this._clickedParams.length)
                  {
                     case 0:
                        this._mouseOver();
                        break;
                     case 1:
                        this._mouseOver(this._clickedParams[0]);
                        break;
                     case 2:
                        this._mouseOver(this._clickedParams[0],this._clickedParams[1]);
                        break;
                     case 3:
                        this._mouseOver(this._clickedParams[0],this._clickedParams[1],this._clickedParams[2]);
                  }
               }
               else
               {
                  this._mouseOver();
               }
            }
            if(this._mouseOverEffectEnabled)
            {
               this.addMouseOverEffect();
            }
            if(this._sound_rolloverFunction != null)
            {
               this._sound_rolloverFunction();
            }
         }
      }
      
      private function hitAreaMouseOut(param1:MouseEvent) : void
      {
         if(this._ignoreScreensDirectorTasks == false && BMScreensManager.getInstance().screensDirector.hasTasks())
         {
            return;
         }
         if(this._enabled || this._enableMouseOverAndOutWhileDisabled)
         {
            if(this._mouseOut != null)
            {
               if(this._clickedParams != null)
               {
                  switch(this._clickedParams.length)
                  {
                     case 0:
                        this._mouseOut();
                        break;
                     case 1:
                        this._mouseOut(this._clickedParams[0]);
                        break;
                     case 2:
                        this._mouseOut(this._clickedParams[0],this._clickedParams[1]);
                        break;
                     case 3:
                        this._mouseOut(this._clickedParams[0],this._clickedParams[1],this._clickedParams[2]);
                  }
               }
               else
               {
                  this._mouseOut();
               }
            }
         }
         this.removeMouseOverEffect();
         this.removeSelectedEffect();
      }
      
      public function ignoreScreensDirectorTasks() : void
      {
         this._ignoreScreensDirectorTasks = true;
      }
      
      public function enableMouseOverEffect() : void
      {
         this._mouseOverEffectEnabled = true;
      }
      
      public function disableMouseOverEffect() : void
      {
         this._mouseOverEffectEnabled = false;
      }
      
      public function enableMouseDownEffect() : void
      {
         this._mouseDownEffectEnabled = true;
      }
      
      public function disableMouseDownEffect() : void
      {
         this._mouseDownEffectEnabled = false;
      }
      
      public function setSelectedEffect(param1:Sprite) : void
      {
         if(this._initialized)
         {
            this.mcSelectedEffect = param1;
            this.mcSelectedEffect.visible = false;
            if(this._runAsMobile == false)
            {
               if(this._mouseDown == null)
               {
                  this.mouseHitArea.addEventListener(MouseEvent.MOUSE_DOWN,this.hitAreaMouseDown);
               }
               if(this._mouseUp == null)
               {
                  this.mouseHitArea.addEventListener(MouseEvent.MOUSE_UP,this.hitAreaMouseUp);
               }
               if(this._mouseOut == null)
               {
                  this.mouseHitArea.addEventListener(MouseEvent.MOUSE_OUT,this.hitAreaMouseOut);
               }
            }
         }
         else
         {
            TsLogger.log("BMButtonCore >> cannot call setSelectedEffect() before initialize()");
         }
      }
      
      public function setMouseOverEffect(param1:Sprite) : void
      {
         if(this._initialized)
         {
            this.mcMouseOverEffect = param1;
            this.mcMouseOverEffect.visible = false;
            if(this._runAsMobile == false)
            {
               if(this._mouseOver == null)
               {
                  this.mouseHitArea.addEventListener(MouseEvent.MOUSE_OVER,this.hitAreaMouseOver);
               }
               if(this._mouseOut == null)
               {
                  this.mouseHitArea.addEventListener(MouseEvent.MOUSE_OUT,this.hitAreaMouseOut);
               }
            }
         }
         else
         {
            TsLogger.log("BMButtonCore >> cannot call setMouseOverEffect() before initialize()");
         }
      }
      
      public function removeSelectedEffect() : void
      {
         if(this.mcSelectedEffect != null)
         {
            this.mcSelectedEffect.visible = false;
         }
      }
      
      private function addSelectedEffect() : void
      {
         if(this.mcSelectedEffect != null)
         {
            this.mcSelectedEffect.visible = true;
         }
      }
      
      private function removeMouseOverEffect() : void
      {
         if(this.mcMouseOverEffect != null)
         {
            this.mcMouseOverEffect.visible = false;
         }
      }
      
      private function addMouseOverEffect() : void
      {
         if(this.mcMouseOverEffect != null)
         {
            this.mcMouseOverEffect.visible = true;
         }
      }
      
      public function enableMe() : void
      {
         if(this.isButtonEnabled() == false)
         {
            this._enabled = true;
         }
         if(this.mcDisabledEffect != null)
         {
            this.removeDisabledEffect();
         }
      }
      
      public function disableMe(param1:Boolean) : void
      {
         if(this.isButtonEnabled())
         {
            this._enabled = false;
            if(param1 && this.mcDisabledEffect != null)
            {
               this.addDisabledEffect();
            }
         }
      }
      
      public function isButtonEnabled() : Boolean
      {
         return this._enabled;
      }
      
      public function setDisabledEffect(param1:Sprite) : void
      {
         this.mcDisabledEffect = param1;
         this.mcDisabledEffect.visible = false;
      }
      
      public function addDisabledEffect() : void
      {
         this.mcDisabledEffect.visible = true;
      }
      
      public function removeDisabledEffect() : void
      {
         this.mcDisabledEffect.visible = false;
      }
      
      public function enableMouseUpWhileDisabled() : void
      {
         this._enableMouseUpWhileDisabled = true;
      }
      
      public function enableMouseOverAndOutWhileDisabled() : void
      {
         this._enableMouseOverAndOutWhileDisabled = true;
      }
      
      public function activateSoundFunctions(param1:Function, param2:Function) : void
      {
         this._sound_clickFunction = param1;
         this._sound_rolloverFunction = param2;
      }
      
      public function removeMe() : void
      {
         this.removeAllListeners();
         this.mouseHitArea = null;
         if(parent != null)
         {
            parent.removeChild(this);
         }
      }
   }
}

