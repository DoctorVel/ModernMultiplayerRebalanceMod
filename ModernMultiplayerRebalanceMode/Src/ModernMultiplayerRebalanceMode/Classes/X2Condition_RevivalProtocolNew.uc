class X2Condition_RevivalProtocolNew extends X2Condition_RevivalProtocol;

event name CallMeetsCondition(XComGameState_BaseObject kTarget)
{
	local XComGameState_Unit TargetUnit;

	TargetUnit = XComGameState_Unit(kTarget);
	if (TargetUnit == none)
		return 'AA_NotAUnit';

	if (TargetUnit.IsPanicked() || TargetUnit.IsUnconscious() || TargetUnit.IsDisoriented() || TargetUnit.IsDazed())
		return 'AA_Success';

	return 'AA_UnitIsNotImpaired';
}

event name CallMeetsConditionWithSource(XComGameState_BaseObject kTarget, XComGameState_BaseObject kSource)
{
	local XComGameState_Unit SourceUnit, TargetUnit;

	SourceUnit = XComGameState_Unit(kSource);
	TargetUnit = XComGameState_Unit(kTarget);

	if (SourceUnit == none || TargetUnit == none)
		return 'AA_NotAUnit';

	if (SourceUnit.ControllingPlayer == TargetUnit.ControllingPlayer)
		return 'AA_Success';

	return 'AA_UnitIsHostile';
}