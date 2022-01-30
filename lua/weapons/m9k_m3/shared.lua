if SERVER then
   resource.AddFile("materials/vgui/ttt/m3.png")
end

SWEP.Gun                    = ("m9k_m3")
SWEP.Category				= "M9K Shotguns"
SWEP.Author				    = ""
SWEP.Contact				= ""
SWEP.Purpose				= ""
SWEP.Instructions			= ""
SWEP.MuzzleAttachment		= "1" 	
SWEP.ShellEjectAttachment   = "2" 	
SWEP.PrintName				= "Benelli M3"		
SWEP.Slot				    = 2				
SWEP.SlotPos				= 3			
SWEP.DrawAmmo				= true		
SWEP.DrawWeaponInfoBox		= false		
SWEP.BounceWeaponIcon   	= false	
SWEP.DrawCrosshair			= false		
SWEP.Weight				    = 30			
SWEP.AutoSwitchTo			= true	
SWEP.AutoSwitchFrom			= true		
SWEP.HoldType 				= "shotgun"	

SWEP.ViewModelFOV			= 70
SWEP.ViewModelFlip			= true
SWEP.ViewModel				= "models/weapons/v_benelli_m3_s90.mdl"	
SWEP.WorldModel				= "models/weapons/w_benelli_m3.mdl"	
SWEP.Icon                   = "materials/vgui/ttt/m3.png"
SWEP.Base 				    = "weapon_tttbase"
SWEP.Spawnable				= true
SWEP.AdminSpawnable			= true
SWEP.AutoSpawnable          = true

SWEP.Kind     = WEAPON_HEAVY
SWEP.WeaponID = AMMO_SHOTGUN

SWEP.Primary.Sound			= Sound("BenelliM3.Single")		
SWEP.Primary.RPM			= 70		
SWEP.Primary.ClipSize		= 8			
SWEP.Primary.DefaultClip	= 8
SWEP.Primary.ClipMax        = 24

SWEP.Primary.Delay = 0.7
SWEP.Primary.Cone = 0.07

SWEP.Primary.KickUp				= 0.8			
SWEP.Primary.KickDown			= 0.5		
SWEP.Primary.KickHorizontal		= 0.3	
SWEP.Primary.Automatic			= false		
SWEP.Primary.Ammo			    = "buckshot"
SWEP.AmmoEnt                    = "item_box_buckshot_ttt"	

SWEP.Secondary.IronFOV			= 60		
SWEP.data 				        = {}				
SWEP.data.ironsights			= 1
SWEP.ShellTime			        = .45

SWEP.Primary.NumShots	  = 8		
SWEP.Primary.Damage		  = 11	
SWEP.Primary.Spread		  = .0326	
SWEP.Primary.IronAccuracy = .0326	

SWEP.IronSightsPos = Vector(2.279, -1.007, 1.302)
SWEP.IronSightsAng = Vector(0.47, -0.024, 0)
SWEP.SightsPos     = Vector(2.279, -1.007, 1.302)
SWEP.SightsAng     = Vector(0.47, -0.024, 0)
SWEP.RunSightsPos  = Vector(-7.639, -7.796, 0.865)
SWEP.RunSightsAng  = Vector(-17.362, -69.724, 0)

SWEP.reloadtimer = 0

function SWEP:SetupDataTables()
   self:DTVar("Bool", 0, "reloading")

   return self.BaseClass.SetupDataTables(self)
end

function SWEP:Reload()
   self:SetIronsights( false )
   
   if self.dt.reloading then return end

   if not IsFirstTimePredicted() then return end
   
   if self.Weapon:Clip1() < self.Primary.ClipSize and self.Owner:GetAmmoCount( self.Primary.Ammo ) > 0 then
      
      if self:StartReload() then
         return
      end
   end

end

function SWEP:StartReload()
   if self.dt.reloading then
      return false
   end

   if not IsFirstTimePredicted() then return false end

   self.Weapon:SetNextPrimaryFire( CurTime() + self.Primary.Delay )
   
   local ply = self.Owner
   
   if not ply or ply:GetAmmoCount(self.Primary.Ammo) <= 0 then 
      return false
   end

   local wep = self.Weapon
   
   if wep:Clip1() >= self.Primary.ClipSize then 
      return false 
   end

   wep:SendWeaponAnim(ACT_SHOTGUN_RELOAD_START)

   self.reloadtimer =  CurTime() + wep:SequenceDuration()

   self.dt.reloading = true

   return true
end

function SWEP:PerformReload()
   local ply = self.Owner
   
   self.Weapon:SetNextPrimaryFire( CurTime() + self.Primary.Delay )

   if not ply or ply:GetAmmoCount(self.Primary.Ammo) <= 0 then return end

   local wep = self.Weapon

   if wep:Clip1() >= self.Primary.ClipSize then return end

   self.Owner:RemoveAmmo( 1, self.Primary.Ammo, false )
   self.Weapon:SetClip1( self.Weapon:Clip1() + 1 )

   wep:SendWeaponAnim(ACT_VM_RELOAD)

   self.reloadtimer = CurTime() + wep:SequenceDuration()
end

function SWEP:FinishReload()
   self.dt.reloading = false
   self.Weapon:SendWeaponAnim(ACT_SHOTGUN_RELOAD_FINISH)
   
   self.reloadtimer = CurTime() + self.Weapon:SequenceDuration()
end

function SWEP:CanPrimaryAttack()
   if self.Weapon:Clip1() <= 0 then
      self:EmitSound( "Weapon_Shotgun.Empty" )
      self:SetNextPrimaryFire( CurTime() + self.Primary.Delay )
      return false
   end
   return true
end

function SWEP:Think()
   if self.dt.reloading and IsFirstTimePredicted() then
      if self.Owner:KeyDown(IN_ATTACK) then
         self:FinishReload()
         return
      end
      
      if self.reloadtimer <= CurTime() then

         if self.Owner:GetAmmoCount(self.Primary.Ammo) <= 0 then
            self:FinishReload()
         elseif self.Weapon:Clip1() < self.Primary.ClipSize then
            self:PerformReload()
         else
            self:FinishReload()
         end
         return            
      end
   end
end

function SWEP:Deploy()
   self.dt.reloading = false
   self.reloadtimer = 0
   return self.BaseClass.Deploy(self)
end

function SWEP:GetHeadshotMultiplier(victim, dmginfo)
   local att = dmginfo:GetAttacker()
   if not IsValid(att) then return 3 end

   local dist = victim:GetPos():Distance(att:GetPos())
   local d = math.max(0, dist - 140)
   
   return 1 + math.max(0, (2.1 - 0.002 * (d ^ 1.25)))
end
