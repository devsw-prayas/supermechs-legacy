package net.battleMechsMulti.screens
{
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.system.System;
   
   public class BMScreenBlack extends BMBaseScreen
   {
      
      public var status:String;
      
      private var fadeIn:Boolean;
      
      private var fadeOut:Boolean;
      
      private var mcBlack:Sprite;
      
      private var mcBlackUp:MovieClip;
      
      private var mcBlackDown:MovieClip;
      
      private var blackScreenFunction:Function;
      
      private var _blackScreenHandler:Boolean = false;
      
      private var _upInitialYPos:Number;
      
      private var _downInitialYPos:Number;
      
      private var _waitCounter:Number;
      
      private var _params:Array;
      
      private var _delayFramesWhileClosed:Number;
      
      private const BLACK_SCREEN_ALPHA_CHANGE:Number = 0.1;
      
      private const BLACK_SCREEN_Y_CHANGE:Number = 24;
      
      private const BLACK_SCREEN_Y_POS_EXTRA:Number = 30;
      
      public function BMScreenBlack()
      {
         super();
      }
      
      public function initialize() : void
      {
         generateSingletonClassesPointers("");
         this.mcBlack = new Sprite();
         this.mcBlack.alpha = 1;
         addChild(this.mcBlack);
         this.mcBlackUp = new mcBlackScreenUp();
         this.mcBlackUp.cacheAsBitmap = true;
         this.mcBlackUp.mcTitle.visible = false;
         this.mcBlackDown = new mcBlackScreenDown();
         this.mcBlackDown.cacheAsBitmap = true;
         this.mcBlackDown.y = dataM.STAGE_HEIGHT;
         mouseEnabled = false;
         mouseChildren = false;
         this.status = "none";
      }
      
      public function onEnterFrameTrigger() : void
      {
         this.blackScreenHandler();
      }
      
      public function activateBlackScreen(param1:Function, param2:Boolean, param3:Boolean, param4:Array, param5:Number) : void
      {
         if(this.isActive() == false)
         {
            addChild(this.mcBlackDown);
            addChild(this.mcBlackUp);
            this.blackScreenFunction = param1;
            this._params = param4;
            this.fadeIn = param2;
            this.fadeOut = param3;
            this._delayFramesWhileClosed = param5;
            this.status = "alphaIn";
            this.mcBlackUp.mcTitle.visible = true;
            this._upInitialYPos = -dataM.STAGE_HEIGHT / 2 - this.BLACK_SCREEN_Y_POS_EXTRA;
            this._downInitialYPos = dataM.STAGE_HEIGHT * 1.5 + this.BLACK_SCREEN_Y_POS_EXTRA - 2;
            this.mcBlackUp.y = this._upInitialYPos;
            this.mcBlackDown.y = this._downInitialYPos;
            this.mcBlackUp.visible = true;
            this.mcBlackDown.visible = true;
            this.mcBlack.visible = false;
            this._blackScreenHandler = true;
            if(param2)
            {
               soundM.createSound("doorsClose",0.5);
            }
         }
      }
      
      private function blackScreenHandler() : void
      {
         var _loc1_:Number = NaN;
         if(this._blackScreenHandler)
         {
            _loc1_ = this.BLACK_SCREEN_Y_CHANGE;
            if(dataM.slowCPUMode)
            {
               _loc1_ *= 2;
            }
            switch(this.status)
            {
               case "alphaIn":
                  if(this.mcBlackUp.y < 1)
                  {
                     if(this.fadeIn)
                     {
                        this.mcBlackUp.y += _loc1_;
                        this.mcBlackDown.y -= _loc1_;
                     }
                     else
                     {
                        this.mcBlackUp.y = 1;
                        this.mcBlackDown.y = dataM.STAGE_HEIGHT;
                     }
                     if(this.mcBlackUp.y > 1)
                     {
                        this.mcBlackUp.y = 1;
                        this.mcBlackDown.y = dataM.STAGE_HEIGHT;
                     }
                  }
                  else
                  {
                     this.mcBlackUp.y = 1;
                     this.mcBlackDown.y = dataM.STAGE_HEIGHT;
                     this.status = "wait";
                     this._waitCounter = 0;
                  }
                  break;
               case "wait":
                  if(this._waitCounter < 5 + this._delayFramesWhileClosed)
                  {
                     if(this._waitCounter == 0)
                     {
                        System.pauseForGCIfCollectionImminent(0.1);
                     }
                     else if(this._waitCounter == 2)
                     {
                        this.callFunction();
                     }
                     ++this._waitCounter;
                  }
                  else
                  {
                     this.status = "alphaOut";
                  }
                  break;
               case "alphaOut":
                  if(this.mcBlackUp.y > this._upInitialYPos)
                  {
                     if(this.fadeOut)
                     {
                        this.mcBlackUp.y -= _loc1_;
                        this.mcBlackDown.y += _loc1_;
                     }
                     else
                     {
                        this.mcBlackUp.y = this._upInitialYPos;
                        this.mcBlackDown.y = this._downInitialYPos;
                     }
                  }
                  else
                  {
                     this.mcBlackUp.y = this._upInitialYPos;
                     this.mcBlackDown.y = this._downInitialYPos;
                     this._blackScreenHandler = false;
                     this.status = "none";
                     this.mcBlackUp.mcTitle.visible = false;
                     this.mcBlackDown.parent.removeChild(this.mcBlackDown);
                     this.mcBlackUp.parent.removeChild(this.mcBlackUp);
                  }
            }
         }
      }
      
      private function callFunction() : void
      {
         if(this.blackScreenFunction != null)
         {
            if(this._params == null)
            {
               this.blackScreenFunction();
            }
            else if(this._params.length == 0)
            {
               this.blackScreenFunction();
            }
            else if(this._params.length == 1)
            {
               this.blackScreenFunction(this._params[0]);
            }
            else if(this._params.length == 2)
            {
               this.blackScreenFunction(this._params[0],this._params[1]);
            }
         }
      }
      
      public function canActivate() : Boolean
      {
         var _loc1_:Boolean = false;
         if(this.status == "none")
         {
            _loc1_ = true;
         }
         return _loc1_;
      }
      
      public function isActive() : Boolean
      {
         return this._blackScreenHandler;
      }
   }
}

