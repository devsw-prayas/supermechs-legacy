package net.battleMechsMulti.mobiles
{
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.MovieClip;
   import flash.geom.ColorTransform;
   
   public class BMClanFlag
   {
      
      private var mcFlag:MovieClip;
      
      private var colorsDB:Array = new Array();
      
      private var _runAsMobile:Boolean;
      
      private var flagBM:Bitmap;
      
      private var flagBMD:BitmapData;
      
      public function BMClanFlag()
      {
         super();
      }
      
      public function initialize(param1:MovieClip, param2:Boolean) : void
      {
         this._runAsMobile = param2;
         this.mcFlag = param1;
         this.colorsDB[1] = 4278190080;
         this.colorsDB[2] = 4281545523;
         this.colorsDB[3] = 4284900966;
         this.colorsDB[4] = 4288256409;
         this.colorsDB[5] = 4294967295;
         this.colorsDB[6] = 4288230246;
         this.colorsDB[7] = 4291585587;
         this.colorsDB[8] = 4288217088;
         this.colorsDB[9] = 4294901760;
         this.colorsDB[10] = 4294927872;
         this.colorsDB[11] = 4294940928;
         this.colorsDB[12] = 4281571584;
         this.colorsDB[13] = 4278216192;
         this.colorsDB[14] = 4284900864;
         this.colorsDB[15] = 4278216294;
         this.colorsDB[16] = 4278216345;
         this.colorsDB[17] = 4278203238;
         this.colorsDB[18] = 4281545472;
      }
      
      public function updateFlag(param1:Array) : void
      {
         this.setCenterFrame(param1[0]);
         this.setSidesFrame(param1[1]);
         this.setCenterColor(param1[2]);
         this.setSidesColor(param1[3]);
         this.setBackgroundColor(param1[4]);
         if(this._runAsMobile)
         {
            this.flagBMD = new BitmapData(this.mcFlag.width / this.mcFlag.scaleX,this.mcFlag.height / this.mcFlag.scaleY,false);
            this.flagBM = new Bitmap(this.flagBMD,"auto",true);
            this.flagBMD.draw(this.mcFlag);
            this.mcFlag.addChild(this.flagBM);
            this.mcFlag.mcCenter.parent.removeChild(this.mcFlag.mcCenter);
            this.mcFlag.mcCenter = null;
            this.mcFlag.mcSides.parent.removeChild(this.mcFlag.mcSides);
            this.mcFlag.mcSides = null;
            this.mcFlag.mcBackground.parent.removeChild(this.mcFlag.mcBackground);
            this.mcFlag.mcBackground = null;
         }
      }
      
      public function setCenterFrame(param1:uint) : void
      {
         this.mcFlag.mcCenter.gotoAndStop(param1);
      }
      
      public function setSidesFrame(param1:uint) : void
      {
         this.mcFlag.mcSides.gotoAndStop(param1);
      }
      
      public function setCenterColor(param1:uint) : void
      {
         var _loc2_:ColorTransform = new ColorTransform();
         _loc2_.color = this.colorsDB[param1];
         this.mcFlag.mcCenter.transform.colorTransform = _loc2_;
      }
      
      public function setSidesColor(param1:uint) : void
      {
         var _loc2_:ColorTransform = new ColorTransform();
         _loc2_.color = this.colorsDB[param1];
         this.mcFlag.mcSides.transform.colorTransform = _loc2_;
      }
      
      public function setBackgroundColor(param1:uint) : void
      {
         var _loc2_:ColorTransform = new ColorTransform();
         _loc2_.color = this.colorsDB[param1];
         this.mcFlag.mcBackground.transform.colorTransform = _loc2_;
      }
      
      public function removeMe() : void
      {
         if(this.mcFlag != null)
         {
            if(this.mcFlag.mcCenter != null)
            {
               this.mcFlag.mcCenter.parent.removeChild(this.mcFlag.mcCenter);
               this.mcFlag.mcCenter = null;
               this.mcFlag.mcSides.parent.removeChild(this.mcFlag.mcSides);
               this.mcFlag.mcSides = null;
               this.mcFlag.mcBackground.parent.removeChild(this.mcFlag.mcBackground);
               this.mcFlag.mcBackground = null;
            }
            if(this.mcFlag.parent != null)
            {
               this.mcFlag.parent.removeChild(this.mcFlag);
               this.mcFlag = null;
            }
         }
         if(this._runAsMobile)
         {
            if(this.flagBM != null)
            {
               this.flagBMD.dispose();
               this.flagBM.parent.removeChild(this.flagBM);
               this.flagBM = null;
            }
         }
      }
   }
}

