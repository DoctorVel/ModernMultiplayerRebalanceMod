class X2Effect_EtheralGhost extends X2Effect_Persistent;

static private function EtheralGhostRemoved_BuildVisualization(XComGameState VisualizeGameState, out VisualizationActionMetadata ActionMetadata, const name EffectApplyResult)
{	
	local X2Action_PlayEffect EffectAction;
	
	EffectAction = X2Action_PlayEffect(class'X2Action_PlayEffect'.static.AddToVisualizationTree(ActionMetadata, VisualizeGameState.GetContext(), false, ActionMetadata.LastActionAdded));
	EffectAction.EffectName = "FX_Avatar.P_Avatar_Ethereal_Ghost_Death";
	EffectAction.AttachToSocketName = 'CIN_Root';
	EffectAction.AttachToUnit = true;
	EffectAction.AttachToSocketsArrayName = 'BoneSocketActor';
}

defaultproperties
{
	DuplicateResponse = eDupe_Ignore
	bRemoveWhenTargetDies = true
	
	VFXTemplateName = "FX_Avatar.P_Avatar_Ethereal_Ghost"
	VFXSocket = "CIN_Root"
	VFXSocketsArrayName = "BoneSocketActor" 
	
}
