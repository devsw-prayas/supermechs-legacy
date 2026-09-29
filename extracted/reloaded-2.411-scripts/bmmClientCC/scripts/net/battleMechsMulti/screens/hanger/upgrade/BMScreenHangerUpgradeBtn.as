package net.battleMechsMulti.screens.hanger.upgrade
{
   import com.greensock.TweenMax;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.text.TextField;
   import net.battleMechsMulti.managers.BMDataManager;
   import net.battleMechsMulti.mobiles.buttons.BMBasicButton;
   import net.battleMechsMulti.utils.FeatureFlags;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol1250")]
   public class BMScreenHangerUpgradeBtn extends BMBasicButton
   {
      
      public var shutterTop:MovieClip;
      
      public var shutterBottom:MovieClip;
      
      public var txtCost:TextField;
      
      public var mcIcon:MovieClip;
      
      public function BMScreenHangerUpgradeBtn()
      {
         super();
         addFrameScript(0,this.frame1);
         this.shutterTop.orgY = this.shutterTop.y;
         this.shutterBottom.orgY = this.shutterBottom.y;
         if(!FeatureFlags.NEW_ECONOMY)
         {
            this.mcIcon.visible = false;
            this.txtCost.visible = false;
            txtTitle.y = 18;
         }
      }
      
      public function set cost(param1:int) : void
      {
         if(param1 <= 0)
         {
            disableMe();
         }
         else
         {
            enableMe();
         }
         this.txtCost.text = BMDataManager.getInstance().getNumberWithComma(param1);
         ImageUtils.swapTextFieldWithBitMap(this.txtCost,txtPlaceHolder);
      }
      
      override protected function onMobileEnterFrame(param1:Event) : void
      {
         super.onMobileEnterFrame(param1);
         this.txtCost.visible = false;
         if(!FeatureFlags.NEW_ECONOMY)
         {
            this.mcIcon.visible = false;
            txtTitle.y = 18;
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
      
      internal function frame1() : *
      {
         stop();
      }
   }
}

