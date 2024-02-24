class X2Condition_KillZombies extends X2Condition;

event name CallMeetsCondition(XComGameState_BaseObject kTarget) 
{
	local XComGameState_Unit UnitState;
	
	UnitState = XComGameState_Unit(kTarget);
	
	if (UnitState == none)
		return 'AA_NotAUnit';

	if (UnitState.GetMyTemplateName() == 'SpectralZombieM2')
		return 'AA_Success';  
	if (UnitState.GetMyTemplateName() == 'PsiZombie')
		return 'AA_Success'; 
	if (UnitState.GetMyTemplateName() == 'SpectralStunLancerM2')
		return 'AA_Success'; 
	if (UnitState.GetMyTemplateName() == 'PsiZombieMP')
		return 'AA_Success'; 
	if (UnitState.GetMyTemplateName() == 'PsiZombieHumanMP')
		return 'AA_Success'; 

	return 'AA_UnitIsWrongType';
	
}
