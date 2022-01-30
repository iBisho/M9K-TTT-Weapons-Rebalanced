if SERVER then
   resource.AddFile("materials/vgui/ttt/ak74.png")
end

SWEP.Gun                        = ("m9k_ak74") 
SWEP.Category				    = "M9K Assault Rifles"
SWEP.Author				        = ""
SWEP.Contact				    = ""
SWEP.Purpose				    = ""
SWEP.Instructions				= ""
SWEP.MuzzleAttachment			= "1" 	
SWEP.ShellEjectAttachment       = "2" 	
SWEP.PrintName				    = "AK-74"	
SWEP.Slot				        = 2				
SWEP.SlotPos				    = 4			
SWEP.DrawAmmo				    = true		
SWEP.DrawWeaponInfoBox			= false		
SWEP.BounceWeaponIcon   		= false	
SWEP.DrawCrosshair			    = false		
SWEP.Weight				        = 30			
SWEP.AutoSwitchTo			    = true		
SWEP.AutoSwitchFrom			    = true		
SWEP.HoldType 				    = "ar2"		

SWEP.ViewModelFOV			    = 65
SWEP.ViewModelFlip			    = true
SWEP.ViewModel				    = "models/weapons/v_tct_ak47.mdl"	
SWEP.WorldModel				    = "models/weapons/w_tct_ak47.mdl"
SWEP.Icon                       = "materials/vgui/ttt/ak74.png"
SWEP.Base				        = "weapon_tttbase"
SWEP.Spawnable				    = true
SWEP.AdminSpawnable			    = true
SWEP.AutoSpawnable              = true

SWEP.Kind                       = WEAPON_HEAVY
SWEP.WeaponID                   = AMMO_MAC10

SWEP.Primary.Sound			    = Sound("Tactic_AK47.Single")		
SWEP.Primary.RPM			    = 635			
SWEP.Primary.ClipSize		    = 30		
SWEP.Primary.DefaultClip		= 30		
SWEP.Primary.ClipMax            = 60

SWEP.Primary.Delay              = 0.15
SWEP.Primary.Cone               = 0.018

SWEP.Primary.KickUp				= 0.4		
SWEP.Primary.KickDown			= 0.4		
SWEP.Primary.KickHorizontal		= 0.4		
SWEP.Primary.Automatic			= true		
SWEP.Primary.Ammo			    = "smg1"
SWEP.AmmoEnt                    = "item_ammo_smg1_ttt"	
SWEP.FiresUnderwater            = true
SWEP.Secondary.IronFOV	 		= 55		
SWEP.data 				        = {}				
SWEP.data.ironsights			= 1

SWEP.Primary.NumShots	        = 1		
SWEP.Primary.Damage		        = 21
SWEP.HeadshotMultiplier       = 2.75
SWEP.Primary.Spread		        = .02	
SWEP.Primary.IronAccuracy       = .01 


SWEP.IronSightsPos              = Vector (2.0378, -3.8941, 0.8809)
SWEP.IronSightsAng              = Vector (0, 0, 0)
SWEP.SightsPos                  = Vector (2.0378, -3.8941, 0.8809)
SWEP.SightsAng                  = Vector (0, 0, 0)
SWEP.RunSightsPos               = Vector (-2.3095, -3.0514, 2.3965)
SWEP.RunSightsAng               = Vector (-19.8471, -33.9181, 10)