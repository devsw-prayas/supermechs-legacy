package net.battleMechsMulti.screens.kinShop
{
   import com.greensock.TweenMax;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.text.TextField;
   import net.battleMechsMulti.mobiles.BMBaseClass;
   import net.battleMechsMulti.mobiles.buttons.BMBasicButton;
   import net.battleMechsMulti.mobiles.buttons.BMIntractable;
   
   public class BMKinClaimPanel extends BMBaseClass
   {
      
      public var txtTitle:TextField;
      
      public var txtValue:TextField;
      
      public var btnClaim:BMBasicButton;
      
      public var mcBadge:Sprite;
      
      private var _badgeOriginScale:Number;
      
      public function BMKinClaimPanel()
      {
         super();
         generateSingletonClassesPointers();
         setLanguageManagerScreenName("kin");
         updateTextAndFormat(this.txtTitle,getScreenText("freeKin"));
         this.btnClaim.text = getSpecificText("buyTokens_claim");
         this.btnClaim.addEventListener(BMIntractable.HIT,this.claimClicked);
         this._badgeOriginScale = this.mcBadge.scaleX;
         addEventListener(Event.REMOVED_FROM_STAGE,this.onRemovedFromStage);
      }
      
      public function claimClicked(param1:Event) : void
      {
         this.btnClaim.disableMe();
         dataM.kinM.claimKin();
      }
      
      public function refreshData() : void
      {
         this.txtValue.text = dataM.kinM.kinClaimBonus.toString();
         this.activateBounceAnim();
      }
      
      private function activateBounceAnim() : void
      {
         var _loc1_:Number = 1.1;
         TweenMax.fromTo(this.mcBadge,0.5,{
            "scaleX":this._badgeOriginScale * _loc1_,
            "scaleY":this._badgeOriginScale * _loc1_
         },{
            "scaleX":this._badgeOriginScale,
            "scaleY":this._badgeOriginScale,
            "onComplete":this.activateBounceAnim
         });
      }
      
      private function onRemovedFromStage(param1:Event) : void
      {
         TweenMax.killTweensOf(this.mcBadge);
      }
   }
}

