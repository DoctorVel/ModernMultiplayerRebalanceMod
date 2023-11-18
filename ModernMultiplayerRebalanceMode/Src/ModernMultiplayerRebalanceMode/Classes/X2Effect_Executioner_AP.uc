//---------------------------------------------------------------------------------------
//  FILE:    X2Effect_Executioner
//  AUTHOR:  John Lumpkin (Long War Studios)
//  PURPOSE: Sets up Executioner perk effect
//---------------------------------------------------------------------------------------

class X2Effect_Executioner_AP extends X2Effect_Persistent config (WOTC_AlienPack);


function GetToHitModifiers(XComGameState_Effect EffectState, XComGameState_Unit Attacker, XComGameState_Unit Target, XComGameState_Ability AbilityState, class<X2AbilityToHitCalc> ToHitType, bool bMelee, bool bFlanking, bool bIndirectFire, out array<ShotModifierInfo> ShotModifiers)
{
  local XComGameState_Item SourceWeapon;
  local ShotModifierInfo ShotInfo;

  SourceWeapon = AbilityState.GetSourceWeapon();
  if ((SourceWeapon != none) && (Target != none))
  {
    if (Target.GetCurrentStat(eStat_HP) <= (Target.GetMaxStat(eStat_HP) / 2))
    {
      ShotInfo.ModType = eHit_Success;
      ShotInfo.Reason = FriendlyName;
      ShotInfo.Value = 10;
      ShotModifiers.AddItem(ShotInfo);

      ShotInfo.ModType = eHit_Crit;
      ShotInfo.Reason = FriendlyName;
      ShotInfo.Value = 0;
      ShotModifiers.AddItem(ShotInfo);
    }
  }
}

defaultproperties
{
  DuplicateResponse=eDupe_Ignore
  EffectName="Executioner"
}
