package net.battleMechsMulti.mobiles.effects
{
   import flash.display.MovieClip;
   import net.battleMechsMulti.mobiles.BMBaseClass;
   
   public class BMEffectFlame extends BMBaseClass
   {
      
      private var flameMC:MovieClip;
      
      public var holderMC:MovieClip;
      
      private var grp:String;
      
      private var _framesPerImage:uint;
      
      private var _imagesTotal:uint;
      
      private var _currentImage:uint;
      
      private var _frameCounter:Number;
      
      public function BMEffectFlame()
      {
         super();
      }
      
      public function initialize(param1:String, param2:Number, param3:Boolean, param4:uint, param5:uint, param6:MovieClip) : void
      {
         generateSingletonClassesPointers("");
         this.flameMC = externalAssetsM.getAsset("general",param1,param2,param2,false,false,false);
         if(param3)
         {
            this.flameMC.scaleX *= -1;
         }
         addChild(this.flameMC);
         this.flameMC.mcGrp1.visible = false;
         this.flameMC.mcGrp2.visible = false;
         this.flameMC.mcGrp3.visible = false;
         this.flameMC.mcGrp4.visible = false;
         this.flameMC.mcGrp5.visible = false;
         this.flameMC.mcGrp6.visible = false;
         this.flameMC.mcGrp7.visible = false;
         this.flameMC.mcGrp8.visible = false;
         this.flameMC.mcGrp9.visible = false;
         this.flameMC.mcGrp10.visible = false;
         this.flameMC.mcGrp11.visible = false;
         this._framesPerImage = param4;
         this._imagesTotal = param5;
         this.holderMC = param6;
         this._frameCounter = 0;
         this._currentImage = 0;
      }
      
      public function runFrame(param1:uint) : void
      {
         if(this._currentImage < this._imagesTotal)
         {
            if(this._frameCounter >= this._framesPerImage)
            {
               ++this._currentImage;
               if(this.flameMC["mcGrp" + this._currentImage] != null)
               {
                  this.flameMC["mcGrp" + this._currentImage].visible = true;
               }
               if(this.flameMC["mcGrp" + (this._currentImage - 1)] != null)
               {
                  this.flameMC["mcGrp" + (this._currentImage - 1)].visible = false;
               }
               this._frameCounter = 0;
            }
            else
            {
               ++this._frameCounter;
            }
         }
         else if(this._frameCounter >= this._framesPerImage)
         {
            effectsM.setFlameForDeletion(param1);
         }
         else
         {
            ++this._frameCounter;
         }
         ++this._frameCounter;
      }
      
      public function removeMe() : void
      {
         this.flameMC.parent.removeChild(this.flameMC);
         this.flameMC = null;
      }
   }
}

