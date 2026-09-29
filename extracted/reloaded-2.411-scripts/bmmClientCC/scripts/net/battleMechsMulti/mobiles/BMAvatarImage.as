package net.battleMechsMulti.mobiles
{
   import flash.display.Bitmap;
   import flash.display.Sprite;
   
   public class BMAvatarImage extends BMBaseClass
   {
      
      private var avatarSizer:Sprite;
      
      private var avatarID:Number;
      
      private var url:String;
      
      private var targetWidth:Number;
      
      private var targetHeight:Number;
      
      private var avatarImage:Bitmap;
      
      private var removed:Boolean = false;
      
      public function BMAvatarImage()
      {
         super();
      }
      
      public function initialize(param1:Number, param2:String, param3:Number, param4:Number) : void
      {
         generateSingletonClassesPointers("");
         this.avatarID = param1;
         this.url = param2;
         this.targetWidth = param3;
         this.targetHeight = param4;
         if(this.url != null)
         {
            if(this.url != "")
            {
               dataM.applyForNewAvatarImage(this,this.url,param3,param4);
               this.avatarSizer = new Sprite();
               this.avatarSizer.graphics.beginFill(0,0);
               this.avatarSizer.graphics.drawRect(0,0,param3,param4);
               addChild(this.avatarSizer);
            }
         }
      }
      
      public function setAvatarImage(param1:Bitmap) : void
      {
         this.avatarImage = param1;
         addChild(this.avatarImage);
      }
      
      public function removeMe() : void
      {
         if(this.removed == false)
         {
            if(this.avatarImage != null)
            {
               if(this.avatarImage.parent != null)
               {
                  this.avatarImage.parent.removeChild(this.avatarImage);
               }
               this.avatarImage = null;
            }
            if(this.avatarSizer != null)
            {
               if(this.avatarSizer.parent != null)
               {
                  this.avatarSizer.parent.removeChild(this.avatarSizer);
               }
               this.avatarSizer = null;
            }
            this.removed = true;
         }
      }
   }
}

