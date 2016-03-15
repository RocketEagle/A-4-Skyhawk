local dev = GetSelf()

local update_time_step = 0.02  --50 time per second
make_default_activity(update_time_step)

local sensor_data = get_base_data()


local Airbrake  = 73 -- This is the number of the command from command_defs
local AirbrakeOn = 147
local AirbrakeOff = 148


--Creating local variables
local ABRAKE_COMMAND	=	0				
local ABRAKE_STATE	=	0
local ABRAKE_TARGET = 0


dev:listen_command(Airbrake)
dev:listen_command(AirbrakeOn)
dev:listen_command(AirbrakeOff)


function SetCommand(command,value)			
	
	if (command == Airbrake) then
        ABRAKE_COMMAND = 1 - ABRAKE_COMMAND
	end
	
	if (command == AirbrakeOn) then
		ABRAKE_COMMAND = 1
	end
	
	if (command == AirbrakeOff) then
		ABRAKE_COMMAND = 0
	end
end

local speedbrake_max_effective_knots = 440
local speedbrake_blowback_knots = 490
local a4_max_speed_knots = 540 -- approx, only used to calc linear speedbrake closing, and irrelevant past blowback speed anyway

function update()		
	
	if (ABRAKE_COMMAND == 0 and ABRAKE_STATE > 0) then
		ABRAKE_STATE = ABRAKE_STATE - 0.01 -- lower airbrake in increments of 0.01 (50x per second)
        if ABRAKE_STATE < 0 then
            ABRAKE_STATE = 0
        end
	else
		if (ABRAKE_COMMAND == 1) then
            local knots = sensor_data.getIndicatedAirSpeed()*1.9438444924574
            if knots > speedbrake_max_effective_knots then
                if knots > speedbrake_blowback_knots then
                    -- blowback pressure relief valve opens
                    ABRAKE_TARGET = 0
                    -- not sure whether blowback really means speedbrakes are closed fully, since
                    -- other places in NATOPS say "speedbrakes are partially effective up to maximum speed capabilities of the aircraft"
                    -- and "A blowback feature allows the speedbrakes to begin closing when the hydraulic pressure exceeds the pressure
                    -- at which the blowback relief valve opens (3650 psi), thus preventing damage to the speedbrake system. The speedbrakes
                    -- begin to blow back at approximately 490 KIAS"
                else
                    -- partially open and partially effective up to max speed of aircraft
                    -- "The speedbrakes will not open fully above 440 KIAS"
                    -- "Maximum speed for fully effective opening of speedbrakes is 440 KIAS. However, speedbrakes are
                    -- partially effective up to maximum speed capabilities of the aircraft."
                    local reduction = (knots - speedbrake_max_effective_knots) / (a4_max_speed_knots - speedbrake_max_effective_knots)  -- simplistically assume linear reduction from 440 to 540kts
                    if reduction > 1 then
                        reduction = 1
                    end
                    ABRAKE_TARGET = 1 - reduction
                end
            else
                ABRAKE_TARGET = 1
            end
            if (ABRAKE_STATE < ABRAKE_TARGET) then
                ABRAKE_STATE = ABRAKE_STATE + 0.01 -- raise airbrake in increment of 0.01 (50x per second)
                if ABRAKE_STATE > ABRAKE_TARGET then
                    ABRAKE_STATE = ABRAKE_TARGET
                end
            elseif (ABRAKE_STATE > ABRAKE_TARGET) then
                ABRAKE_STATE = ABRAKE_STATE - 0.01 -- lower airbrake in increments of 0.01 (50x per second)
                if ABRAKE_STATE < ABRAKE_TARGET then
                    ABRAKE_STATE = ABRAKE_TARGET
                end
            end
		end
	end
	
	
	set_aircraft_draw_argument_value(182,ABRAKE_STATE)
	set_aircraft_draw_argument_value(186,ABRAKE_STATE)
	
end

--need_to_be_closed = false -- close lua state after initialization

