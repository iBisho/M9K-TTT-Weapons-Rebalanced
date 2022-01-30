if SERVER then
   resource.AddFile("materials/vgui/ttt/7615.png")
end

SWEP.Gun                    = ("m9k_remington7615p")
SWEP.Category				= "M9K Sniper Rifles"
SWEP.Author				    = ""
SWEP.Contact				= ""
SWEP.Purpose				= ""
SWEP.Instructions			= ""
SWEP.MuzzleAttachment		= "1" 	
SWEP.ShellEjectAttachment	= "2" 	
SWEP.PrintName				= "Remington 7615P"		
SWEP.Slot				    = 2				
SWEP.SlotPos				= 3			
SWEP.DrawAmmo				= true		
SWEP.DrawWeaponInfoBox		= false		
SWEP.BounceWeaponIcon   	= false	
SWEP.DrawCrosshair			= false		
SWEP.XHair					= false		
SWEP.Weight				    = 50			
SWEP.AutoSwitchTo			= true		
SWEP.AutoSwitchFrom			= false		
SWEP.BoltAction				= true		
SWEP.HoldType 				= "ar2"		

SWEP.ViewModelFOV			= 54
SWEP.ViewModelFlip			= true
SWEP.ViewModel				= "models/weapons/v_remington_7615p.mdl"	
SWEP.WorldModel				= "models/weapons/w_remington_7615p.mdl"	
SWEP.Icon                   = "materials/vgui/ttt/7615.png"
SWEP.Base 				    = "weapon_tttbase"
SWEP.Spawnable				= true
SWEP.AdminSpawnable			= true
SWEP.AutoSpawnable          = true

SWEP.Kind     = WEAPON_HEAVY
SWEP.WeaponID = AMMO_SHOTGUN

SWEP.Primary.Sound			= Sound("7615p_remington.Single")		
SWEP.Primary.RPM		    = 50	
SWEP.Primary.ClipSize		= 4		
SWEP.Primary.DefaultClip	= 4	
SWEP.Primary.ClipMax        = 12

SWEP.Primary.Delay          = 1.4
SWEP.Primary.Cone           = 0.05

SWEP.Primary.KickUp			= 1				
SWEP.Primary.KickDown		= 1			
SWEP.Primary.KickHorizontal	= 1	
SWEP.Primary.Automatic		= false		
SWEP.Primary.Ammo			= "Buckshot"
SWEP.AmmoEnt                = "item_box_buckshot_ttt"	

SWEP.Secondary.ScopeZoom		= 7	
SWEP.Secondary.UseACOG			= false 
SWEP.Secondary.UseMilDot		= true		
SWEP.Secondary.UseSVD			= false	
SWEP.Secondary.UseParabolic		= false	
SWEP.Secondary.UseElcan			= false
SWEP.Secondary.UseGreenDuplex	= false	
SWEP.Secondary.UseAimpoint		= false
SWEP.Secondary.UseMatador		= false

SWEP.data 				    = {}
SWEP.data.ironsights		= 1
SWEP.ScopeScale 			= 0.7
SWEP.ReticleScale 			= 0.6

SWEP.Secondary.Sound      = Sound("Default.Zoom")
SWEP.Primary.NumShots	  = 18		
SWEP.Primary.Damage		  = 5	
SWEP.Primary.Spread		  = .01	
SWEP.Primary.IronAccuracy = .001

SWEP.IronSightsPos      = Vector( 5, -15, -2 )
SWEP.IronSightsAng      = Vector( 2.6, 1.37, 3.5 )
--SWEP.IronSightsPos = Vector(3.079, -1.333, -3)
--SWEP.IronSightsAng = Vector(0, 0, 0)
--SWEP.SightsPos = Vector(3.079, -1.333, 0.437)
--SWEP.SightsAng = Vector(0, 0, 0)
--SWEP.RunSightsPos = Vector (-2.3095, -3.0514, 2.3965)
--SWEP.RunSightsAng = Vector (-19.8471, -33.9181, 10)

function SWEP:SetZoom(state)
    if CLIENT then 
       return
    elseif IsValid(self.Owner) and self.Owner:IsPlayer() then
       if state then
          self.Owner:SetFOV(20, 0.3)
       else
          self.Owner:SetFOV(0, 0.2)
       end
    end
end

function SWEP:SecondaryAttack()
    if not self.IronSightsPos then return end
    if self.Weapon:GetNextSecondaryFire() > CurTime() then return end
    
    bIronsights = not self:GetIronsights()
    
    self:SetIronsights( bIronsights )
    
    if SERVER then
        self:SetZoom(bIronsights)
     else
        self:EmitSound(self.Secondary.Sound)
    end
    
    self.Weapon:SetNextSecondaryFire( CurTime() + 0.3)
end

function SWEP:PreDrop()
    self:SetZoom(false)
    self:SetIronsights(false)
    return self.BaseClass.PreDrop(self)
end

function SWEP:Reload()
    self.Weapon:DefaultReload( ACT_VM_RELOAD );
    self:SetIronsights( false )
    self:SetZoom(false)
end


function SWEP:Holster()
    self:SetIronsights(false)
    self:SetZoom(false)
    return true
end

if CLIENT then
   local scope = surface.GetTextureID("sprites/scope")
   function SWEP:DrawHUD()
      if self:GetIronsights() then
         surface.SetDrawColor( 0, 0, 0, 255 )
         
         local x = ScrW() / 2.0
         local y = ScrH() / 2.0
         local scope_size = ScrH()

         local gap = 80
         local length = scope_size
         surface.DrawLine( x - length, y, x - gap, y )
         surface.DrawLine( x + length, y, x + gap, y )
         surface.DrawLine( x, y - length, x, y - gap )
         surface.DrawLine( x, y + length, x, y + gap )

         gap = 0
         length = 50
         surface.DrawLine( x - length, y, x - gap, y )
         surface.DrawLine( x + length, y, x + gap, y )
         surface.DrawLine( x, y - length, x, y - gap )
         surface.DrawLine( x, y + length, x, y + gap )

         local sh = scope_size / 2
         local w = (x - sh) + 2
         surface.DrawRect(0, 0, w, scope_size)
         surface.DrawRect(x + sh - 2, 0, w, scope_size)

         surface.SetDrawColor(255, 0, 0, 255)
         surface.DrawLine(x, y, x + 1, y + 1)

         -- scope
         surface.SetTexture(scope)
         surface.SetDrawColor(255, 255, 255, 255)

         surface.DrawTexturedRectRotated(x, y, scope_size, scope_size, 0)

      else
         return self.BaseClass.DrawHUD(self)
      end
   end

   function SWEP:AdjustMouseSensitivity()
      return (self:GetIronsights() and 0.2) or nil
   end
end