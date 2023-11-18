class AHW_Effect_EtherealDivinity extends X2Effect_Persistent; 

var int Penalty;

function GetToHitAsTargetModifiers(XComGameState_Effect EffectState, XComGameState_Unit Attacker, XComGameState_Unit Target, XComGameState_Ability AbilityState, class<X2AbilityToHitCalc> ToHitType, bool bMelee, bool bFlanking, bool bIndirectFire, out array<ShotModifierInfo> ShotModifiers)
{
	local ShotModifierInfo ShotInfo;


	ShotInfo.ModType = eHit_Crit;
	ShotInfo.Value = Penalty;
	ShotInfo.Reason = FriendlyName;
	ShotModifiers.AddItem(ShotInfo);
	
}