package net.battleMechsMulti.utils
{
   public class NameGenerator
   {
      
      private static var $FIRST_NAMES:Array = ["Vital","Night","Calm","Rusty","Glass","Hydro","Shadow","Rose","Grim","Chaos","Rain","Spirit","Typhoon","Sunrise","Lord","Shadow","Star","Sunset","Serenity","Lazarus","Brave","Captain","Chief","Admiral","Flame","Black","Golden","Violet","Scarlet","Red","Azure","Cyan","Olive","Forest","Gray","Maroon","Misty","Navy","Royal","Sky","Mad","Veteran","Mountain","Jungle","Teal","Midnight","Sepia","Copper","Silver","Antique","Charcoal","White","Electric","Neon","Plasma","Ion","Hell","Nuclear","Defense","Engineering","Proto","Nullification","BioElectronic","Toyota","Metal","Steel","Copper","Rusty","Gold","Lead","Tin","Platinum","Nickel","Zinc","Silicon","Nitrogen","Carbon","Adamantium"];
      
      private static var $LAST_NAMES:Array = ["Ratchet","Drone","Machine","Juggernaut","Drillbit","Droid","Bulldozer","Cyborg","Giant","Psycho","Prototype","Cat","Bull","Scorpion","Seal","Bird","Piranha","Barracuda","Werewolf","Tortoise","Satyr","Rhino","Raccoon","Beaver","Shark","Gorilla","Zebra","Raven","Tiger","Havoc","Flame","Jester","Dragon","Griffon","Talon","Bane","Legend","Chaos","Lord","Zealot","Saber","Sunrise","Angel","Seeker","Hunter","Chaos","Tempest","Rain","Spirit","Tiger","Typhoon","Sunrise","Shadow","Machete","Star","Sunset","Chief","Echo","Albatross","Alligator","Boar","Cheetah","Crow","Dragonfly","Eagle","Falcon","Fox","Hornet","Leopard","Narwhal","Owl","Panther","Snek","Griffin","Dryad","Gorgon","Centaur","Hydra","Minotaur","Orion","Phoenix","Sphinx","Unicorn","Pegasus","Fury","Nemesis","Viper","Manta","Scorpion","Leviathan","Goliath","Paladin","Raptor","Crusher","Chimera","Omnidroid","Warhead"];
      
      private static var $FULL_NAMES:Array = ["BB-8","C-3PO","R2-D2","K-2SO","V.I.N.CENT","C.H.O.M.P.S.","T-800","Rodney Copperbottom","Clank","Baymax","TARS","Deep Thought","The Energizer Bunny ","Ultron","RoboGadget","Bender","Colossus","Marvin the Smasher Android","The Tin Man","Cyborg Noodle","Iron Man","Tik-Tok","HK-47","TheDoctor","Spock","Khan","LukeSkywalker","DarthVader","TonyStark","FlashGordon","Neo","AgentSmith","Morphius","Marvin","Bender","BobaFett","OptimusPrime","ThePredator","RoboCop","Chewbacca","CaptainNemo","LanceArmstrong","Bonaparte","JuliusCaesar","ArchitectTed","Apollo","Ares","Atlas","Hades","Kratos","Scorpius","TheMaster","Tauriel","Amidala","QuickSilver","Titus","Thanos","Ramesses","StoneHeart","EarthCrusher","MadKiller","WitchClaw","Odin","Thor","Loki","Freyja","Heimdallr","Vanir","Jupiter","Juno","Neptune","Janos","Vesta","Diana","Vulcan","Fides","Fortuna","Terminus","Ceres","Tychus","Mengsk","Arcturus","Alarak","Artanis","Amon","Anubis","Heket","Nephthys","Athos"
      ,"Cyclops","Medusa","Hellbender","Rob Bott"];
      
      public function NameGenerator()
      {
         super();
      }
      
      private static function pick(param1:*) : String
      {
         var _loc2_:int = Math.floor(Math.random() * param1.length);
         return String(param1[_loc2_]);
      }
      
      public static function GenerateName() : String
      {
         return NameGenerator.CreateRandomName();
      }
      
      private static function CreateRandomName() : String
      {
         if(Math.random() > 0.9)
         {
            return NameGenerator.pick(NameGenerator.$FULL_NAMES);
         }
         var _loc1_:String = NameGenerator.pick(NameGenerator.$FIRST_NAMES);
         var _loc2_:String = NameGenerator.pick(NameGenerator.$LAST_NAMES);
         while(_loc1_ == _loc2_)
         {
            _loc2_ = NameGenerator.pick(NameGenerator.$LAST_NAMES);
         }
         return _loc1_ + " " + _loc2_;
      }
   }
}

