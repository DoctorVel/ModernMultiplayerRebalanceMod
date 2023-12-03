class X2Condition_WOTCAdventRestore extends X2Condition;

event name CallMeetsCondition(XComGameState_BaseObject kTarget)
{

	local XComGameState_Unit TargetUnit;

	TargetUnit = XComGameState_Unit(kTarget);
	if (TargetUnit == none)
		return 'AA_NotAUnit';

	if (TargetUnit.IsRobotic() || TargetUnit.IsBeingCarried() )
		return 'AA_UnitIsImmune';

	if (TargetUnit.IsPanicked() || TargetUnit.IsUnconscious() || TargetUnit.IsDazed() || TargetUnit.IsStunned() )
		return 'AA_Success';

	return 'AA_UnitIsNotImpaired';
}

event name CallMeetsConditionWithSource(XComGameState_BaseObject kTarget, XComGameState_BaseObject kSource)
{
	local XComGameState_Unit SourceUnit, TargetUnit;
	local XComWorldData WorldData;
	local vector SourcePos, TargetPos;
	local float Distance;

	SourceUnit = XComGameState_Unit(kSource);
	TargetUnit = XComGameState_Unit(kTarget);

	WorldData = `XWORLD;
	SourcePos = WorldData.GetPositionFromTileCoordinates(SourceUnit.TileLocation);
	TargetPos = WorldData.GetPositionFromTileCoordinates(TargetUnit.TileLocation);
	Distance = VSize(TargetPos - SourcePos);
	if (Distance >= 144)
		return 'AA_NotInRange';

	if (SourceUnit == none || TargetUnit == none)
		return 'AA_NotAUnit';

	if (SourceUnit.IsFriendlyUnit(TargetUnit))
		return 'AA_Success';

	return 'AA_UnitIsHostile';
}