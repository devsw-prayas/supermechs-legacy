package net.battleMechsMulti.mobiles
{
   import flash.display.Sprite;
   import flash.geom.Point;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol1665")]
   public class BMBattleRewardAnimation extends BMBaseClass
   {
      
      public var mcStar1:Sprite;
      
      public var mcStar2:Sprite;
      
      public var mcStar3:Sprite;
      
      public var mcStarEmpty1:Sprite;
      
      public var mcStarEmpty2:Sprite;
      
      public var mcStarEmpty3:Sprite;
      
      public var mcRegularBattle:Sprite;
      
      private var _battleResult:String;
      
      private var _battleNumber:uint;
      
      private var _targetBattleMarkerPoint:Point;
      
      private var _animationEndedFunction:Function;
      
      private var stars:Array;
      
      private var emptyStars:Array;
      
      private var originXYPos:Array;
      
      private var _originXPos:Number;
      
      private var _originYPos:Number;
      
      private var _frameCounter:uint;
      
      private var _animationActive:Boolean = false;
      
      private const STAR_OUT_Y_POS:Number = -150;
      
      public function BMBattleRewardAnimation()
      {
         super();
      }
      
      public function initialize() : void
      {
         generateSingletonClassesPointers("");
         this._originXPos = x;
         this._originYPos = y;
         this.stars = new Array();
         this.stars[1] = this.mcStar1;
         this.stars[2] = this.mcStar2;
         this.stars[3] = this.mcStar3;
         this.originXYPos = new Array();
         this.originXYPos[1] = new Point(this.mcStar1.x,this.mcStar1.y);
         this.originXYPos[2] = new Point(this.mcStar2.x,this.mcStar2.y);
         this.originXYPos[3] = new Point(this.mcStar3.x,this.mcStar3.y);
         this.emptyStars = new Array();
         this.emptyStars[1] = this.mcStarEmpty1;
         this.emptyStars[2] = this.mcStarEmpty2;
         this.emptyStars[3] = this.mcStarEmpty3;
      }
      
      public function startAnimation(param1:String, param2:uint, param3:Point, param4:Function) : void
      {
         this._animationActive = true;
         this._battleResult = param1;
         this._battleNumber = param2;
         this._targetBattleMarkerPoint = param3;
         this._animationEndedFunction = param4;
         if(this._battleResult == "lose")
         {
            ++this._battleNumber;
         }
         this._frameCounter = 0;
         scaleX = 1;
         scaleY = 1;
         x = this._originXPos;
         y = this._originYPos;
         var _loc5_:uint = 1;
         while(_loc5_ <= 3)
         {
            this.stars[_loc5_].scaleX = 1;
            this.stars[_loc5_].scaleY = 1;
            switch(this._battleResult)
            {
               case "win":
                  if(_loc5_ < this._battleNumber)
                  {
                     this.stars[_loc5_].visible = true;
                  }
                  else
                  {
                     this.stars[_loc5_].visible = false;
                  }
                  this.stars[_loc5_].x = this.originXYPos[_loc5_].x;
                  this.stars[_loc5_].y = this.originXYPos[_loc5_].y;
                  this.emptyStars[_loc5_].visible = true;
                  break;
               case "lose":
                  if(this._battleNumber == 3)
                  {
                     this.stars[_loc5_].visible = true;
                     this.stars[_loc5_].x = 0;
                     this.stars[_loc5_].y = 0;
                     this.emptyStars[_loc5_].visible = false;
                  }
                  else
                  {
                     if(_loc5_ > this._battleNumber)
                     {
                        this.stars[_loc5_].visible = false;
                     }
                     else
                     {
                        this.stars[_loc5_].visible = true;
                     }
                     this.stars[_loc5_].x = this.originXYPos[_loc5_].x;
                     this.stars[_loc5_].y = this.originXYPos[_loc5_].y;
                     this.emptyStars[_loc5_].visible = true;
                  }
            }
            _loc5_++;
         }
         switch(this._battleResult)
         {
            case "win":
               this.stars[this._battleNumber].x = this.originXYPos[this._battleNumber].x;
               this.stars[this._battleNumber].y = this.originXYPos[this._battleNumber].y;
               this.stars[this._battleNumber].x = 0;
               this.stars[this._battleNumber].y = this.STAR_OUT_Y_POS;
               this.stars[this._battleNumber].scaleX = 0.1;
               this.stars[this._battleNumber].scaleY = 0.1;
         }
         this.mcRegularBattle.scaleX = 1;
         this.mcRegularBattle.scaleY = 1;
         this.mcRegularBattle.visible = false;
      }
      
      public function isAnimationActive() : Boolean
      {
         return this._animationActive;
      }
      
      public function onEnterFrameTrigger() : void
      {
         var _loc1_:uint = 0;
         var _loc2_:Number = NaN;
         var _loc3_:Number = NaN;
         var _loc4_:Boolean = false;
         var _loc5_:Boolean = false;
         if(this._animationActive)
         {
            if(screensM.isScreenOpened("screenWorldMap"))
            {
               ++this._frameCounter;
               _loc4_ = false;
               _loc5_ = false;
               switch(this._battleResult)
               {
                  case "win":
                     if(this._frameCounter <= 13)
                     {
                        if(this._frameCounter == 1)
                        {
                           this.stars[this._battleNumber].visible = true;
                        }
                        this.stars[this._battleNumber].scaleX += 0.1;
                        this.stars[this._battleNumber].scaleY += 0.1;
                     }
                     else if(this._frameCounter <= 17)
                     {
                        this.stars[this._battleNumber].scaleX -= 0.1;
                        this.stars[this._battleNumber].scaleY -= 0.1;
                     }
                     else if(this._frameCounter <= 33)
                     {
                        if(this._frameCounter >= 23)
                        {
                           _loc2_ = this.originXYPos[this._battleNumber].x - this.stars[this._battleNumber].x;
                           _loc3_ = this.originXYPos[this._battleNumber].y - this.stars[this._battleNumber].y;
                           this.stars[this._battleNumber].x += _loc2_ * 0.3;
                           this.stars[this._battleNumber].y += _loc3_ * 0.3;
                        }
                     }
                     else if(this._frameCounter == 34)
                     {
                        this.stars[this._battleNumber].x = this.originXYPos[this._battleNumber].x;
                        this.stars[this._battleNumber].y = this.originXYPos[this._battleNumber].y;
                     }
                     else if(this._battleNumber == 3)
                     {
                        if(this._frameCounter == 35)
                        {
                           this.mcStarEmpty1.visible = false;
                           this.mcStarEmpty2.visible = false;
                           this.mcStarEmpty3.visible = false;
                        }
                        if(this._frameCounter <= 45)
                        {
                           _loc1_ = 1;
                           while(_loc1_ <= 3)
                           {
                              if(this._frameCounter < 45)
                              {
                                 this.stars[_loc1_].x -= this.originXYPos[_loc1_].x / 10;
                                 this.stars[_loc1_].y -= this.originXYPos[_loc1_].y / 10;
                              }
                              else
                              {
                                 this.stars[_loc1_].x = 0;
                                 this.stars[_loc1_].y = 0;
                              }
                              _loc1_++;
                           }
                        }
                     }
                     else if(this._frameCounter < 45)
                     {
                        this._frameCounter = 45;
                     }
                     if(this._frameCounter >= 55)
                     {
                        if(this._frameCounter <= 70)
                        {
                           _loc4_ = true;
                        }
                        else if(this._frameCounter == 71)
                        {
                           _loc5_ = true;
                        }
                     }
                     break;
                  case "lose":
                     if(this._frameCounter <= 10)
                     {
                        if(this._battleNumber == 3)
                        {
                           _loc1_ = 1;
                           while(_loc1_ <= 3)
                           {
                              if(this._frameCounter < 10)
                              {
                                 this.stars[_loc1_].x += this.originXYPos[_loc1_].x / 10;
                                 this.stars[_loc1_].y += this.originXYPos[_loc1_].y / 10;
                              }
                              else
                              {
                                 this.stars[_loc1_].x = this.originXYPos[_loc1_].x;
                                 this.stars[_loc1_].y = this.originXYPos[_loc1_].y;
                                 this.emptyStars[3].visible = true;
                              }
                              _loc1_++;
                           }
                        }
                        else
                        {
                           this._frameCounter = 10;
                        }
                     }
                     else if(this._frameCounter <= 25)
                     {
                        if(this._frameCounter > 15)
                        {
                           if(this._frameCounter < 25)
                           {
                              this.stars[this._battleNumber].x += (0 - this.originXYPos[this._battleNumber].x) / 10;
                              this.stars[this._battleNumber].y += (this.STAR_OUT_Y_POS - this.originXYPos[this._battleNumber].y) / 10;
                           }
                           else
                           {
                              this.stars[this._battleNumber].x = 0;
                              this.stars[this._battleNumber].y = this.STAR_OUT_Y_POS;
                           }
                        }
                     }
                     else if(this._frameCounter <= 45)
                     {
                        if(this._frameCounter > 35)
                        {
                           if(this._frameCounter < 45)
                           {
                              this.stars[this._battleNumber].scaleX -= 0.1;
                              this.stars[this._battleNumber].scaleY -= 0.1;
                           }
                           else
                           {
                              this.stars[this._battleNumber].visible = false;
                           }
                        }
                     }
                     else if(this._battleNumber == 1)
                     {
                        if(this._frameCounter <= 63)
                        {
                           if(this._frameCounter <= 59)
                           {
                              if(this._frameCounter == 46)
                              {
                                 this.mcRegularBattle.visible = true;
                                 this.mcRegularBattle.scaleX = 0.1;
                                 this.mcRegularBattle.scaleY = 0.1;
                              }
                              else
                              {
                                 this.mcRegularBattle.scaleX += 0.1;
                                 this.mcRegularBattle.scaleY += 0.1;
                              }
                           }
                           else
                           {
                              if(this._frameCounter == 60)
                              {
                                 this.emptyStars[1].visible = false;
                                 this.emptyStars[2].visible = false;
                                 this.emptyStars[3].visible = false;
                              }
                              this.mcRegularBattle.scaleX -= 0.1;
                              this.mcRegularBattle.scaleY -= 0.1;
                           }
                        }
                     }
                     else if(this._frameCounter < 62)
                     {
                        this._frameCounter = 62;
                     }
                     if(this._frameCounter >= 70)
                     {
                        if(this._frameCounter <= 85)
                        {
                           _loc4_ = true;
                        }
                        else if(this._frameCounter == 86)
                        {
                           _loc5_ = true;
                        }
                     }
               }
               if(_loc4_)
               {
                  _loc2_ = this._targetBattleMarkerPoint.x - this._originXPos;
                  _loc3_ = this._targetBattleMarkerPoint.y - this._originYPos;
                  x += _loc2_ / 16;
                  y += _loc3_ / 16;
                  scaleX -= 0.05;
                  scaleY -= 0.05;
               }
               else if(_loc5_)
               {
                  visible = false;
                  this._animationEndedFunction();
                  this._animationActive = false;
               }
            }
            else
            {
               visible = false;
               this._animationActive = false;
            }
         }
      }
   }
}

