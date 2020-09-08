-- Planet Counter
--/////////////////////////////////////////////////////////////////////////////////////////////////
--
-- (C) Republic at War.
--
--
--  8888888b.                            888      888 d8b               
--	888   Y88b                           888      888 Y8P               
--	888    888                           888      888                   
--	888   d88P .d88b.  88888b.  888  888 88888b.  888 888  .d8888b      
--	8888888P" d8P  Y8b 888 "88b 888  888 888 "88b 888 888 d88P"         
--	888 T88b  88888888 888  888 888  888 888  888 888 888 888           
--	888  T88b Y8b.     888 d88P Y88b 888 888 d88P 888 888 Y88b.         
--	888   T88b "Y8888  88888P"   "Y88888 88888P"  888 888  "Y8888P      
--	                   888                                              
--	                   888                                              
--	                   888                                              
--
--
--	         888    
--	         888    
--	         888    
--	 8888b.  888888 
--	    "88b 888    
--	.d888888 888    
--	888  888 Y88b.  
--	"Y888888  "Y888 
--
--
--
--     
--	888       888                  
--	888   o   888                  
--	888  d8b  888                  
--	888 d888b 888  8888b.  888d888 
--	888d88888b888     "88b 888P"   
--	88888P Y88888 .d888888 888     
--	8888P   Y8888 888  888 888     
--	888P     Y888 "Y888888 888     
--
-- Original Author: Small_Pox, Anakin_Sklavenwalker
-- 			Author: Nojembre
--
--/////////////////////////////////////////////////////////////////////////////////////////////////
require("PGStateMachine")
require("PGStoryMode")

function Definitions()
	DebugMessage("%s -- In Definitions", tostring(Script))
   	StoryModeEvents = 
	{
		Universal_Story_Start = Universal_Story_Start
	}
	
	definition = true
	
end

function Story_Mode_Service()
			
	if definition then
		shadow_collective = Find_Player("Shadow_Collective")
		full_planet_list = FindPlanet.Get_All_Planets()
		definition = false
	end

	num_shadow_collective_planet_count = 0
	for k, planet in pairs(full_planet_list) do
		if planet.Get_Owner() == shadow_collective then 
			num_shadow_collective_planet_count = num_shadow_collective_planet_count + 1
		end
	end

	if num_shadow_collective_planet_count == table.getn(full_planet_list) then
		Story_Event("Win_Event_Start")
		ScriptExit()
	end
	
	if num_shadow_collective_planet_count == 0 then
		Story_Event("Lose_GC")
		ScriptExit()
	end
end

function Universal_Story_Start(message)
	if message == OnEnter then
		shadow_collective_player = Find_Player("shadow_collective")
		shadow_collective_player.Enable_Advisor_Hints("Space",false)
		shadow_collective_player.Enable_Advisor_Hints("Land",false)
		shadow_collective_player.Enable_Advisor_Hints("Galactic",false)
	end
end