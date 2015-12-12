(
// pre-initialize data tracking space
var performerData = performerData ? ();

performerData.active = false;

performerData.perf1 = performerData.perf1 ? ();
performerData.perf1.trig1 = performerData.perf1.trig1 ? ();
performerData.perf1.trig2 = performerData.perf1.trig2 ? ();
performerData.perf1.trig3 = performerData.perf1.trig3 ? ();
performerData.perf1.trig4 = performerData.perf1.trig4 ? ();

performerData.perf2 = performerData.perf2 ? ();
performerData.perf2.trig1 = performerData.perf2.trig1 ? ();
performerData.perf2.trig2 = performerData.perf2.trig2 ? ();
performerData.perf2.trig3 = performerData.perf2.trig3 ? ();
performerData.perf2.trig4 = performerData.perf2.trig4 ? ();

performerData.perf3 = performerData.perf3 ? ();
performerData.perf3.trig1 = performerData.perf3.trig1 ? ();
performerData.perf3.trig2 = performerData.perf3.trig2 ? ();
performerData.perf3.trig3 = performerData.perf3.trig3 ? ();
performerData.perf3.trig4 = performerData.perf3.trig4 ? ();

performerData.perf1.trig1.timestamp = nil;
performerData.perf1.trig1.state = false;
performerData.perf1.trig1.onDurations = List.new(10);
performerData.perf1.trig1.offDurations = List.new(10);

performerData.perf1.trig2.timestamp = nil;
performerData.perf1.trig2.state = false;
performerData.perf1.trig2.onDurations = List.new(10);
performerData.perf1.trig2.offDurations = List.new(10);

performerData.perf1.trig3.timestamp = nil;
performerData.perf1.trig3.state = false;
performerData.perf1.trig3.onDurations = List.new(10);
performerData.perf1.trig3.offDurations = List.new(10);

performerData.perf1.trig4.timestamp = nil;
performerData.perf1.trig4.state = false;
performerData.perf1.trig4.onDurations = List.new(10);
performerData.perf1.trig4.offDurations = List.new(10);

performerData.perf2.trig1.timestamp = nil;
performerData.perf2.trig1.state = false;
performerData.perf2.trig1.onDurations = List.new(10);
performerData.perf2.trig1.offDurations = List.new(10);

performerData.perf2.trig2.timestamp = nil;
performerData.perf2.trig2.state = false;
performerData.perf2.trig2.onDurations = List.new(10);
performerData.perf2.trig2.offDurations = List.new(10);

performerData.perf2.trig3.timestamp = nil;
performerData.perf2.trig3.state = false;
performerData.perf2.trig3.onDurations = List.new(10);
performerData.perf2.trig3.offDurations = List.new(10);

performerData.perf2.trig4.timestamp = nil;
performerData.perf2.trig4.state = false;
performerData.perf2.trig4.onDurations = List.new(10);
performerData.perf2.trig4.offDurations = List.new(10);

performerData.perf3.trig1.timestamp = nil;
performerData.perf3.trig1.state = false;
performerData.perf3.trig1.onDurations = List.new(10);
performerData.perf3.trig1.offDurations = List.new(10);

performerData.perf3.trig2.timestamp = nil;
performerData.perf3.trig2.state = false;
performerData.perf3.trig2.onDurations = List.new(10);
performerData.perf3.trig2.offDurations = List.new(10);

performerData.perf3.trig3.timestamp = nil;
performerData.perf3.trig3.state = false;
performerData.perf3.trig3.onDurations = List.new(10);
performerData.perf3.trig3.offDurations = List.new(10);

performerData.perf3.trig4.timestamp = nil;
performerData.perf3.trig4.state = false;
performerData.perf3.trig4.onDurations = List.new(10);
performerData.perf3.trig4.offDurations = List.new(10);




Server.local.options.outDevice_("Fieldcuts_Aggregate");
//Server.local.options.outDevice_("AudioBox USB");

s.boot;

// load program modules (gui and synth defs)
s.doWhenBooted({(thisProcess.nowExecutingPath.dirname +/+ "fieldcuts*.scd").loadPaths;




// execute other code
~outputBus = Bus.audio(s, 4);

~delayBus = [Bus.audio(s), Bus.audio(s), Bus.audio(s)];
~master = Synth(\master, [\in, ~outputBus.index]);
~netDel = Synth(\netDelay, [
	\in1, ~delayBus[0].index,
	\in2, ~delayBus[1].index,
	\in3, ~delayBus[2].index,
	\out, ~outputBus.index
]);
/*~netDel = [
	Synth(\networkDelay, [
		\in, ~delayBus[0].index,
		\out, ~outputBus.index,
		\del_1, ~delayBus[1].index,
		\del_2, ~delayBus[2].index,
		\pan, -1
	]),
	Synth(\networkDelay, [
		\in, ~delayBus[1].index,
		\out, ~outputBus.index,
		\del_1, ~delayBus[0].index,
		\del_2, ~delayBus[2].index,
		\pan, 0
	]),
	Synth(\networkDelay, [
		\in, ~delayBus[2].index,
		\out, ~outputBus.index,
		\del_1, ~delayBus[0].index,
		\del_2, ~delayBus[1].index,
		\pan, 1
	])
];*/

//~perf_1 = Synth(\perf_1_pad, [\xpos, -1, \ypos, 0.5, \out, ~delayBus[0].index]);
//~perf_2 = Synth(\perf_2_pad, [\xpos, 0, \ypos, 1,  \out, ~delayBus[1].index]);
//~perf_3 = Synth(\perf_3_pad, [\xpos, 1, \ypos, 0.5,  \out, ~delayBus[2].index]);

~perf_1 = Synth(\perf_1_pad, [\out, ~delayBus[0].index]);
~perf_2 = Synth(\perf_2_pad, [\out, ~delayBus[1].index]);
~perf_3 = Synth(\perf_3_pad, [\out, ~delayBus[2].index]);

OSCFunc({ |msg, time, addr, recvPort|
	var x = case
	{msg[1] == \trig_1} {
		("perf_1 -> trig_1 " + msg[2]).postln;

		if(msg[2] == 'on', {
			//"turning on".postln;
				if(performerData.active == false, {
					"activating delay".postln;
					performerData.active = true;
					~netDel.set(\scale, 1);
				});
			if(performerData.perf1.trig1.state == false, {
				performerData.perf1.trig1.state = true;
				if(performerData.perf1.trig1.timestamp.notNil, {
					if(performerData.perf1.trig1.offDurations.size == 10, {
						performerData.perf1.trig1.offDurations.pop;
					});
					performerData.perf1.trig1.offDurations.addFirst(
						time - performerData.perf1.trig1.timestamp
					);
					"P1, T1, ON :: ".post;
					performerData.perf1.trig1.offDurations.postln;
				});
				performerData.perf1.trig1.timestamp = time;

				~perf_1.set(\gate, 1);
			});
		});

		if(msg[2] == 'off', {
			//"turning off".postln;
			if(performerData.perf1.trig1.state == true, {
				performerData.perf1.trig1.state = false;
				if(performerData.perf1.trig1.timestamp.notNil, {
					if(performerData.perf1.trig1.onDurations.size == 10, {
						performerData.perf1.trig1.onDurations.pop;
					});
					performerData.perf1.trig1.onDurations.addFirst(
						time - performerData.perf1.trig1.timestamp
					);
					"P1, T1, OFF :: ".post;
					performerData.perf1.trig1.onDurations.postln;
				});
				performerData.perf1.trig1.timestamp = time;
				~perf_1.set(\gate, 0);
			});
		});

		Synth(\trig_1, [\xpos, -1, \ypos, -0.5, \out, ~outputBus.index]);
	}
	{msg[1] == \trig_2} {
		("perf_1 -> trig_2 " + msg[2]).postln;

		if(msg[2] == 'on', {
			//"turning on".postln;
				if(performerData.active == false, {
					"activating delay".postln;
					performerData.active = true;
					~netDel.set(\scale, 1);
				});
			if(performerData.perf1.trig2.state == false, {
				performerData.perf1.trig2.state = true;
				if(performerData.perf1.trig2.timestamp.notNil, {
					if(performerData.perf1.trig2.offDurations.size == 10, {
						performerData.perf1.trig2.offDurations.pop;
					});
					performerData.perf1.trig2.offDurations.addFirst(
						time - performerData.perf1.trig2.timestamp
					);
					"P1, T2, ON :: ".post;
					performerData.perf1.trig2.offDurations.postln;
				});
				performerData.perf1.trig2.timestamp = time;

				~perf_1.set(\gate, 1);
			});
		});

		if(msg[2] == 'off', {
			//"turning off".postln;
			if(performerData.perf1.trig2.state == true, {
				performerData.perf1.trig2.state = false;
				if(performerData.perf1.trig2.timestamp.notNil, {
					if(performerData.perf1.trig2.onDurations.size == 10, {
						performerData.perf1.trig2.onDurations.pop;
					});
					performerData.perf1.trig2.onDurations.addFirst(
						time - performerData.perf1.trig2.timestamp
					);
					"P1, T2, OFF :: ".post;
					performerData.perf1.trig2.onDurations.postln;
				});
				performerData.perf1.trig2.timestamp = time;
				~perf_1.set(\gate, 0);
			});
		});

		Synth(\trig_2, [\xpos, -1, \ypos, -0.5, \out, ~outputBus.index]);
	}
	{msg[1] == \trig_3} {
		("perf_1 -> trig_3 " + msg[2]).postln;

		if(msg[2] == 'on', {
			//"turning on".postln;
				if(performerData.active == false, {
					"activating delay".postln;
					performerData.active = true;
					~netDel.set(\scale, 1);
				});
			if(performerData.perf1.trig3.state == false, {
				performerData.perf1.trig3.state = true;
				if(performerData.perf1.trig3.timestamp.notNil, {
					if(performerData.perf1.trig3.offDurations.size == 10, {
						performerData.perf1.trig3.offDurations.pop;
					});
					performerData.perf1.trig3.offDurations.addFirst(
						time - performerData.perf1.trig3.timestamp
					);
					"P1, T3, ON :: ".post;
					performerData.perf1.trig3.offDurations.postln;
				});
				performerData.perf1.trig3.timestamp = time;

				~perf_1.set(\gate, 1);
			});
		});

		if(msg[2] == 'off', {
			//"turning off".postln;
			if(performerData.perf1.trig3.state == true, {
				performerData.perf1.trig3.state = false;
				if(performerData.perf1.trig3.timestamp.notNil, {
					if(performerData.perf1.trig3.onDurations.size == 10, {
						performerData.perf1.trig3.onDurations.pop;
					});
					performerData.perf1.trig3.onDurations.addFirst(
						time - performerData.perf1.trig3.timestamp
					);
					"P1, T3, OFF :: ".post;
					performerData.perf1.trig3.onDurations.postln;
				});
				performerData.perf1.trig3.timestamp = time;

				~perf_1.set(\gate, 0);
			});
		});

		Synth(\trig_3, [\xpos, -1, \ypos, -0.5, \out, ~outputBus.index]);
	}
	{msg[1] == \trig_4} {
		("perf_1 -> trig_4 " + msg[2]).postln;

		if(msg[2] == 'on', {
			//"turning on".postln;
				if(performerData.active == false, {
					"activating delay".postln;
					performerData.active = true;
					~netDel.set(\scale, 1);
				});
			if(performerData.perf1.trig4.state == false, {
				performerData.perf1.trig4.state = true;
				if(performerData.perf1.trig4.timestamp.notNil, {
					if(performerData.perf1.trig4.offDurations.size == 10, {
						performerData.perf1.trig4.offDurations.pop;
					});
					performerData.perf1.trig4.offDurations.addFirst(
						time - performerData.perf1.trig4.timestamp
					);
					"P1, T4, ON :: ".post;
					performerData.perf1.trig4.offDurations.postln;
				});
				performerData.perf1.trig4.timestamp = time;

				~perf_1.set(\gate, 1);
			});
		});

		if(msg[2] == 'off', {
			//"turning off".postln;
			if(performerData.perf1.trig4.state == true, {
				performerData.perf1.trig4.state = false;
				if(performerData.perf1.trig4.timestamp.notNil, {
					if(performerData.perf1.trig4.onDurations.size == 10, {
						performerData.perf1.trig4.onDurations.pop;
					});
					performerData.perf1.trig4.onDurations.addFirst(
						time - performerData.perf1.trig4.timestamp
					);
					"P1, T4, OFF :: ".post;
					performerData.perf1.trig4.onDurations.postln;
				});
				performerData.perf1.trig4.timestamp = time;

				~perf_1.set(\gate, 0);
			});
		});

		Synth(\trig_4, [\xpos, -1, \ypos, -0.5, \out, ~outputBus.index]);
	};

	//x.postln;
}, '/fieldcuts/perf_1');

OSCFunc({ |msg, time, addr, recvPort|
	var x = case
	{msg[1] == \trig_1} {
		("perf_2 -> trig_1 " + msg[2]);

		if(msg[2] == 'on', {
			//"turning on".postln;
				if(performerData.active == false, {
					"activating delay".postln;
					performerData.active = true;
					~netDel.set(\scale, 1);
				});
			if(performerData.perf2.trig1.state == false, {
				performerData.perf2.trig1.state = true;
				if(performerData.perf2.trig1.timestamp.notNil, {
					if(performerData.perf2.trig1.offDurations.size == 10, {
						performerData.perf2.trig1.offDurations.pop;
					});
					performerData.perf2.trig1.offDurations.addFirst(
						time - performerData.perf2.trig1.timestamp
					);
					"P2, T1, ON :: ".post;
					performerData.perf2.trig1.offDurations.postln;
				});
				performerData.perf2.trig1.timestamp = time;

				~perf_2.set(\gate, 1);
			});
		});

		if(msg[2] == 'off', {
			//"turning off".postln;
			if(performerData.perf2.trig1.state == true, {
				performerData.perf2.trig1.state = false;
				if(performerData.perf2.trig1.timestamp.notNil, {
					if(performerData.perf2.trig1.onDurations.size == 10, {
						performerData.perf2.trig1.onDurations.pop;
					});
					performerData.perf2.trig1.onDurations.addFirst(
						time - performerData.perf2.trig1.timestamp
					);
					"P2, T1, OFF :: ".post;
					performerData.perf2.trig1.onDurations.postln;
				});
				performerData.perf2.trig1.timestamp = time;

				~perf_2.set(\gate, 0);
			});
		});

		Synth(\trig_1, [\xpos, 0, \ypos, 1, \out, ~outputBus.index]);
	}
	{msg[1] == \trig_2} {
		("perf_2 -> trig_2 " + msg[2]);

		if(msg[2] == 'on', {
			//"turning on".postln;
				if(performerData.active == false, {
					"activating delay".postln;
					performerData.active = true;
					~netDel.set(\scale, 1);
				});
			if(performerData.perf2.trig2.state == false, {
				performerData.perf2.trig2.state = true;
				if(performerData.perf2.trig2.timestamp.notNil, {
					if(performerData.perf2.trig2.offDurations.size == 10, {
						performerData.perf2.trig2.offDurations.pop;
					});
					performerData.perf2.trig2.offDurations.addFirst(
						time - performerData.perf2.trig2.timestamp
					);
					"P2, T2, ON :: ".post;
					performerData.perf2.trig2.offDurations.postln;
				});
				performerData.perf2.trig2.timestamp = time;

				~perf_2.set(\gate, 1);
			});
		});

		if(msg[2] == 'off', {
			//"turning off".postln;
			if(performerData.perf2.trig2.state == true, {
				performerData.perf2.trig2.state = false;
				if(performerData.perf2.trig2.timestamp.notNil, {
					if(performerData.perf2.trig2.onDurations.size == 10, {
						performerData.perf2.trig2.onDurations.pop;
					});
					performerData.perf2.trig2.onDurations.addFirst(
						time - performerData.perf2.trig2.timestamp
					);
					"P2, T2, OFF :: ".post;
					performerData.perf2.trig2.onDurations.postln;
				});
				performerData.perf2.trig2.timestamp = time;

				~perf_2.set(\gate, 0);
			});
		});

		Synth(\trig_2, [\xpos, 0, \ypos, 1, \out, ~outputBus.index]);
	}
	{msg[1] == \trig_3} {
		("perf_2 -> trig_3 " + msg[2]);

		if(msg[2] == 'on', {
			//"turning on".postln;
				if(performerData.active == false, {
					"activating delay".postln;
					performerData.active = true;
					~netDel.set(\scale, 1);
				});
			if(performerData.perf2.trig3.state == false, {
				performerData.perf2.trig3.state = true;
				if(performerData.perf2.trig3.timestamp.notNil, {
					if(performerData.perf2.trig3.offDurations.size == 10, {
						performerData.perf2.trig3.offDurations.pop;
					});
					performerData.perf2.trig3.offDurations.addFirst(
						time - performerData.perf2.trig3.timestamp
					);
					"P2, T3, ON :: ".post;
					performerData.perf2.trig3.offDurations.postln;
				});
				performerData.perf2.trig3.timestamp = time;

				~perf_2.set(\gate, 1);
			});
		});

		if(msg[2] == 'off', {
			//"turning off".postln;
			if(performerData.perf2.trig3.state == true, {
				performerData.perf2.trig3.state = false;
				if(performerData.perf2.trig3.timestamp.notNil, {
					if(performerData.perf2.trig3.onDurations.size == 10, {
						performerData.perf2.trig3.onDurations.pop;
					});
					performerData.perf2.trig3.onDurations.addFirst(
						time - performerData.perf2.trig3.timestamp
					);
					"P2, T3, OFF :: ".post;
					performerData.perf2.trig3.onDurations.postln;
				});
				performerData.perf2.trig3.timestamp = time;

				~perf_2.set(\gate, 0);
			});
		});

		Synth(\trig_3, [\xpos, 0, \ypos, 1, \out, ~outputBus.index]);
	}
	{msg[1] == \trig_4} {
		("perf_2 -> trig_4 " + msg[2]);

		if(msg[2] == 'on', {
			//"turning on".postln;
				if(performerData.active == false, {
					"activating delay".postln;
					performerData.active = true;
					~netDel.set(\scale, 1);
				});
			if(performerData.perf2.trig4.state == false, {
				performerData.perf2.trig4.state = true;
				if(performerData.perf2.trig4.timestamp.notNil, {
					if(performerData.perf2.trig4.offDurations.size == 10, {
						performerData.perf2.trig4.offDurations.pop;
					});
					performerData.perf2.trig4.offDurations.addFirst(
						time - performerData.perf2.trig4.timestamp
					);
					"P2, T4, ON :: ".post;
					performerData.perf2.trig4.offDurations.postln;
				});
				performerData.perf2.trig4.timestamp = time;

				~perf_2.set(\gate, 1);
			});
		});

		if(msg[2] == 'off', {
			//"turning off".postln;
			if(performerData.perf2.trig4.state == true, {
				performerData.perf2.trig4.state = false;
				if(performerData.perf2.trig4.timestamp.notNil, {
					if(performerData.perf2.trig4.onDurations.size == 10, {
						performerData.perf2.trig4.onDurations.pop;
					});
					performerData.perf2.trig4.onDurations.addFirst(
						time - performerData.perf2.trig4.timestamp
					);
					"P2, T4, OFF :: ".post;
					performerData.perf2.trig4.onDurations.postln;
				});
				performerData.perf2.trig4.timestamp = time;

				~perf_2.set(\gate, 0);
			});
		});

		Synth(\trig_4, [\xpos, 0, \ypos, 1, \out, ~outputBus.index]);
	};

	//x.postln;
}, '/fieldcuts/perf_2');

OSCFunc({ |msg, time, addr, recvPort|
	var x = case
	{msg[1] == \trig_1} {
		("contr -> trig_1 " + msg[2]);

		if(msg[2] == 'on', {
			//"turning on".postln;
				if(performerData.active == false, {
					"activating delay".postln;
					performerData.active = true;
					~netDel.set(\scale, 1);
				});
			if(performerData.perf3.trig1.state == false, {
				performerData.perf3.trig1.state = true;
				if(performerData.perf3.trig1.timestamp.notNil, {
					if(performerData.perf3.trig1.offDurations.size == 10, {
						performerData.perf3.trig1.offDurations.pop;
					});
					performerData.perf3.trig1.offDurations.addFirst(
						time - performerData.perf3.trig1.timestamp
					)
				});
				performerData.perf3.trig1.timestamp = time;

				~perf_3.set(\gate, 1);
			});
		});

		if(msg[2] == 'off', {
			//"turning off".postln;
			if(performerData.perf3.trig1.state == true, {
				performerData.perf3.trig1.state = false;
				if(performerData.perf3.trig1.timestamp.notNil, {
					if(performerData.perf3.trig1.onDurations.size == 10, {
						performerData.perf3.trig1.onDurations.pop;
					});
					performerData.perf3.trig1.onDurations.addFirst(
						time - performerData.perf3.trig1.timestamp
					)
				});
				performerData.perf3.trig1.timestamp = time;

				~perf_3.set(\gate, 0);
			});
		});

		Synth(\trig_1, [\xpos, 1, \ypos, -0.5, \out, ~outputBus.index]);
	}
	{msg[1] == \trig_2} {
		("contr -> trig_2 " + msg[2]);

		if(msg[2] == 'on', {
			//"turning on".postln;
				if(performerData.active == false, {
					"activating delay".postln;
					performerData.active = true;
					~netDel.set(\scale, 1);
				});
			if(performerData.perf3.trig2.state == false, {
				performerData.perf3.trig2.state = true;
				if(performerData.perf3.trig2.timestamp.notNil, {
					if(performerData.perf3.trig2.offDurations.size == 10, {
						performerData.perf3.trig2.offDurations.pop;
					});
					performerData.perf3.trig2.offDurations.addFirst(
						time - performerData.perf3.trig2.timestamp
					)
				});
				performerData.perf3.trig2.timestamp = time;

				~perf_3.set(\gate, 1);
			});
		});

		if(msg[2] == 'off', {
			//"turning off".postln;
			if(performerData.perf3.trig2.state == true, {
				performerData.perf3.trig2.state = false;
				if(performerData.perf3.trig2.timestamp.notNil, {
					if(performerData.perf3.trig2.onDurations.size == 10, {
						performerData.perf3.trig2.onDurations.pop;
					});
					performerData.perf3.trig2.onDurations.addFirst(
						time - performerData.perf3.trig2.timestamp
					)
				});
				performerData.perf3.trig2.timestamp = time;

				~perf_3.set(\gate, 0);
			});
		});

		Synth(\trig_2, [\xpos, 1, \ypos, -0.5, \out, ~outputBus.index]);
	}
	{msg[1] == \trig_3} {
		("contr -> trig_3 " + msg[2]);

		if(msg[2] == 'on', {
			//"turning on".postln;
				if(performerData.active == false, {
					"activating delay".postln;
					performerData.active = true;
					~netDel.set(\scale, 1);
				});
			if(performerData.perf3.trig3.state == false, {
				performerData.perf3.trig3.state = true;
				if(performerData.perf3.trig3.timestamp.notNil, {
					if(performerData.perf3.trig3.offDurations.size == 10, {
						performerData.perf3.trig3.offDurations.pop;
					});
					performerData.perf3.trig3.offDurations.addFirst(
						time - performerData.perf3.trig3.timestamp
					)
				});
				performerData.perf3.trig3.timestamp = time;

				~perf_3.set(\gate, 1);
			});
		});

		if(msg[2] == 'off', {
			//"turning off".postln;
			if(performerData.perf3.trig3.state == true, {
				performerData.perf3.trig3.state = false;
				if(performerData.perf3.trig3.timestamp.notNil, {
					if(performerData.perf3.trig3.onDurations.size == 10, {
						performerData.perf3.trig3.onDurations.pop;
					});
					performerData.perf3.trig3.onDurations.addFirst(
						time - performerData.perf3.trig3.timestamp
					)
				});
				performerData.perf3.trig3.timestamp = time;

				~perf_3.set(\gate, 0);
			});
		});

		Synth(\trig_3, [\xpos, 1, \ypos, -0.5, \out, ~outputBus.index]);
	}
	{msg[1] == \trig_4} {
		("contr -> trig_4 " + msg[2]);

		if(msg[2] == 'on', {
			//"turning on".postln;
				if(performerData.active == false, {
					"activating delay".postln;
					performerData.active = true;
					~netDel.set(\scale, 1);
				});
			if(performerData.perf3.trig4.state == false, {
				performerData.perf3.trig4.state = true;
				if(performerData.perf3.trig4.timestamp.notNil, {
					if(performerData.perf3.trig4.offDurations.size == 10, {
						performerData.perf3.trig4.offDurations.pop;
					});
					performerData.perf3.trig4.offDurations.addFirst(
						time - performerData.perf3.trig4.timestamp
					)
				});
				performerData.perf3.trig4.timestamp = time;

				~perf_3.set(\gate, 1);
			});
		});

		if(msg[2] == 'off', {
			//"turning off".postln;
			if(performerData.perf3.trig4.state == true, {
					performerData.perf3.trig4.state = false;
				if(performerData.perf3.trig4.timestamp.notNil, {
					if(performerData.perf3.trig4.onDurations.size == 10, {
						performerData.perf3.trig4.onDurations.pop;
					});
					performerData.perf3.trig4.onDurations.addFirst(
						time - performerData.perf3.trig4.timestamp
					)
				});
				performerData.perf3.trig4.timestamp = time;

				~perf_3.set(\gate, 0);
			});
		});

		Synth(\trig_4, [\xpos, 1, \ypos, -0.5, \out, ~outputBus.index]);
	};

	//x.postln;
}, '/fieldcuts/contr');

OSCFunc({
	~master.set(\gate, 0);
}, '/fieldcuts/fadeOut');

//OSCFunc({ |msg|
//	msg.postln;
//}, '/');
s.scope;
});
)