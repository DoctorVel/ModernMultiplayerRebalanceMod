class X2Effect_PsionicShieldReduce extends X2Effect_EnergyShield;



function int GetDefendingDamageModifier(XComGameState_Effect EffectState, XComGameState_Unit Attacker, Damageable TargetDamageable, XComGameState_Ability AbilityState, const out EffectAppliedData AppliedData, const int CurrentDamage, X2Effect_ApplyWeaponDamage WeaponDamageEffect, optional XComGameState NewGameState)
{
	local int DamageMod;

	if (X2Effect_HolyWarriorDeath(WeaponDamageEffect) != none) 
		return 0;
	
	DamageMod = (-int(float(CurrentDamage) * 0.5));

	return DamageMod;
}

defaultproperties
{
	bDisplayInSpecialDamageMessageUI = true
}