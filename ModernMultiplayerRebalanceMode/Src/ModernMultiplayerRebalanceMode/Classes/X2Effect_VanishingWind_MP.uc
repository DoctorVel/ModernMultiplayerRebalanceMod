class X2Effect_VanishingWind_MP extends X2Effect_RangerStealth;
/*
simulated function AddX2ActionsForVisualization_Removed(XComGameState VisualizeGameState, out VisualizationActionMetadata BuildTrack, const name EffectApplyResult, XComGameState_Effect RemovedEffect)
{
	local XComGameStateContext_Ability		Context;
	//local XComGameStateVisualizationMgr		VisualizationMgr;
	//local X2Action_ExitCover				ExitCoverAction;
	//local X2Action_MoveDirect				MoveDirectAction;
	//local X2Action_ForceUnitVisiblity		ShowUnitAction;
	local X2Action_PlayAdditiveAnim			PlayAdditiveAnim;
	local name								AdditiveAnimName;
	//local X2Action_HideUIUnitFlag			HideUIFlagAction;
	//local array<X2Action>					FoundNodes;
	//local X2Action							BuildTreeStartNode;
	//local X2Action							FireAction;
	
	//local X2Action_ForceUnitVisiblity		ForceVisiblityAction;
	//local X2Action_PlayAnimation			PlayAnim;
	//local XComGameState_Unit				TestUnit;

	Context = XComGameStateContext_Ability(VisualizeGameState.GetContext());

	if (Context.InputContext.AbilityTemplateName == 'PartingSilk')
	{
		//VisualizationMgr = `XCOMVISUALIZATIONMGR;

		//BuildTreeStartNode = VisualizationMgr.GetNodeOfType(VisualizationMgr.BuildVisTree, class'X2Action_MarkerTreeInsertBegin');
		//HideUIFlagAction = X2Action_HideUIUnitFlag(class'X2Action_HideUIUnitFlag'.static.AddToVisualizationTree(BuildTrack, VisualizeGameState.GetContext(), true, BuildTreeStartNode));
		//HideUIFlagAction.bHideUIUnitFlag = true;

		if (Context.InputContext.MovementPaths.Length > 0 
			&& Context.InputContext.MovementPaths[0].MovementTiles.Length > class'X2Effect_VanishingWind'.default.PARTINGSILKREVEAL_MIN_TILE_DISTANCE)
		{
			// We have enough distance to do the reveal effect while she is moving
			AdditiveAnimName = 'ADD_MV_VanishingWindBase_Unhide';

			//VisualizationMgr.GetNodesOfType(VisualizationMgr.BuildVisTree, class'X2Action_MoveDirect', FoundNodes, BuildTrack.VisualizeActor);
			//MoveDirectAction = X2Action_MoveDirect(FoundNodes[0]);

			//ShowUnitAction = X2Action_ForceUnitVisiblity(class'X2Action_ForceUnitVisiblity'.static.AddToVisualizationTree(BuildTrack, VisualizeGameState.GetContext(), false, none, MoveDirectAction.ParentActions));
		}
		else
		{
			AdditiveAnimName = 'ADD_HL_VanishingWindBase_Unhide';

			//ExitCoverAction = X2Action_ExitCover(VisualizationMgr.GetNodeOfType(VisualizationMgr.BuildVisTree, class'X2Action_ExitCover'));
			//ShowUnitAction = X2Action_ForceUnitVisiblity(class'X2Action_ForceUnitVisiblity'.static.AddToVisualizationTree(BuildTrack, VisualizeGameState.GetContext(), true, none, ExitCoverAction.ParentActions));
		}

		//ShowUnitAction.ForcedVisible = eForceVisible;

		PlayAdditiveAnim = X2Action_PlayAdditiveAnim(class'X2Action_PlayAdditiveAnim'.static.AddToVisualizationTree(BuildTrack, Context, true, ShowUnitAction));
		PlayAdditiveAnim.AdditiveAnimParams.AnimName = AdditiveAnimName;

		//FireAction = VisualizationMgr.GetNodeOfType(VisualizationMgr.BuildVisTree, class'X2Action_Fire');
		//HideUIFlagAction = X2Action_HideUIUnitFlag(class'X2Action_HideUIUnitFlag'.static.AddToVisualizationTree(BuildTrack, VisualizeGameState.GetContext(), false, FireAction));
		//HideUIFlagAction.bHideUIUnitFlag = false;
	}
	else
	{
		//TestUnit = XComGameState_Unit(BuildTrack.StateObject_NewState);
		//if (TestUnit != none && !TestUnit.bRemovedFromPlay)
		//{
			PlayAdditiveAnim = X2Action_PlayAdditiveAnim(class'X2Action_PlayAdditiveAnim'.static.AddToVisualizationTree(BuildTrack, Context));
			PlayAdditiveAnim.AdditiveAnimParams.AnimName = 'ADD_HL_VanishingWindBase_Unhide';
		//}
	}
	
	super.AddX2ActionsForVisualization_Removed(VisualizeGameState, BuildTrack, EffectApplyResult, RemovedEffect);
}
*/
defaultproperties
{
	EffectName = "VanishingWind"
	//bBringRemoveVisualizationForward = true
	//bRemoveWhenTargetConcealmentBroken = true
}