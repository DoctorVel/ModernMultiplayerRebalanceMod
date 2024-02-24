class X2Condition_UnitTypePossess extends X2Condition;

event name CallMeetsCondition(XComGameState_BaseObject kTarget) 
{
	local XComGameState_Unit UnitState;
	
	UnitState = XComGameState_Unit(kTarget);
	
	if (UnitState == none)
		return 'AA_NotAUnit';

	if (UnitState.GetMyTemplateName() == 'AdvTrooperMP')
		return 'AA_Success';  
	if (UnitState.GetMyTemplateName() == 'AdvCaptainMP')
		return 'AA_Success';  
	if (UnitState.GetMyTemplateName() == 'AdvPurifierMP')
		return 'AA_Success';  
	if (UnitState.GetMyTemplateName() == 'AdvStunLancerMP')
		return 'AA_Success';  
	if (UnitState.GetMyTemplateName() == 'AdvShieldBearerMP')
		return 'AA_Success';  
	if (UnitState.GetMyTemplateName() == 'AdvGeneralMP')
		return 'AA_Success';  
	return 'AA_UnitIsWrongType';
	
}
