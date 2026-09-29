package net.battleMechsMulti.screens.levelUp
{
   import com.greensock.TimelineMax;
   import com.greensock.easing.Back;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.text.TextField;
   import net.battleMechsMulti.mobiles.BMMovieClip;
   import net.battleMechsMulti.utils.TextUtils;
   
   public class BMLevelUpPrize extends BMMovieClip
   {
      
      public var mcLeft:MovieClip;
      
      public var mcBg:MovieClip;
      
      public var mcRight:MovieClip;
      
      public var mcIconHolder:MovieClip;
      
      public var mcIconSizer:Sprite;
      
      public var txtAmount:TextField;
      
      public var mcRewardEventBonusIndicator:Sprite;
      
      private var _amount:Number = -1;
      
      private var _eventBonusIndicator:Boolean;
      
      public function BMLevelUpPrize()
      {
         super();
      }
      
      public function setContent(param1:MovieClip, param2:int, param3:String = "", param4:Boolean = false, param5:uint = 0) : *
      {
         this.setIcon(param1);
         this.mcIconHolder.x += param5;
         this._amount = param2;
         updateTextAndFormat(this.txtAmount,param3);
         this._eventBonusIndicator = param4;
         if(this.mcRewardEventBonusIndicator != null)
         {
            this.mcRewardEventBonusIndicator.visible = false;
         }
      }
      
      public function setIcon(param1:MovieClip) : void
      {
         var _loc2_:Number = param1.width / param1.height;
         param1.height = this.mcIconSizer.height;
         param1.width = param1.height * _loc2_;
         this.mcIconHolder.addChild(param1);
      }
      
      public function getShowTimeLine(param1:Number = 1) : TimelineMax
      {
         var _loc2_:TimelineMax = new TimelineMax();
         _loc2_.timeScale(param1);
         _loc2_.fromTo(this.mcLeft,0.2,{
            "x":this.mcLeft.x - 50,
            "alpha":0
         },{
            "x":this.mcLeft.x,
            "alpha":1
         },0);
         _loc2_.fromTo(this.mcRight,0.2,{
            "x":this.mcRight.x + 50,
            "alpha":0
         },{
            "x":this.mcRight.x,
            "alpha":1
         },0);
         _loc2_.fromTo(this.mcBg,0.2,{"alpha":0},{"alpha":1},0);
         _loc2_.fromTo(this.mcIconHolder,0.2,{
            "scaleX":0,
            "scaleY":0
         },{
            "scaleX":1,
            "scaleY":1,
            "ease":Back.easeOut
         });
         _loc2_.fromTo(this.txtAmount,0.2,{"alpha":0},{"alpha":1},"-=0.2");
         if(this._amount > -1)
         {
            _loc2_.fromTo(this,0.3,{"amount":0},{"amount":this._amount});
         }
         if(this._eventBonusIndicator)
         {
            _loc2_.fromTo(this.mcRewardEventBonusIndicator,0.2,{
               "visible":true,
               "scaleX":0,
               "scaleY":0
            },{
               "scaleX":1,
               "scaleY":1,
               "ease":Back.easeOut
            });
         }
         return _loc2_;
      }
      
      public function getHideTimeLine() : TimelineMax
      {
         var _loc1_:TimelineMax = new TimelineMax({"onComplete":this.onHideAnimComplete});
         _loc1_.fromTo(this.mcLeft,0.2,{
            "x":this.mcLeft.x,
            "alpha":1
         },{
            "x":this.mcLeft.x + 50,
            "alpha":0
         },0);
         _loc1_.fromTo(this.mcRight,0.2,{
            "x":this.mcRight.x,
            "alpha":1
         },{
            "x":this.mcRight.x - 50,
            "alpha":0
         },0);
         _loc1_.fromTo(this.mcBg,0.2,{"alpha":1},{"alpha":0},0);
         _loc1_.fromTo(this.mcIconHolder,0.2,{"alpha":1},{"alpha":0},0);
         _loc1_.fromTo(this.txtAmount,0.2,{"alpha":1},{"alpha":0},0);
         if(this._eventBonusIndicator)
         {
            _loc1_.fromTo(this.mcRewardEventBonusIndicator,0.2,{"alpha":1},{"alpha":0},0);
         }
         return _loc1_;
      }
      
      private function onHideAnimComplete() : void
      {
         parent.removeChild(this);
      }
      
      public function get amount() : Number
      {
         return this._amount;
      }
      
      public function set amount(param1:Number) : void
      {
         this._amount = param1;
         updateTextAndFormat(this.txtAmount,TextUtils.getNumberWithComma(int(this._amount)));
      }
   }
}

