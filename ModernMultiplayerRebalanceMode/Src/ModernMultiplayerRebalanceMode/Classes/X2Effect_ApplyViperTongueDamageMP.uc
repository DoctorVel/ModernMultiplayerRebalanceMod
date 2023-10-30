class X2Effect_ApplyViperTongueDamageMP extends X2Effect_ApplyWeaponDamage;

var WeaponDamageValue EffectDamageValueAdvanced;

function WeaponDamageValue GetBonusEffectDamageValue(XComGameState_Ability AbilityState, XComGameState_Unit SourceUnit, XComGameState_Item SourceWeapon, StateObjectReference TargetRef) 
{	
	if (SourceUnit.GetMyTemplateName() == 'ViperMP'|| SourceUnit.GetMyTemplateName() == 'ViperNeonateMP')
	{
		return EffectDamageValueAdvanced;
	}
	return EffectDamageValue; 
}
