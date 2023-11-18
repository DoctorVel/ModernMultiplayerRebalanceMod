class AHW_Effect_ElderReflect extends X2Effect_Persistent config(GameData_SoldierSkills);

var config int AHWElderDeflectChance;

function bool ChangeHitResultForTarget(XComGameState_Effect EffectState, XComGameState_Unit Attacker, XComGameState_Unit TargetUnit, XComGameState_Ability AbilityState, bool bIsPrimaryTarget, const EAbilityHitResult CurrentResult, out EAbilityHitResult NewHitResult)
{
	local int Chance, RandRoll;
	local X2AbilityToHitCalc_StandardAim AttackToHit;
	local GameRulesCache_VisibilityInfo VisInfo;

	if(`TACTICALRULES.VisibilityMgr.GetVisibilityInfo(Attacker.ObjectID, TargetUnit.ObjectID, VisInfo))
	{
				if (VisInfo.bClearLOS && !VisInfo.bVisibleGameplay)
					return false; //is squadsight
	}

	if (!TargetUnit.IsAbleToAct())
		return false;

	//	don't change crits
	if (CurrentResult == eHit_Crit)
		return false;

	//	Do Not Reflect Reaction Fire
	AttackToHit = X2AbilityToHitCalc_StandardAim(AbilityState.GetMyTemplate().AbilityToHitCalc);
	if (AttackToHit != none && AttackToHit.bReactionFire)
		return false;

	//	Always Return Fire on a Natural Miss.
	if (!class'XComGameStateContext_Ability'.static.IsHitResultHit(CurrentResult))
		{
			`log("AHW Ethereal - Elder Attacks In Response to missed shot!", , 'XCom_HitRolls');
			NewHitResult = eHit_Reflect;
			return true;
		}

	if (!TargetUnit.IsAbleToAct())
		return false;

	//	Check All Non-AOE Non-Melee abilities
	if (AttackToHit != none && !AbilityState.IsMeleeAbility() && bIsPrimaryTarget)
	{
		
		Chance = (default.AHWElderDeflectChance );
		RandRoll = `SYNC_RAND(100);
		if (RandRoll <= Chance)
		{
			`log("Reflect chance was" @ Chance @ "rolled" @ RandRoll @ "- success!", , 'XCom_HitRolls');
			NewHitResult = eHit_Deflect;
			return true;
		}
		`log("Reflect chance was" @ Chance @ "rolled" @ RandRoll @ "- failed. Cannot Deflect.", , 'XCom_HitRolls');
		return false;
	}
	else
	{
		`log("Ability is an AOE attack - cannot be Deflected.", , 'XCom_HitRolls');
	}

	return false;
}

DefaultProperties
{
	DuplicateResponse = eDupe_Ignore
	EffectName = "ElderReflect"
}