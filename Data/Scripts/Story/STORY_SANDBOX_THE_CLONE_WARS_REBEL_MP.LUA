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
-- Original Author: Small_Pox
-- 			Author: Anakin_Sklavenwalker
--
--/////////////////////////////////////////////////////////////////////////////////////////////////
require("PGStateMachine")
require("PGStoryMode")

function Definitions()
	DebugMessage("%s -- In Definitions", tostring(Script))
   	StoryModeEvents = { 
	Universal_Story_Start1 = Universal_Story_Start1,
	Rebels_Enter_Tech_01 = Rebels_Enter_Tech_01,
	Rebels_Enter_Tech_02 = Rebels_Enter_Tech_02,
	Rebels_Enter_Tech_03 = Rebels_Enter_Tech_03,
	Rebels_Enter_Tech_04 = Rebels_Enter_Tech_04
	}
	
	definition = true
	
end

function Story_Mode_Service()
			
	if definition then
		cis = Find_Player("Rebel")
		full_planet_list = FindPlanet.Get_All_Planets()
		definition = false
	end

	num_cis_planet_count = 0
	for k, planet in pairs(full_planet_list) do
		if planet.Get_Owner() == cis then 
			num_cis_planet_count = num_cis_planet_count + 1
		end
	end

	if num_cis_planet_count == table.getn(full_planet_list) then
		Story_Event("Win_Event_Start")
		ScriptExit()
	end
	
	if num_cis_planet_count == 0 then
		Story_Event("Lose_GC")
		ScriptExit()
	end
end

function Universal_Story_Start1(message)
	if message == OnEnter then
		rebel_player = Find_Player("Rebel")
		rebel_player.Enable_Advisor_Hints("Space",false)
		rebel_player.Enable_Advisor_Hints("Land",false)
		rebel_player.Enable_Advisor_Hints("Galactic",false)
	end
end

function Rebels_Enter_Tech_01(message)
	if message == OnEnter then
		unit2 = {"Jango_Fett_Team", "Mar_Tuuk"}
		SpawnList(unit2 , FindPlanet("Geonosis"), Find_Player("Rebel"), false, false)
	end
end

function Rebels_Enter_Tech_02(message)
	if message == OnEnter then
		unit3 = {"Asajj_Ventress_Team", "Aurra_Sing_Team", "Kalani_Team", "Cydon_Prax_Team"}
		SpawnList(unit3 , FindPlanet("Geonosis"), Find_Player("Rebel"), false, false)
	end
end

function Rebels_Enter_Tech_03(message)
	if message == OnEnter then
		unit4 = {"Durge_Team", "General_Grievous_Team", "Admiral_Trench"}
		SpawnList(unit4 , FindPlanet("Geonosis"), Find_Player("Rebel"), false, false)
	end
end

function Rebels_Enter_Tech_04(message)
	if message == OnEnter then
		unit5 = {"Cad_Bane_Team", "Bossk_Team"}
		SpawnList(unit5 , FindPlanet("Geonosis"), Find_Player("Rebel"), false, false)
	end
end