--[[
Notes from NATOPS manual:

(under banner towing procedures)
Maximum speed for speedbrake operations - 250 KIAS


pg 1-14:
Switches for the radio
microphone and speedbrakes are located on the
inboard side of the throttle grip, with the exterior
lights master switch on the outboard side

pg 1-26:
The flight control hydraulic system powers only its
half of the aileron, elevator, and rudder tandem
actuating cylinders. The utility hydraulic system, in
addition to powering one-half of the aileron, elevator,
and rudder tandem actuating cylinders, also operates
the landing gear, wing flaps, speedbrakes, arresting
hook, autopilot servos, spoilers, and nosewheel
steering. Hydraulic pressure warning lights are
provided in the cockpit for each of the two systems.

Both of the engine-driven hydraulic pumps are of the
constant pressure, variable displacement type. The
flow of fluid through each system will vary in rate
(gallons per minute) with the operating speed of the
associated pump. As rate of fluid flow determines
the speed at which the various hydraulically operated
units responded to actuation of their individual controls,
variation in rate of flow with power changes
during normal operation might ordinarily produce
objectionable characteristics in operation of the
hydraulic systems. Therefore, flow restrictors
have been installed in the subsystems to regulate the
maximum rate of flow. The flow restrictors prevent
the wing flaps, speedbrakes, and arresting hook from
operating too fast when fluid flow is at its peak, yet
do not affect the time of operation when flow is
reduced at low engine speeds. As long as the engine
is turning at IDLE rpm or greater, the hydraulically
operated units will operate against the usual loads.
However, at engine windmilling speeds, fluid flow is
greatly reduced, and the time required for hydraulically
operated units to respond fully is increased.

pg 1-28:
The elevators are interconnected with
the operation of the speedbrakes to assist the pilot in
overcoming trim changes resulting from speedbrake
operation. A system of cables and springs attached
to the left speedbrake actuates the control cables
between the stick and the elevator control valve.
When speedbrakes are opened, this system pulls the
nosedown elevator cable, moving the stick forward
and actuating the elevator to reduce a noseup pitch.
When the speedbrakes are closed, the stick moves
aft to its original trimmed position, thus reducing
nosedown pitch

pg 1-31:
Two flush-mounted speedbrakes (figure 1-4), one on
each side of the fuselage, provide deceleration during
flight. Hydraulically operated speedbrakes are electrically controlled by the speedbrakes switch on the
inboard side of the throttle grip. Movement of the
switch to either OPEN or C LOSE actuates a solenoid
valve which controls the flow of hydraulic pressure
to the speedbrake actuating cylinders. The speedbrakes cannot be stopped at intermediate positions
between fully opened and fully closed.
The SPD BRK OPEN warning light, located on the
caution panel (figures FO-1 and FO-2) comes on
whenever the speedbrakes are in any position other
than fully closed. A blowback feature allows the
speedbrakes to begin closing when the hydraulic
pressure exceeds the pressure at which the blowback relief valve opens (3650 psi), thus preventing
damage to the speedbrake system. The speedbrakes
begin to blow back at apprOXimately 490 KIAS. The
.3peedbrakes will not open fully above 440 KIAS.
Three flush-mounted JATO hooks are attached to
each speedbrake for mounting a JATO bottle for
assisted takeoffs.
NOTE
When JATO bottles are attached to the
speedbrakes, an interlock in the speedbrake electrical circuit will prevent the
speedbrakes from opening when the speedbrake is in OPEN position. Ensure that
the speedbrake switch is in the CLOSED
position prior to takeoff to prevent inadvertent opening of the speedbrakes when the
JATO bottles are jettisoned.
Speed brake -Elevator Interco nnect
A speedbrake -elevator interconnect spring minimizes aircraft pitchup during speedbrake actuation
by automatically providing nosedown elevator when
the speedbrakes are opened.

Emergency Speedbrake Control
The aircraft is equipped with an emergency speed
brake solenoid valve override control. The emer
gency speedbrake control (figures FO-1, FO-2,
FO-6, and FO-7), a push-pull knob located at the af
end of the left-hand console, can be used to open or
close the speedbrakes in the event of dc electrical
failure, or failure of one of the speedbrake control
valve solenoids. The emergency speedbrake control
knob is held in a neutral position by a spring bungee
and must be pulled up or pushed down to open or
close the speedbrakes, respectively.
In the event of electrical failure, the speedbrakes
may be opened or closed by momentary operation of
the emergency speedbrake control push-pull knob.
When JATO bottles are installed, operation
of the emergency speedbrake control will
force the JATO bottles off the aircraft
resulting in airframe damage.

pg 1-46:
condition: 250 knot descent with speedbrakes extended
angle of attack (cockpit indicator units): 7.0

pg 1-92:
A two-bottle JATO system provides the aircraft with
additional thrust during takeoff. A JATO bottle is
mounted on each speedbrake (figure 1-4). Each
bottle is capable of producing 4500 pounds of thrust
for a period of 5 seconds. The bottles are fired
electrically and jettisoned hydraulically by utility
system hydraulic pressure controlled through a
solenoid operated selector valve.

pg 1-93:
When JATO bottles are installed, operation of the emergency
speedbrake control will force the JATO bottles off the
aircraft resulting in airframe damage.
NOTE
An interlock in the speedbrake electrical
circuit prevents normal operation of speed
brakes with JATO bottles attached. Be sure
the speedbrake switch on the throttle is in
the CLOSED position prior to jettisioning the
JATO bottles; otherwise, upon release of the
JATO bottles the speedbrakes will open.

pg 3-13:
Takeoff procedures: Upon completion of the pretakeoff checklist and after
receipt of clearance from the tower, the aircraft will
line up on the runway. Each pilot should check adjacent aircraft for correct trim settings, flap position,
canopy closed, speedbrakes closed, spoilers closed,
no fuel or hydraulic leaks, and ejection seat safety
handle up. Half-flaps should be used for takeoff during normal shore-based operations. Each pilot shall
indicate his readiness for takeoff by giving a "thumbsup" up the line.

pg 3-16:
Landing: LANDING
The flight shall normally approach the breakup point
in echelon, parade formation, at 250 to 300 KIAS.
A 3- to 5-second break will provide an adequate downwind interval. Immediately after the break, extend
speedbrakes and retard throttle to 70 percent. Speedbrakes will normally remain extended throughout
approach and landing. (Speedbrakes increase the
stalling speed approximately 1 knot. )

pg 3-18:
Crosswind landing:
4. Extend speedbrakes to shorten landing roll
if not already extended.

pg 3-19:
Securing Engine
The following steps will be performed prior to
shutdown:
1. Flaps. UP
2. Speedbrakes IN
3. Spoilers ... CLOSED

Field Carrier Landing Practice (FCLP):
Reduce power to 70 percent and extend speedbrakes.
Speedbrakes will normally remain out throughout the
approach and landing. Use of speedbrakes may not
be desirable at high gross weights (in excess of
13,000 pounds) when configured with high drag stores,
i. e., buddy store, MBR's, etc, due to the high thrust
required during the approach. At 225 KIAS, lower
gear and full flaps. Adjust angle of bank to provide

pg 3-20:
LANDING
Keep the aircraft on the glide slope and centerline.
Keep the "meatball" centered until touchdown. Do not
flare. Upon touchdown, add full power and retract
speedbrakes immediately. Climb straight ahead until
reaching at least 300 feet and 150 KIAS. Turn down
wind when the aircraft ahead is approximately in the
10 0 'clock position on the downwind leg. Do not
exceed 150 KIAS in the pattern. About 30-degree
angle of bank turning downwind should establish the
correct distance abeam. Extend speedbrakes on the
downwind leg prior to reaching the 180 degree
position.
WAVEOFF
To execute a waveoff, immediately add full power,
retract speedbrakes, and transition to a climbing
attitude to prevent further loss of altitude. Make all
waveoffs directly down the runway until at least 300
feet of altitude and 150 KIAS are attained.

pg 3-22P:
(as part of airborne rate of roll check test procedure)
Deceleration should be accomplished without the use
of speedbrakes if possible. The speedbrakes are
directly connected to the elevator control and a pos
sible trim change may occur due to extension and
retraction.

pg 3-22N:
In the case of excessive nosedown pitch, it should be
remembered that use of the speedbrakes may cause
an increased nosedown tendency due to the design of
the system.

pg 3-22Q:
Decelerate and perform a
simulated landing approach. In decelerating prior to
performing the simulated approach, use should be
made of all systems which may be needed in the actual
landing (speedbrakes, landing gear, flaps) to determine
any adverse effects they might have on the control of the aircraft.

pg 4-2:
SPEEDBRAKES
Operation of the speedbrakes results in changes in
trim characterized by a noseup pitch when opened and
a nosedown pitch when closed. To counter this
characteristic, a speedbrake-elevator interconnect
is installed which physically displaces the elevator
when the speedbrakes are operated. This interconnect
mechanism pulls the control stick forward when
the speedbrakes are opened, and returns the stick to
its original position when the speedbrakes are closed,
thus decreasing the noseup and nosedown pitching.
Some trim change will occur when the speedbrakes
are operated. The degree of this trim change will be
a function of airspeed. For further information on
use of the speedbrakes, refer to the paragraph on
Diving, in thi s part.

pg 4-10:
NOTE
• If difficulty is experienced in recovering
from dive, speedbrakes should be opened
immediately and throttle retarded in an effort
to reduce airspeed and limit altitude loss in
recovery maneuver.
• Maximum speed for fully effective opening of
speedbrakes is 440 KlAS. However, speedbrakes are
partially effective up to maximum
speed capabilities of the aircraft.

If the speedbrakes are used before entering the dive,
airspeeds will be limited to lower values where the
increase in stick forces will not be severe.
NOTE
The speedbrakes will begin to "blowback" at
approximately 490 KlAS .
The speedbrakes should not be closed until the recov
ery has been completed to prevent an increase in
stick forces resulting from the combined effects of
the buildup in airspeed and the characteristic nose
down trim changes that accompanies closing of the
speedbrakes. The control stick forces required to
produce 19 change in load factor at various Mach
numbers are presented in figure 4-1.

pg 4-18:
Descents may be made very rapidly by using IDLE
power and speedbrakes.

pg 4-16:
Do not actuate the speedbrakes during any
part of the refueling operation.

pg 4-29:
Where no light signal exists for a certain maneuver,
the radio should be used. Speedbrake signals may
be given on the radio by transmitting "flight,
speedbrakes-now." Channel changes will be given on
the radio and should be acknowledged before and
after making the shift .

pg 5-4:
(under Aborting Takeoff section)
NOTE
Best deceleration will occur by placing the
throttle to IDLE until below 80 KIAS and
then by placing the throttle to OFF (spoiler
equipped aircraft).
b. Speedbrakes OPEN
c. Ensure spoilers ARMED

pg 5-7:
(under Fuel Boost Pump Failure)
When the boost pump fails, reduce throttle to mini
mum required. Avoid zero g, negative g, or inverted
flight. Ensure positive g during speedbrake
operation.

pg 5-37:
SPEEDBRAKE FAILURE
In the event of a speedbrakecontrol valve solenoid
or dc electrical failure, operate the speedbrakes as
follows: '
1.' Speedbrake switch ••..• OPEN OR CLOSE,
. . AS REQUIRED
2. : Emergency speed
brake knob '.. '...••.••..•• PULL TO OPEN OR
PUSH TO CLOSE,
AS REQUIRED
The emergency speedbrake control may be used to
override the electrical Signal, but the handle must be
held in the desired position. Incase of hydraulic and
electrical 'failures when the ·speedbrakes are open, the
speedbrakes may be closed·to the ·.trail position by
momentary actuation of the manual control.

pg 5-42:
LIGHT SIGNALS AT NIGHT
After the pushover from marshal (shipboard) or initial
approach, fix the first blinking of leader's external
lights means speedbrakes out, second blinking means
gear and flaps down, third blinking means Wingman
take over visually and land the aircraft.

--]]