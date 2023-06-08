/*
Scanning Best Practices:

For LOADING  : basically a bool - 0 in game and 1 on loading screen. 
When scanning, make sure to look for interior loads, checkpoint loads, fast travel loads. Should be around 7A/7B
*/

state("MilesMorales", "Steam v1.1122")
{
    bool loading      : 0x7A29E84; 
    uint objective   : 0x701DE44; // not made yet
}
state("MilesMorales", "Steam v1.1130")
{
    bool loading      : 0x7A2AFC4; 
}
state("MilesMorales", "Steam v2.209")
{
    bool loading      : 0x7A2C004; 
}
state("MilesMorales", "Steam v2.516")
{
    bool loading      : 0x7A2F124; 
}

init
{
    switch (modules.First().ModuleMemorySize) 
    {
        case 150925312: 
            version = "Steam v1.1122";
            break;
        case 150929408: 
            version = "Steam v1.1130";
            break;
        case 150937600: 
            version = "Steam v2.209";
            break;   
        case 151015424:
            version = "Steam v2.516";
            break; 
    default:
        print("Unknown version detected");
        return false;
    }
}

startup
  {
		if (timer.CurrentTimingMethod == TimingMethod.RealTime)
// Asks user to change to game time if LiveSplit is currently set to Real Time.
    {        
        var timingMessage = MessageBox.Show (
            "This game uses Time without Loads (Game Time) as the main timing method.\n"+
            "LiveSplit is currently set to show Real Time (RTA).\n"+
            "Would you like to set the timing method to Game Time?",
            "LiveSplit | Marvel's Spider-Man: Miles Morales",
            MessageBoxButtons.YesNo,MessageBoxIcon.Question
        );
        
        if (timingMessage == DialogResult.Yes)
        {
            timer.CurrentTimingMethod = TimingMethod.GameTime;
        }
    }
}

onStart
{
    // This makes sure the timer always starts at 0.00
    timer.IsGameTimePaused = true;
}

update
{
//DEBUG CODE 
//print(modules.First().ModuleMemorySize.ToString());
//print(current.loading.ToString()); 
//print(current.objective.ToString());
}

/*
start
{
	return (old.objective == 0 && current.objective == 648768089);
}
*/

isLoading
{
    return current.loading;
}

exit
{
	timer.IsGameTimePaused = true;
}
