class X2Condition_EverVigilant_Override extends X2Condition_EverVigilant;

event name CallMeetsConditionWithSource(XComGameState_BaseObject kTarget, XComGameState_BaseObject kSource)
{
    return 'AA_Success';
}