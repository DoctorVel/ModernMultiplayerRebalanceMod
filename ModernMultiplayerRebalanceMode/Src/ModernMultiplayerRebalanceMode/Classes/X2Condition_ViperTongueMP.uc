class X2Condition_ViperTongueMP extends X2Condition;

var protected X2Condition_UnitProperty UnitPropertyCondition;
var protected X2Condition_UnitProperty UnitPropertyConditionAdvanced;

event name CallMeetsCondition(XComGameState_BaseObject kTarget) 
{
	return UnitPropertyCondition.MeetsCondition(kTarget); 
}

event name CallMeetsConditionWithSource(XComGameState_BaseObject kTarget, XComGameState_BaseObject kSource) 
{ 
	local XComGameState_Unit SourceUnit;
	
	SourceUnit = XComGameState_Unit(kSource);
	
	if (SourceUnit != none && SourceUnit.GetMyTemplateName() == 'ViperKingMP' || SourceUnit.GetMyTemplateName() == 'ViperNeonateMP')
	{
		return UnitPropertyConditionAdvanced.MeetsConditionWithSource(kTarget, kSource); 
	}
	
	return UnitPropertyCondition.MeetsConditionWithSource(kTarget, kSource); 
}

defaultproperties
{
    Begin Object Class=X2Condition_UnitProperty Name=DefaultUnitPropertyCondition
		ExcludeDead = true
		ExcludeRobotic = true
		ExcludeAlien = true;
		ExcludeFriendlyToSource = true
		RequireWithinMinRange = true
		RequireWithinRange = true
		// 	3 tiles in units
		WithinMinRange = 288
		// 12 tiles in units
		WithinRange = 1152
    End Object
    UnitPropertyCondition = DefaultUnitPropertyCondition;

	Begin Object Class=X2Condition_UnitProperty Name=DefaultUnitPropertyConditionAdvanced
		ExcludeDead = true
		ExcludeRobotic = true
		ExcludeAlien = true;
		ExcludeFriendlyToSource = true
		RequireWithinMinRange = true
		RequireWithinRange = true
		// 	3 tiles in units
		WithinMinRange = 288
		// 12 tiles in units
		WithinRange = 1536
    End Object
    UnitPropertyConditionAdvanced = DefaultUnitPropertyConditionAdvanced;
}
