/*
Scanning Best Practices:

For LOADING  : basically a bool - 0 in game and 1 on loading screen. 
When scanning, make sure to look for interior loads, checkpoint loads, fast travel loads. Should be around 7A/7B
*/

state("MilesMorales", "Steam v1.1122")
{
    int loading      : 0x7A29E84; 
    uint objective   : 0x701DE44; // not made yet
}
state("MilesMorales", "Steam v1.1130")
{
    int loading      : 0x7A2AFC4; 
    uint objective   : 0x701DE44; // not made yet
}

init
{
    vars.loading = false;

    switch (modules.First().ModuleMemorySize) 
    {
        case 150925312: 
            version = "Steam v1.1122";
            break;
        case 150929408: 
            version = "Steam v1.1130";
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
//print(current.loading.ToString()); 
//print(current.objective.ToString());

        //Use cases for each version of the game listed in the State method
		switch (version) 
	{
		case "Steam v1.1122": case "Steam v1.1130":
			vars.loading = current.loading == 1;
			break;
	}

}

/*
start
{
	return (old.objective == 0 && current.objective == 648768089);
}
*/

isLoading
{
    return vars.loading;
}

exit
{
	timer.IsGameTimePaused = true;
}
