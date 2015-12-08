(
// pre-initialize data tracking space
var performerData = performerData ? ();

performerData.perf1 = performerData.perf1 ? ();
performerData.perf1.trig1 = performerData.perf1.trig1 ? ();
performerData.perf1.trig2 = performerData.perf1.trig2 ? ();
performerData.perf1.trig3 = performerData.perf1.trig3 ? ();
performerData.perf1.trig4 = performerData.perf1.trig4 ? ();
"this far".postln;
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





// load program modules (gui and synth defs)
(thisProcess.nowExecutingPath.dirname +/+ "fieldcuts*.scd").loadPaths;





// execute other code
~outputBus = Bus.audio(s, 2);
~master = Synth(\master, [\in, ~outputBus.index]);

~perf_1 = Synth(\perf_1_pad, [\pan, 1, \out, ~outputBus.index]);
~perf_2 = Synth(\perf_2_pad, [\pan, 0, \out, ~outputBus.index]);
~perf_3 = Synth(\perf_3_pad, [\pan, -1, \out, ~outputBus.index]);

OSCFunc({ |msg, time, addr, recvPort|
	var x = case
	{msg[1] == \trig_1} {
		//("perf_1 -> trig_1 " + msg[2]).postln;

		if(msg[2] == 'on;', {
			//"turning on".postln;
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

		if(msg[2] == 'off;', {
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

		Synth(\trig_1, [\pan, 1, \out, ~outputBus.index]);
	}
	{msg[1] == \trig_2} {
		//("perf_1 -> trig_2 " + msg[2]).postln;

		if(msg[2] == 'on;', {
			//"turning on".postln;
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

		if(msg[2] == 'off;', {
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

		Synth(\trig_2, [\pan, 1, \out, ~outputBus.index]);
	}
	{msg[1] == \trig_3} {
		//("perf_1 -> trig_3 " + msg[2]).postln;

		if(msg[2] == 'on;', {
			//"turning on".postln;
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

		if(msg[2] == 'off;', {
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

		Synth(\trig_3, [\pan, 1, \out, ~outputBus.index]);
	}
	{msg[1] == \trig_4} {
		//("perf_1 -> trig_4 " + msg[2]).postln;

		if(msg[2] == 'on;', {
			//"turning on".postln;
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

		if(msg[2] == 'off;', {
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

		Synth(\trig_4, [\pan, 1, \out, ~outputBus.index]);
	};

	//x.postln;
}, '/fieldcuts/perf_1');

OSCFunc({ |msg, time, addr, recvPort|
	var x = case
	{msg[1] == \trig_1} {
		//("perf_2 -> trig_1 " + msg[2]);

		if(msg[2] == 'on;', {
			//"turning on".postln;
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

		if(msg[2] == 'off;', {
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

		Synth(\trig_1, [\pan, 0, \out, ~outputBus.index]);
	}
	{msg[1] == \trig_2} {
		//("perf_2 -> trig_2 " + msg[2]);

		if(msg[2] == 'on;', {
			//"turning on".postln;
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

		if(msg[2] == 'off;', {
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

		Synth(\trig_2, [\pan, 0, \out, ~outputBus.index]);
	}
	{msg[1] == \trig_3} {
		//("perf_2 -> trig_3 " + msg[2]);

		if(msg[2] == 'on;', {
			//"turning on".postln;
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

		if(msg[2] == 'off;', {
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

		Synth(\trig_3, [\pan, 0, \out, ~outputBus.index]);
	}
	{msg[1] == \trig_4} {
		//("perf_2 -> trig_4 " + msg[2]);

		if(msg[2] == 'on;', {
			//"turning on".postln;
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

		if(msg[2] == 'off;', {
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

		Synth(\trig_4, [\pan, 0, \out, ~outputBus.index]);
	};

	//x.postln;
}, '/fieldcuts/perf_2');

OSCFunc({ |msg, time, addr, recvPort|
	var x = case
	{msg[1] == \trig_1} {
		//("contr -> trig_1 " + msg[2]);

		if(msg[2] == 'on;', {
			//"turning on".postln;
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

		if(msg[2] == 'off;', {
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

		Synth(\trig_1, [\pan, -1, \out, ~outputBus.index]);
	}
	{msg[1] == \trig_2} {
		//("contr -> trig_2 " + msg[2]);

		if(msg[2] == 'on;', {
			//"turning on".postln;
			if(performerData.perf3.trig2.state == false, {
				performerData.perf3.trig3.state = true;
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

		if(msg[2] == 'off;', {
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

		Synth(\trig_2, [\pan, -1, \out, ~outputBus.index]);
	}
	{msg[1] == \trig_3} {
		//("contr -> trig_3 " + msg[2]);

		if(msg[2] == 'on;', {
			//"turning on".postln;
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

		if(msg[2] == 'off;', {
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

		Synth(\trig_3, [\pan, -1, \out, ~outputBus.index]);
	}
	{msg[1] == \trig_4} {
		//("contr -> trig_4 " + msg[2]);

		if(msg[2] == 'on;', {
			//"turning on".postln;
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

		if(msg[2] == 'off;', {
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

		Synth(\trig_4, [\pan, -1, \out, ~outputBus.index]);
	};

	//x.postln;
}, '/fieldcuts/contr');
)