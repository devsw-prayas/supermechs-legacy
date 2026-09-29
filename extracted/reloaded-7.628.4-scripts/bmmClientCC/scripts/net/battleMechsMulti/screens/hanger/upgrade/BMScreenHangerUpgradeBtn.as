package net.battleMechsMulti.screens.hanger.upgrade
{
   import com.greensock.TweenMax;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.text.TextField;
   import net.battleMechsMulti.mobiles.buttons.BMBasicButton;
   import net.battleMechsMulti.utils.FeatureFlags;
   import net.battleMechsMulti.utils.TextUtils;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol2836")]
   public class BMScreenHangerUpgradeBtn extends BMBasicButton
   {
      
      public var shutterTop:MovieClip;
      
      public var shutterBottom:MovieClip;
      
      public var txtPlaceHolder2:MovieClip;
      
      public var txtCost:TextField;
      
      public var mcIcon:MovieClip;
      
      public function BMScreenHangerUpgradeBtn()
      {
         super();
         this.shutterTop.orgY = this.shutterTop.y;
         this.shutterBottom.orgY = this.shutterBottom.y;
         if(FeatureFlags.BLOCK_TRANSFORM)
         {
            this.mcIcon.visible = false;
            this.txtCost.visible = false;
            txtTitle.y = 18;
         }
      }
      
      public function set cost(param1:int) : void
      {
         this.txtCost.text = TextUtils.getNumberWithComma(param1);
         this.txtCost.visible = true;
         ImageUtils.swapTextFieldWithBitMap(this.txtCost,this.txtPlaceHolder2);
      }
      
      override protected function onMobileEnterFrame(param1:Event) : void
      {
         super.onMobileEnterFrame(param1);
         if(this.txtCost.visible)
         {
            this.txtCost.visible = false;
         }
      }
      
      public function open() : void
      {
         TweenMax.to(this.shutterTop,0.5,{"y":this.shutterTop.orgY - this.shutterTop.height});
         TweenMax.to(this.shutterBottom,0.5,{"y":this.shutterBottom.orgY + this.shutterBottom.height});
      }
      
      public function close() : void
      {
         TweenMax.to(this.shutterTop,0.5,{"y":this.shutterTop.orgY});
         TweenMax.to(this.shutterBottom,0.5,{"y":this.shutterBottom.orgY});
      }
   }
}

