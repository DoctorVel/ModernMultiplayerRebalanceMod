class X2Condition_GreaterMindMerge extends X2Condition;

event name CallMeetsCondition(XComGameState_BaseObject kTarget)
{
	local XComGameState_Unit UnitState;

	UnitState = XComGameState_Unit(kTarget);
	if (UnitState == none)
		return 'AA_NotAUnit';
	if (UnitState.IsDead() || UnitState.IsUnconscious() || UnitState.IsBleedingOut())
		return 'AA_UnitIsDead';
	if (UnitState.GetMyTemplate().CharacterGroupName != 'Sectoid')
		return 'AA_UnitIsNotSectoid';

	return 'AA_Success';
}