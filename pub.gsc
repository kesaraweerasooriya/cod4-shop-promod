#include maps\mp\_utility;
#include maps\mp\gametypes\_hud_util;
#include menu\_common;

knife()
{
	self giveWeapon("knife_mp");
	self givemaxammo("knife_mp");
	self switchtoweapon( "knife_mp" );
}

tracer()
{
 if(self GetStat(2355) >= int(200))
	{
	shopstst = self GetStat(2355);
	self SetStat(2355, shopstst -int(300));
	self iprintlnbold ("You can now see the trajectory of the bullet"); 
	self setClientDvar( "cg_tracerSpeed", "300" );
	self setClientDvar( "cg_tracerwidth", "9" );
	self setClientDvar( "cg_tracerlength", "500" );
	}else
	self IprintlnBold("^1You have not enough Money");
	self.points SetValue( self GetStat(2355) );
}

fps()
{
        if(self GetStat(2355) >= int(100))
	{
		shopstst = self GetStat(2355);
		self SetStat(2355, shopstst -100);
		//self GetStat(2355) -= 100;
		self iPrintlnBold( "^5Activated FPS!!" );
        self setClientDvar("r_fullbright", "1");
	}else
	self IprintlnBold("^1You have not enough Money");
	self.points SetValue( self GetStat(2355) );
	
}

burn()
{
	self iprintlnbold ("^1Te Prendiste Fuego!!"); 
        while(isAlive(self))
	{
		playFx( level.dist , self.origin );
		wait .1;
	}
}

laser()
{
        if(self GetStat(2355) >= int(300))
	{
		shopstst = self GetStat(2355);
		self SetStat(2355, shopstst -300);
		//self GetStat(2355) -= 300;
		self iPrintlnBold( "^5Laser ON!!" );
		self setClientDvar("cg_laserForceOn", 1);
		self iPrintln( "^2laserForce On" );
    }else
	self IprintlnBold("^1You have not enough Money");
	self.points SetValue( self GetStat(2355) );
	
}


togglethird1()
{
	if( self.third == false )
	{
		self thread togglethird2();
		self SetClientDvars( "cg_thirdPerson", "1","cg_fov", "cg_drawcrosshair", "1", "115","cg_thirdPersonAngle", "354" );
		self setDepthOfField( 0, 128, 512, 4000, 6, 1.8 );
		wait 0.1;
		self.third = true;
		self iPrintlnBold( "^3Y^7ou ^3e^7nabled ^3ThirdPerson ^3m^7ode!" );
		wait 0.1;
		self BetterCrosshair1("+", 2.3, 0.3);
	}
	else
	{
		self SetClientDvars( "cg_thirdPerson", "0","cg_fov", "65","cg_thirdPersonAngle", "0" );
		self setDepthOfField( 0, 0, 512, 4000, 4, 0 );
		wait 0.1;
		self.third = false;
		self iPrintlnBold( "^3Y^7ou ^3d^7isabled ^3ThirdPerson ^3m^7ode!" );
	}
}
togglethird2()
{
	self endon ( "togglethird_stop" );
}

BetterCrosshair1(text, scale, speed)
{
    Leeches = self createfontstring("objective", scale, self);
    Leeches setpoint("CENTER");
    Leeches settext(text);
    self thread CrosshairDestroy(Leeches);
    self setclientdvar("cg_crosshairAlpha", 0);
    rand = [];
    for(;;)
	{
		for(i=0;i<=3;i++)
		{
			random = randomInt( 100 ); rand[i] = random/100;
        }
		Leeches.color = (rand[0],rand[1],rand[2]);
		wait(speed);
    }
}
CrosshairDestroy(elem)
{
    self waittill("death");
	self endon( "disconnect" );
    elem destroy();
}
