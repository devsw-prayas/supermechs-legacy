package net.battleMechsMulti.mobiles.effects
{
   import flash.display.MovieClip;
   import net.battleMechsMulti.mobiles.BMBaseClass;
   
   public class BMEffectShutDown extends BMBaseClass
   {
      
      private var shutDownEffectMC:MovieClip;
      
      public var holderMC:MovieClip;
      
      private var _fastMode:Boolean;
      
      private var _returnFunction:Function;
      
      private var _frameCounter:Number;
      
      public function BMEffectShutDown()
      {
         super();
      }
      
      public function initialize(param1:String, param2:Number, param3:Number, param4:Boolean, param5:Function, param6:MovieClip) : void
      {
         generateSingletonClassesPointers("");
         this.shutDownEffectMC = externalAssetsM.getAsset("general",param1);
         this.shutDownEffectMC.x = param2;
         this.shutDownEffectMC.y = param3;
         this.shutDownEffectMC.mcArrow1.alpha = 0;
         this.shutDownEffectMC.mcArrow2.alpha = 0;
         this.shutDownEffectMC.mcArrow3.alpha = 0;
         this.holderMC = param6;
         this.holderMC.addChild(this.shutDownEffectMC);
         this._fastMode = param4;
         this._returnFunction = param5;
         this._frameCounter = 0;
      }
      
      public function runFrame(param1:uint) : void
      {
         var _loc2_:Boolean = false;
         if(this._fastMode)
         {
            if(this._frameCounter < 45)
            {
               if(this._frameCounter < 5)
               {
                  this.shutDownEffectMC.mcArrow1.alpha += 0.2;
               }
               else if(this._frameCounter < 20)
               {
                  this.shutDownEffectMC.mcArrow1.y += 6.6;
               }
               else if(this._frameCounter < 25)
               {
                  this.shutDownEffectMC.mcArrow1.alpha -= 0.2;
               }
               if(this._frameCounter >= 10)
               {
                  if(this._frameCounter < 15)
                  {
                     this.shutDownEffectMC.mcArrow2.alpha += 0.2;
                  }
                  else if(this._frameCounter < 30)
                  {
                     this.shutDownEffectMC.mcArrow2.y += 6.6;
                  }
                  else if(this._frameCounter < 35)
                  {
                     this.shutDownEffectMC.mcArrow2.alpha -= 0.2;
                  }
               }
               if(this._frameCounter >= 20)
               {
                  if(this._frameCounter < 25)
                  {
                     this.shutDownEffectMC.mcArrow3.alpha += 0.2;
                  }
                  else if(this._frameCounter < 40)
                  {
                     this.shutDownEffectMC.mcArrow3.y += 6.6;
                  }
                  else if(this._frameCounter < 45)
                  {
                     this.shutDownEffectMC.mcArrow3.alpha -= 0.2;
                  }
               }
               ++this._frameCounter;
            }
            else
            {
               _loc2_ = true;
            }
         }
         else if(this._frameCounter < 45)
         {
            if(this._frameCounter < 5)
            {
               this.shutDownEffectMC.mcArrow1.alpha += 0.2;
            }
            else if(this._frameCounter < 20)
            {
               this.shutDownEffectMC.mcArrow1.y += 6.6;
            }
            else if(this._frameCounter < 25)
            {
               this.shutDownEffectMC.mcArrow1.alpha -= 0.2;
            }
            if(this._frameCounter >= 10)
            {
               if(this._frameCounter < 15)
               {
                  this.shutDownEffectMC.mcArrow2.alpha += 0.2;
               }
               else if(this._frameCounter < 30)
               {
                  this.shutDownEffectMC.mcArrow2.y += 6.6;
               }
               else if(this._frameCounter < 35)
               {
                  this.shutDownEffectMC.mcArrow2.alpha -= 0.2;
               }
            }
            if(this._frameCounter >= 20)
            {
               if(this._frameCounter < 25)
               {
                  this.shutDownEffectMC.mcArrow3.alpha += 0.2;
               }
               else if(this._frameCounter < 40)
               {
                  this.shutDownEffectMC.mcArrow3.y += 6.6;
               }
               else if(this._frameCounter < 45)
               {
                  this.shutDownEffectMC.mcArrow3.alpha -= 0.2;
               }
            }
            ++this._frameCounter;
         }
         else
         {
            _loc2_ = true;
         }
         if(_loc2_)
         {
            if(this._returnFunction != null)
            {
               this._returnFunction();
            }
            effectsM.setShutDownForDeletion(param1);
         }
      }
      
      public function removeMe() : void
      {
         this.shutDownEffectMC.parent.removeChild(this.shutDownEffectMC);
         this.shutDownEffectMC = null;
      }
   }
}

