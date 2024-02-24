class X2Effect_Headshot extends X2Effect_Persistent;

function GetToHitModifiers(XComGameState_Effect EffectState, XComGameState_Unit Attacker, XComGameState_Unit Target, XComGameState_Ability AbilityState, class<X2AbilityToHitCalc> ToHitType, bool bMelee, bool bFlanking, bool bIndirectFire, out array<ShotModifierInfo> ShotModifiers)
{
	local ShotModifierInfo CritInfo;

	if (!bFlanking) 
	return;

	CritInfo.ModType = eHit_Crit;
	CritInfo.Value = 30;
	CritInfo.Reason = FriendlyName;
	ShotModifiers.AddItem(CritInfo);

}

defaultproperties
{
	bDisplayInSpecialDamageMessageUI = true
}