class X2Condition_NotFullHP extends X2Condition;

event name CallMeetsCondition(XComGameState_BaseObject kTarget) 
{
	local XComGameState_Unit UnitState;
	
	UnitState = XComGameState_Unit(kTarget);
	
	if (UnitState == none)
		return 'AA_NotAUnit';

	if (UnitState.GetCurrentStat(eStat_HP) < UnitState.GetMaxStat(eStat_HP))
		return 'AA_Success';  
	
	return 'AA_UnitIsNotInjured';
	
}
