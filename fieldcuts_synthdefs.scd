(
SynthDef(\master, { |in, out = 0, gate = 1|
	var osc, env;

	osc = In.ar(in, 2);

	env = osc * EnvGen.kr(Env.adsr(releaseTime:(60 * 4), curve:-10), gate, doneAction:0);

	Out.ar(out, env);//FreeVerb.ar(env, 0.2, 5, 0.8));
}).add;

SynthDef(\trig_1, { |pan = 0, out = 0|
	var osc, env, sig;

	osc = BPF.ar(WhiteNoise.ar(0.1), 2000, XLine.ar(Rand(0.01, 0.3), Rand(0.01, 0.3), 0.3));

	env = EnvGen.ar(Env.perc(releaseTime: 0.3), doneAction: 2);

	sig = osc * env;

	Out.ar(out, Pan2.ar(sig, pan));
}).add;

SynthDef(\trig_2, { |pan = 0, out = 0|
	var osc, env, sig;

	osc = BPF.ar(WhiteNoise.ar(0.1), 4000, XLine.ar(Rand(0.01, 0.3), Rand(0.01, 0.3), 0.3));

	env = EnvGen.ar(Env.perc(releaseTime: 0.3), doneAction: 2);

	sig = osc * env;

	Out.ar(out, Pan2.ar(sig, pan));
}).add;

SynthDef(\trig_3, { |pan = 0, out = 0|
	var osc, env, sig;

	osc = BPF.ar(WhiteNoise.ar(0.1), 1000, XLine.ar(Rand(0.01, 0.3), Rand(0.01, 0.3), 0.3));

	env = EnvGen.ar(Env.perc(releaseTime: 0.3), doneAction: 2);

	sig = osc * env;

	Out.ar(out, Pan2.ar(sig, pan));
}).add;

SynthDef(\trig_4, { |pan = 0, out = 0|
	var osc, env, sig;

	osc = BPF.ar(WhiteNoise.ar(0.1), 8000, XLine.ar(Rand(0.01, 0.3), Rand(0.01, 0.3), 0.3));

	env = EnvGen.ar(Env.perc(releaseTime: 0.3), doneAction: 2);

	sig = osc * env;

	Out.ar(out, Pan2.ar(sig, pan));
}).add;

SynthDef(\perf_1_pad, {|pan = 0, gate = 0, out = 0|
	var osc, env, sig;

	osc = Mix.ar(SinOsc.ar(220 * [0.5, 0.98, 1, 1.01,  2, 4], mul: 0.05));

	env = EnvGen.kr(Env.adsr, gate, doneAction: 0);

	sig = osc * env;

	Out.ar(out, Pan2.ar(sig, pan));
}).add;

SynthDef(\perf_2_pad, {|pan = 0, gate = 0, out = 0|
	var osc, env, sig;

	osc = Mix.ar(SinOsc.ar(350 * [0.5, 0.98, 1, 1.01,  2, 4], mul: 0.05));

	env = EnvGen.kr(Env.adsr, gate, doneAction: 0);

	sig = osc * env;

	Out.ar(out, Pan2.ar(sig, pan));
}).add;

SynthDef(\perf_3_pad, {|pan = 0, gate = 0, out = 0|
	var osc, env, sig;

	osc = Mix.ar(SinOsc.ar(410 * [0.5, 0.98, 1, 1.01,  2, 4], mul: 0.05));

	env = EnvGen.kr(Env.adsr, gate, doneAction: 0);

	sig = osc * env;

	Out.ar(out, Pan2.ar(sig, pan));
}).add;
)

//~master.set(\gate, 0);
//~outputBus.index;