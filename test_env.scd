(
// pre-initialize data tracking space
var perfData = perfData ? ();

perfData.active = false;

perfData.perf1 = perfData.perf1 ? ();
perfData.perf1.trig1 = perfData.perf1.trig1 ? ();
perfData.perf1.trig2 = perfData.perf1.trig2 ? ();
perfData.perf1.trig3 = perfData.perf1.trig3 ? ();
perfData.perf1.trig4 = perfData.perf1.trig4 ? ();

perfData.perf2 = perfData.perf2 ? ();
perfData.perf2.trig1 = perfData.perf2.trig1 ? ();
perfData.perf2.trig2 = perfData.perf2.trig2 ? ();
perfData.perf2.trig3 = perfData.perf2.trig3 ? ();
perfData.perf2.trig4 = perfData.perf2.trig4 ? ();

perfData.perf3 = perfData.perf3 ? ();
perfData.perf3.trig1 = perfData.perf3.trig1 ? ();
perfData.perf3.trig2 = perfData.perf3.trig2 ? ();
perfData.perf3.trig3 = perfData.perf3.trig3 ? ();
perfData.perf3.trig4 = perfData.perf3.trig4 ? ();

perfData.perf1.trig1.timestamp = nil;
perfData.perf1.trig1.state = false;
perfData.perf1.trig1.onDur = List.new(10);
perfData.perf1.trig1.offDur = List.new(10);

perfData.perf1.trig2.timestamp = nil;
perfData.perf1.trig2.state = false;
perfData.perf1.trig2.onDur = List.new(10);
perfData.perf1.trig2.offDur = List.new(10);

perfData.perf1.trig3.timestamp = nil;
perfData.perf1.trig3.state = false;
perfData.perf1.trig3.onDur = List.new(10);
perfData.perf1.trig3.offDur = List.new(10);

perfData.perf1.trig4.timestamp = nil;
perfData.perf1.trig4.state = false;
perfData.perf1.trig4.onDur = List.new(10);
perfData.perf1.trig4.offDur = List.new(10);

perfData.perf2.trig1.timestamp = nil;
perfData.perf2.trig1.state = false;
perfData.perf2.trig1.onDur = List.new(10);
perfData.perf2.trig1.offDur = List.new(10);

perfData.perf2.trig2.timestamp = nil;
perfData.perf2.trig2.state = false;
perfData.perf2.trig2.onDur = List.new(10);
perfData.perf2.trig2.offDur = List.new(10);

perfData.perf2.trig3.timestamp = nil;
perfData.perf2.trig3.state = false;
perfData.perf2.trig3.onDur = List.new(10);
perfData.perf2.trig3.offDur = List.new(10);

perfData.perf2.trig4.timestamp = nil;
perfData.perf2.trig4.state = false;
perfData.perf2.trig4.onDur = List.new(10);
perfData.perf2.trig4.offDur = List.new(10);

perfData.perf3.trig1.timestamp = nil;
perfData.perf3.trig1.state = false;
perfData.perf3.trig1.onDur = List.new(10);
perfData.perf3.trig1.offDur = List.new(10);

perfData.perf3.trig2.timestamp = nil;
perfData.perf3.trig2.state = false;
perfData.perf3.trig2.onDur = List.new(10);
perfData.perf3.trig2.offDur = List.new(10);

perfData.perf3.trig3.timestamp = nil;
perfData.perf3.trig3.state = false;
perfData.perf3.trig3.onDur = List.new(10);
perfData.perf3.trig3.offDur = List.new(10);

perfData.perf3.trig4.timestamp = nil;
perfData.perf3.trig4.state = false;
perfData.perf3.trig4.onDur = List.new(10);
perfData.perf3.trig4.offDur = List.new(10);




Server.local.options.outDevice_("HDSPe MADIface (22802690)");
//Server.local.options.outDevice_("AudioBox USB");

s.boot;

// load program modules (gui and synth defs)
s.doWhenBooted({


(thisProcess.nowExecutingPath.dirname +/+ "fieldcuts*.scd").loadPaths;




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
				if(perfData.active == false, {
					"activating delay".postln;
					perfData.active = true;
					~netDel.set(\scale, 1);
				});
			if(perfData.perf1.trig1.state == false, {
				perfData.perf1.trig1.state = true;
				if(perfData.perf1.trig1.timestamp.notNil, {
					if(perfData.perf1.trig1.offDur.size == 10, {
						perfData.perf1.trig1.offDur.pop;
					});
					perfData.perf1.trig1.offDur.addFirst(
						time - perfData.perf1.trig1.timestamp
					);
					"P1, T1, ON :: ".post;
					perfData.perf1.trig1.offDur.postln;
				});
				perfData.perf1.trig1.timestamp = time;

				~perf_1.set(\gate, 1);
			});
		});

		if(msg[2] == 'off', {
			//"turning off".postln;
			if(perfData.perf1.trig1.state == true, {
				perfData.perf1.trig1.state = false;
				if(perfData.perf1.trig1.timestamp.notNil, {
					if(perfData.perf1.trig1.onDur.size == 10, {
						perfData.perf1.trig1.onDur.pop;
					});
					perfData.perf1.trig1.onDur.addFirst(
						time - perfData.perf1.trig1.timestamp
					);
					"P1, T1, OFF :: ".post;
					perfData.perf1.trig1.onDur.postln;
				});
				perfData.perf1.trig1.timestamp = time;
				~perf_1.set(\gate, 0);
			});
		});

		Synth(\trig_1, [\xpos, -1, \ypos, -0.5, \out, ~outputBus.index]);
	}
	{msg[1] == \trig_2} {
		("perf_1 -> trig_2 " + msg[2]).postln;

		if(msg[2] == 'on', {
			//"turning on".postln;
				if(perfData.active == false, {
					"activating delay".postln;
					perfData.active = true;
					~netDel.set(\scale, 1);
				});
			if(perfData.perf1.trig2.state == false, {
				perfData.perf1.trig2.state = true;
				if(perfData.perf1.trig2.timestamp.notNil, {
					if(perfData.perf1.trig2.offDur.size == 10, {
						perfData.perf1.trig2.offDur.pop;
					});
					perfData.perf1.trig2.offDur.addFirst(
						time - perfData.perf1.trig2.timestamp
					);
					"P1, T2, ON :: ".post;
					perfData.perf1.trig2.offDur.postln;
				});
				perfData.perf1.trig2.timestamp = time;

				~perf_1.set(\gate, 1);
			});
		});

		if(msg[2] == 'off', {
			//"turning off".postln;
			if(perfData.perf1.trig2.state == true, {
				perfData.perf1.trig2.state = false;
				if(perfData.perf1.trig2.timestamp.notNil, {
					if(perfData.perf1.trig2.onDur.size == 10, {
						perfData.perf1.trig2.onDur.pop;
					});
					perfData.perf1.trig2.onDur.addFirst(
						time - perfData.perf1.trig2.timestamp
					);
					"P1, T2, OFF :: ".post;
					perfData.perf1.trig2.onDur.postln;
				});
				perfData.perf1.trig2.timestamp = time;
				~perf_1.set(\gate, 0);
			});
		});

		Synth(\trig_2, [\xpos, -1, \ypos, -0.5, \out, ~outputBus.index]);
	}
	{msg[1] == \trig_3} {
		("perf_1 -> trig_3 " + msg[2]).postln;

		if(msg[2] == 'on', {
			//"turning on".postln;
				if(perfData.active == false, {
					"activating delay".postln;
					perfData.active = true;
					~netDel.set(\scale, 1);
				});
			if(perfData.perf1.trig3.state == false, {
				perfData.perf1.trig3.state = true;
				if(perfData.perf1.trig3.timestamp.notNil, {
					if(perfData.perf1.trig3.offDur.size == 10, {
						perfData.perf1.trig3.offDur.pop;
					});
					perfData.perf1.trig3.offDur.addFirst(
						time - perfData.perf1.trig3.timestamp
					);
					"P1, T3, ON :: ".post;
					perfData.perf1.trig3.offDur.postln;
				});
				perfData.perf1.trig3.timestamp = time;

				~perf_1.set(\gate, 1);
			});
		});

		if(msg[2] == 'off', {
			//"turning off".postln;
			if(perfData.perf1.trig3.state == true, {
				perfData.perf1.trig3.state = false;
				if(perfData.perf1.trig3.timestamp.notNil, {
					if(perfData.perf1.trig3.onDur.size == 10, {
						perfData.perf1.trig3.onDur.pop;
					});
					perfData.perf1.trig3.onDur.addFirst(
						time - perfData.perf1.trig3.timestamp
					);
					"P1, T3, OFF :: ".post;
					perfData.perf1.trig3.onDur.postln;
				});
				perfData.perf1.trig3.timestamp = time;

				~perf_1.set(\gate, 0);
			});
		});

		Synth(\trig_3, [\xpos, -1, \ypos, -0.5, \out, ~outputBus.index]);
	}
	{msg[1] == \trig_4} {
		("perf_1 -> trig_4 " + msg[2]).postln;

		if(msg[2] == 'on', {
			//"turning on".postln;
				if(perfData.active == false, {
					"activating delay".postln;
					perfData.active = true;
					~netDel.set(\scale, 1);
				});
			if(perfData.perf1.trig4.state == false, {
				perfData.perf1.trig4.state = true;
				if(perfData.perf1.trig4.timestamp.notNil, {
					if(perfData.perf1.trig4.offDur.size == 10, {
						perfData.perf1.trig4.offDur.pop;
					});
					perfData.perf1.trig4.offDur.addFirst(
						time - perfData.perf1.trig4.timestamp
					);
					"P1, T4, ON :: ".post;
					perfData.perf1.trig4.offDur.postln;
				});
				perfData.perf1.trig4.timestamp = time;

				~perf_1.set(\gate, 1);
			});
		});

		if(msg[2] == 'off', {
			//"turning off".postln;
			if(perfData.perf1.trig4.state == true, {
				perfData.perf1.trig4.state = false;
				if(perfData.perf1.trig4.timestamp.notNil, {
					if(perfData.perf1.trig4.onDur.size == 10, {
						perfData.perf1.trig4.onDur.pop;
					});
					perfData.perf1.trig4.onDur.addFirst(
						time - perfData.perf1.trig4.timestamp
					);
					"P1, T4, OFF :: ".post;
					perfData.perf1.trig4.onDur.postln;
				});
				perfData.perf1.trig4.timestamp = time;

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
				if(perfData.active == false, {
					"activating delay".postln;
					perfData.active = true;
					~netDel.set(\scale, 1);
				});
			if(perfData.perf2.trig1.state == false, {
				perfData.perf2.trig1.state = true;
				if(perfData.perf2.trig1.timestamp.notNil, {
					if(perfData.perf2.trig1.offDur.size == 10, {
						perfData.perf2.trig1.offDur.pop;
					});
					perfData.perf2.trig1.offDur.addFirst(
						time - perfData.perf2.trig1.timestamp
					);
					"P2, T1, ON :: ".post;
					perfData.perf2.trig1.offDur.postln;
				});
				perfData.perf2.trig1.timestamp = time;

				~perf_2.set(\gate, 1);
			});
		});

		if(msg[2] == 'off', {
			//"turning off".postln;
			if(perfData.perf2.trig1.state == true, {
				perfData.perf2.trig1.state = false;
				if(perfData.perf2.trig1.timestamp.notNil, {
					if(perfData.perf2.trig1.onDur.size == 10, {
						perfData.perf2.trig1.onDur.pop;
					});
					perfData.perf2.trig1.onDur.addFirst(
						time - perfData.perf2.trig1.timestamp
					);
					"P2, T1, OFF :: ".post;
					perfData.perf2.trig1.onDur.postln;
				});
				perfData.perf2.trig1.timestamp = time;

				~perf_2.set(\gate, 0);
			});
		});

		Synth(\trig_1, [\xpos, 0, \ypos, 1, \out, ~outputBus.index]);
	}
	{msg[1] == \trig_2} {
		("perf_2 -> trig_2 " + msg[2]);

		if(msg[2] == 'on', {
			//"turning on".postln;
				if(perfData.active == false, {
					"activating delay".postln;
					perfData.active = true;
					~netDel.set(\scale, 1);
				});
			if(perfData.perf2.trig2.state == false, {
				perfData.perf2.trig2.state = true;
				if(perfData.perf2.trig2.timestamp.notNil, {
					if(perfData.perf2.trig2.offDur.size == 10, {
						perfData.perf2.trig2.offDur.pop;
					});
					perfData.perf2.trig2.offDur.addFirst(
						time - perfData.perf2.trig2.timestamp
					);
					"P2, T2, ON :: ".post;
					perfData.perf2.trig2.offDur.postln;
				});
				perfData.perf2.trig2.timestamp = time;

				~perf_2.set(\gate, 1);
			});
		});

		if(msg[2] == 'off', {
			//"turning off".postln;
			if(perfData.perf2.trig2.state == true, {
				perfData.perf2.trig2.state = false;
				if(perfData.perf2.trig2.timestamp.notNil, {
					if(perfData.perf2.trig2.onDur.size == 10, {
						perfData.perf2.trig2.onDur.pop;
					});
					perfData.perf2.trig2.onDur.addFirst(
						time - perfData.perf2.trig2.timestamp
					);
					"P2, T2, OFF :: ".post;
					perfData.perf2.trig2.onDur.postln;
				});
				perfData.perf2.trig2.timestamp = time;

				~perf_2.set(\gate, 0);
			});
		});

		Synth(\trig_2, [\xpos, 0, \ypos, 1, \out, ~outputBus.index]);
	}
	{msg[1] == \trig_3} {
		("perf_2 -> trig_3 " + msg[2]);

		if(msg[2] == 'on', {
			//"turning on".postln;
				if(perfData.active == false, {
					"activating delay".postln;
					perfData.active = true;
					~netDel.set(\scale, 1);
				});
			if(perfData.perf2.trig3.state == false, {
				perfData.perf2.trig3.state = true;
				if(perfData.perf2.trig3.timestamp.notNil, {
					if(perfData.perf2.trig3.offDur.size == 10, {
						perfData.perf2.trig3.offDur.pop;
					});
					perfData.perf2.trig3.offDur.addFirst(
						time - perfData.perf2.trig3.timestamp
					);
					"P2, T3, ON :: ".post;
					perfData.perf2.trig3.offDur.postln;
				});
				perfData.perf2.trig3.timestamp = time;

				~perf_2.set(\gate, 1);
			});
		});

		if(msg[2] == 'off', {
			//"turning off".postln;
			if(perfData.perf2.trig3.state == true, {
				perfData.perf2.trig3.state = false;
				if(perfData.perf2.trig3.timestamp.notNil, {
					if(perfData.perf2.trig3.onDur.size == 10, {
						perfData.perf2.trig3.onDur.pop;
					});
					perfData.perf2.trig3.onDur.addFirst(
						time - perfData.perf2.trig3.timestamp
					);
					"P2, T3, OFF :: ".post;
					perfData.perf2.trig3.onDur.postln;
				});
				perfData.perf2.trig3.timestamp = time;

				~perf_2.set(\gate, 0);
			});
		});

		Synth(\trig_3, [\xpos, 0, \ypos, 1, \out, ~outputBus.index]);
	}
	{msg[1] == \trig_4} {
		("perf_2 -> trig_4 " + msg[2]);

		if(msg[2] == 'on', {
			//"turning on".postln;
				if(perfData.active == false, {
					"activating delay".postln;
					perfData.active = true;
					~netDel.set(\scale, 1);
				});
			if(perfData.perf2.trig4.state == false, {
				perfData.perf2.trig4.state = true;
				if(perfData.perf2.trig4.timestamp.notNil, {
					if(perfData.perf2.trig4.offDur.size == 10, {
						perfData.perf2.trig4.offDur.pop;
					});
					perfData.perf2.trig4.offDur.addFirst(
						time - perfData.perf2.trig4.timestamp
					);
					"P2, T4, ON :: ".post;
					perfData.perf2.trig4.offDur.postln;
				});
				perfData.perf2.trig4.timestamp = time;

				~perf_2.set(\gate, 1);
			});
		});

		if(msg[2] == 'off', {
			//"turning off".postln;
			if(perfData.perf2.trig4.state == true, {
				perfData.perf2.trig4.state = false;
				if(perfData.perf2.trig4.timestamp.notNil, {
					if(perfData.perf2.trig4.onDur.size == 10, {
						perfData.perf2.trig4.onDur.pop;
					});
					perfData.perf2.trig4.onDur.addFirst(
						time - perfData.perf2.trig4.timestamp
					);
					"P2, T4, OFF :: ".post;
					perfData.perf2.trig4.onDur.postln;
				});
				perfData.perf2.trig4.timestamp = time;

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
				if(perfData.active == false, {
					"activating delay".postln;
					perfData.active = true;
					~netDel.set(\scale, 1);
				});
			if(perfData.perf3.trig1.state == false, {
				perfData.perf3.trig1.state = true;
				if(perfData.perf3.trig1.timestamp.notNil, {
					if(perfData.perf3.trig1.offDur.size == 10, {
						perfData.perf3.trig1.offDur.pop;
					});
					perfData.perf3.trig1.offDur.addFirst(
						time - perfData.perf3.trig1.timestamp
					)
				});
				perfData.perf3.trig1.timestamp = time;

				~perf_3.set(\gate, 1);
			});
		});

		if(msg[2] == 'off', {
			//"turning off".postln;
			if(perfData.perf3.trig1.state == true, {
				perfData.perf3.trig1.state = false;
				if(perfData.perf3.trig1.timestamp.notNil, {
					if(perfData.perf3.trig1.onDur.size == 10, {
						perfData.perf3.trig1.onDur.pop;
					});
					perfData.perf3.trig1.onDur.addFirst(
						time - perfData.perf3.trig1.timestamp
					)
				});
				perfData.perf3.trig1.timestamp = time;

				~perf_3.set(\gate, 0);
			});
		});

		Synth(\trig_1, [\xpos, 1, \ypos, -0.5, \out, ~outputBus.index]);
	}
	{msg[1] == \trig_2} {
		("contr -> trig_2 " + msg[2]);

		if(msg[2] == 'on', {
			//"turning on".postln;
				if(perfData.active == false, {
					"activating delay".postln;
					perfData.active = true;
					~netDel.set(\scale, 1);
				});
			if(perfData.perf3.trig2.state == false, {
				perfData.perf3.trig2.state = true;
				if(perfData.perf3.trig2.timestamp.notNil, {
					if(perfData.perf3.trig2.offDur.size == 10, {
						perfData.perf3.trig2.offDur.pop;
					});
					perfData.perf3.trig2.offDur.addFirst(
						time - perfData.perf3.trig2.timestamp
					)
				});
				perfData.perf3.trig2.timestamp = time;

				~perf_3.set(\gate, 1);
			});
		});

		if(msg[2] == 'off', {
			//"turning off".postln;
			if(perfData.perf3.trig2.state == true, {
				perfData.perf3.trig2.state = false;
				if(perfData.perf3.trig2.timestamp.notNil, {
					if(perfData.perf3.trig2.onDur.size == 10, {
						perfData.perf3.trig2.onDur.pop;
					});
					perfData.perf3.trig2.onDur.addFirst(
						time - perfData.perf3.trig2.timestamp
					)
				});
				perfData.perf3.trig2.timestamp = time;

				~perf_3.set(\gate, 0);
			});
		});

		Synth(\trig_2, [\xpos, 1, \ypos, -0.5, \out, ~outputBus.index]);
	}
	{msg[1] == \trig_3} {
		("contr -> trig_3 " + msg[2]);

		if(msg[2] == 'on', {
			//"turning on".postln;
				if(perfData.active == false, {
					"activating delay".postln;
					perfData.active = true;
					~netDel.set(\scale, 1);
				});
			if(perfData.perf3.trig3.state == false, {
				perfData.perf3.trig3.state = true;
				if(perfData.perf3.trig3.timestamp.notNil, {
					if(perfData.perf3.trig3.offDur.size == 10, {
						perfData.perf3.trig3.offDur.pop;
					});
					perfData.perf3.trig3.offDur.addFirst(
						time - perfData.perf3.trig3.timestamp
					)
				});
				perfData.perf3.trig3.timestamp = time;

				~perf_3.set(\gate, 1);
			});
		});

		if(msg[2] == 'off', {
			//"turning off".postln;
			if(perfData.perf3.trig3.state == true, {
				perfData.perf3.trig3.state = false;
				if(perfData.perf3.trig3.timestamp.notNil, {
					if(perfData.perf3.trig3.onDur.size == 10, {
						perfData.perf3.trig3.onDur.pop;
					});
					perfData.perf3.trig3.onDur.addFirst(
						time - perfData.perf3.trig3.timestamp
					)
				});
				perfData.perf3.trig3.timestamp = time;

				~perf_3.set(\gate, 0);
			});
		});

		Synth(\trig_3, [\xpos, 1, \ypos, -0.5, \out, ~outputBus.index]);
	}
	{msg[1] == \trig_4} {
		("contr -> trig_4 " + msg[2]);

		if(msg[2] == 'on', {
			//"turning on".postln;
				if(perfData.active == false, {
					"activating delay".postln;
					perfData.active = true;
					~netDel.set(\scale, 1);
				});
			if(perfData.perf3.trig4.state == false, {
				perfData.perf3.trig4.state = true;
				if(perfData.perf3.trig4.timestamp.notNil, {
					if(perfData.perf3.trig4.offDur.size == 10, {
						perfData.perf3.trig4.offDur.pop;
					});
					perfData.perf3.trig4.offDur.addFirst(
						time - perfData.perf3.trig4.timestamp
					)
				});
				perfData.perf3.trig4.timestamp = time;

				~perf_3.set(\gate, 1);
			});
		});

		if(msg[2] == 'off', {
			//"turning off".postln;
			if(perfData.perf3.trig4.state == true, {
					perfData.perf3.trig4.state = false;
				if(perfData.perf3.trig4.timestamp.notNil, {
					if(perfData.perf3.trig4.onDur.size == 10, {
						perfData.perf3.trig4.onDur.pop;
					});
					perfData.perf3.trig4.onDur.addFirst(
						time - perfData.perf3.trig4.timestamp
					)
				});
				perfData.perf3.trig4.timestamp = time;

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