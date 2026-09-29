package net.tacticsoft.global
{
   public class BMMClientFlashConsts
   {
      
      private static const devPort:uint = 915;
      
      private static const betaPort:uint = 931;
      
      private static const defaultAuthPort:uint = 944;
      
      private static const betaAuthPort:uint = 946;
      
      private static const usingBeta:Boolean = false;
      
      public static const usedPortForDev:uint = usingBeta ? betaPort : devPort;
      
      public static const usedAuthPort:uint = usingBeta ? betaAuthPort : defaultAuthPort;
      
      public static const minimalAnalyticsPriorityToAlwaysSend:int = 1;
      
      public function BMMClientFlashConsts()
      {
         super();
      }
   }
}

