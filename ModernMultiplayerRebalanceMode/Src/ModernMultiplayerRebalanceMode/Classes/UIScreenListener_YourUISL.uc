class UIScreenListener_YourUISL extends UIScreenListener;

event OnInit(UIScreen Screen)
{
    `LOG("Screen initialized:" @ Screen.Class.Name,, 'UISL');
}