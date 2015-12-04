(
// load program modules (gui and synth defs)
(thisProcess.nowExecutingPath.dirname +/+ "fieldcuts*.scd").loadPaths;

// execute other code
~perf_1 = Synth(\perf_1_pad, [\pan, 1]);
~perf_2 = Synth(\perf_2_pad, [\pan, 0]);
~contr = Synth(\perf_3_pad, [\pan, -1]);

OSCFunc({ |msg, time, addr, recvPort|
	var x = case
	{msg[1] == \trig_1} {
		//("perf_1 -> trig_1 " + msg[2]).postln;
		Synth(\trig_1, [\pan, 1]);

		if(msg[2] == 'on;', {
			//"turning on".postln;
			~perf_1.set(\gate, 1);
		});

		if(msg[2] == 'off;', {
			"turning off".postln;
			~perf_1.set(\gate, 0);
		});
	}
	{msg[1] == \trig_2} {
		//("perf_1 -> trig_2 " + msg[2]).postln;
		Synth(\trig_2, [\pan, 1]);

		if(msg[2] == 'on;', {
			//"turning on".postln;
			~perf_1.set(\gate, 1);
		});

		if(msg[2] == 'off;', {
			//"turning off".postln;
			~perf_1.set(\gate, 0);
		});
	}
	{msg[1] == \trig_3} {
		//("perf_1 -> trig_3 " + msg[2]).postln;
		Synth(\trig_3, [\pan, 1]);

		if(msg[2] == 'on;', {
			//"turning on".postln;
			~perf_1.set(\gate, 1);
		});

		if(msg[2] == 'off;', {
			//"turning off".postln;
			~perf_1.set(\gate, 0);
		});
	}
	{msg[1] == \trig_4} {
		//("perf_1 -> trig_4 " + msg[2]).postln;
		Synth(\trig_4, [\pan, 1]);

		if(msg[2] == 'on;', {
			//"turning on".postln;
			~perf_1.set(\gate, 1);
		});

		if(msg[2] == 'off;', {
			//"turning off".postln;
			~perf_1.set(\gate, 0);
		});
	};

	//x.postln;
}, '/fieldcuts/perf_1');

OSCFunc({ |msg, time, addr, recvPort|
	var x = case
	{msg[1] == \trig_1} {
		//("perf_2 -> trig_1 " + msg[2]);
		Synth(\trig_1, [\pan, 0]);

		if(msg[2] == 'on;', {
			//"turning on".postln;
			~perf_2.set(\gate, 1);
		});

		if(msg[2] == 'off;', {
			//"turning off".postln;
			~perf_2.set(\gate, 0);
		});
	}
	{msg[1] == \trig_2} {
		//("perf_2 -> trig_2 " + msg[2]);
		Synth(\trig_2, [\pan, 0]);

		if(msg[2] == 'on;', {
			//"turning on".postln;
			~perf_2.set(\gate, 1);
		});

		if(msg[2] == 'off;', {
			//"turning off".postln;
			~perf_2.set(\gate, 0);
		});
	}
	{msg[1] == \trig_3} {
		//("perf_2 -> trig_3 " + msg[2]);
		Synth(\trig_3, [\pan, 0]);

		if(msg[2] == 'on;', {
			//"turning on".postln;
			~perf_2.set(\gate, 1);
		});

		if(msg[2] == 'off;', {
			//"turning off".postln;
			~perf_2.set(\gate, 0);
		});
	}
	{msg[1] == \trig_4} {
		//("perf_2 -> trig_4 " + msg[2]);
		Synth(\trig_4, [\pan, 0]);

		if(msg[2] == 'on;', {
			//"turning on".postln;
			~perf_2.set(\gate, 1);
		});

		if(msg[2] == 'off;', {
			//"turning off".postln;
			~perf_2.set(\gate, 0);
		});
	};

	//x.postln;
}, '/fieldcuts/perf_2');

OSCFunc({ |msg, time, addr, recvPort|
	var x = case
	{msg[1] == \trig_1} {
		//("contr -> trig_1 " + msg[2]);
		Synth(\trig_1, [\pan, -1]);

		if(msg[2] == 'on;', {
			//"turning on".postln;
			~contr.set(\gate, 1);
		});

		if(msg[2] == 'off;', {
			//"turning off".postln;
			~contr.set(\gate, 0);
		});
	}
	{msg[1] == \trig_2} {
		//("contr -> trig_2 " + msg[2]);
		Synth(\trig_2, [\pan, -1]);

		if(msg[2] == 'on;', {
			//"turning on".postln;
			~contr.set(\gate, 1);
		});

		if(msg[2] == 'off;', {
			//"turning off".postln;
			~contr.set(\gate, 0);
		});
	}
	{msg[1] == \trig_3} {
		//("contr -> trig_3 " + msg[2]);
		Synth(\trig_3, [\pan, -1]);

		if(msg[2] == 'on;', {
			//"turning on".postln;
			~contr.set(\gate, 1);
		});

		if(msg[2] == 'off;', {
			//"turning off".postln;
			~contr.set(\gate, 0);
		});
	}
	{msg[1] == \trig_4} {
		//("contr -> trig_4 " + msg[2]);
		Synth(\trig_4, [\pan, -1]);

		if(msg[2] == 'on;', {
			//"turning on".postln;
			~contr.set(\gate, 1);
		});

		if(msg[2] == 'off;', {
			//"turning off".postln;
			~contr.set(\gate, 0);
		});
	};

	//x.postln;
}, '/fieldcuts/contr');
)