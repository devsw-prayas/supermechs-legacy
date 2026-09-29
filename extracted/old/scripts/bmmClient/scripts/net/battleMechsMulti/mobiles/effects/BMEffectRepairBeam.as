package net.battleMechsMulti.mobiles.effects
{
   import flash.display.MovieClip;
   import net.battleMechsMulti.mobiles.BMBaseClass;
   
   public class BMEffectRepairBeam extends BMBaseClass
   {
      
      private var repairBeamMC:MovieClip;
      
      public var holderMC:MovieClip;
      
      private var _frameCounter:Number;
      
      private var _animationPhase:String;
      
      private var _returnFunction:Function;
      
      private var _returnFunctionParams:Array;
      
      public function BMEffectRepairBeam()
      {
         super();
      }
      
      public function initialize(param1:Boolean, param2:Number, param3:Number, param4:MovieClip, param5:Function, param6:Array) : void
      {
         generateSingletonClassesPointers("");
         this._returnFunction = param5;
         this._returnFunctionParams = param6;
         this.repairBeamMC = externalAssetsM.getAsset("general","repair1");
         if(param1)
         {
            this.repairBeamMC.scaleX = -1;
         }
         this.repairBeamMC.x = param2;
         this.repairBeamMC.y = param3;
         this.holderMC = param4;
         this.holderMC.addChild(this.repairBeamMC);
         this._animationPhase = "enter";
         this._frameCounter = 0;
      }
      
      public function runFrame(param1:uint) : void
      {
         ++this._frameCounter;
         switch(this._animationPhase)
         {
            case "enter":
               if(this._frameCounter == 1)
               {
                  this.repairBeamMC.mcBall.visible = false;
               }
               this.repairBeamMC.mcLine.width += 20;
               if(this._frameCounter == 6)
               {
                  this._animationPhase = "ball1";
                  this.repairBeamMC.mcBall.visible = true;
                  this._frameCounter = 0;
               }
               break;
            case "ball1":
            case "ball2":
            case "ball3":
               if(this._frameCounter == 1)
               {
                  this.repairBeamMC.mcBall.x = 0;
                  this.repairBeamMC.mcBall.y = 0;
               }
               this.repairBeamMC.mcBall.x += 14;
               this.repairBeamMC.mcBall.y += 14;
               if(this._frameCounter == 8)
               {
                  switch(this._animationPhase)
                  {
                     case "ball1":
                        this._animationPhase = "ball2";
                        break;
                     case "ball2":
                        this._animationPhase = "ball3";
                        break;
                     case "ball3":
                        this._animationPhase = "exit";
                        this.repairBeamMC.mcBall.visible = false;
                        if(this._returnFunction != null)
                        {
                           if(this._returnFunctionParams != null)
                           {
                              if(this._returnFunctionParams.length == 2)
                              {
                                 this._returnFunction(this._returnFunctionParams[0],this._returnFunctionParams[1]);
                              }
                              else
                              {
                                 this._returnFunction(this._returnFunctionParams[0]);
                              }
                           }
                           else
                           {
                              this._returnFunction();
                           }
                        }
                  }
                  this._frameCounter = 0;
               }
               break;
            case "exit":
               this.repairBeamMC.mcLine.width -= 20;
               this.repairBeamMC.mcLine.x += 19;
               this.repairBeamMC.mcLine.y += 19;
               if(this._frameCounter == 7)
               {
                  this._animationPhase = "none";
                  effectsM.setStompFireForDeletion(param1);
               }
         }
      }
      
      public function removeMe() : void
      {
         this.repairBeamMC.parent.removeChild(this.repairBeamMC);
         this.repairBeamMC = null;
      }
   }
}

