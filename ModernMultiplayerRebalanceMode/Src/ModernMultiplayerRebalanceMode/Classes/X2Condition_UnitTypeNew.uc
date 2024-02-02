class X2Condition_UnitTypeNew extends X2Condition;

event name CallMeetsCondition(XComGameState_BaseObject kTarget) 
{
	local XComGameState_Unit UnitState;
	
	UnitState = XComGameState_Unit(kTarget);
	
	if (UnitState == none)
		return 'AA_NotAUnit';

	if (UnitState.GetMyTemplateName() == 'Centurion')
		return 'AA_Success';  
	
	return 'AA_UnitIsWrongType';
	
}
