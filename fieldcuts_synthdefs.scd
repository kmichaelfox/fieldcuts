(
SynthDef(\master, { |in, out = 0, gate = 1|
	var osc, env;

	osc = In.ar(in, 2);

	env = osc * EnvGen.kr(Env.adsr(releaseTime:(60 * 4), curve:-10), gate, doneAction:0);

	Out.ar(out, FreeVerb.ar(env, 0.2, 5, 0.8));
}).add;

SynthDef(\networkDelay, { |in, out = nil, del_1 = nil, del_2 = nil, scale = 1, pan = 0|
	var local, pass, delay_sig, feedback_pan;

	local = In.ar(in);

	pass = Pan2.ar(local, pan);

	feedback_pan = TChoose.ar(Dust2.ar(Rand(1, 1.5)), [DC.ar(0), DC.ar(1)]);//Rand(0.2, 1));

	delay_sig = AllpassN.ar(local * 0.9, 2.5, Rand(1, 1.5), mul:scale);

	if(out.notNil, { Out.ar(out, pass); });

	//if(del_1.notNil && del_2.notNil, {
		Out.ar(del_1, delay_sig * feedback_pan);
		Out.ar(del_2, delay_sig * (1 - feedback_pan));
	//});

	//if(del_2.notNil, { Out.ar(del_2, Pan2.ar(delay_sig, Dust2.ar(3))); });
}).add;

SynthDef(\netDelay, { |in1, in2, in3, out = 0|
	var feedback, sig1, sig2, sig3, delay;

	feedback = LocalIn.ar(3);

	sig1 = In.ar(in1) + (feedback[0] * 0.8);
	sig2 = In.ar(in2) + (feedback[1] * 0.8);
	sig3 = In.ar(in3) + (feedback[2] * 0.8);

	delay = DelayN.ar([sig1, sig2, sig3], 1.5, [Rand(0.5, 1), Rand(0.5, 1), Rand(0.5, 1)]);

	LocalOut.ar([
		TChoose.ar( Dust.ar(0.5), delay ),
		TChoose.ar( Dust.ar(0.7), delay ),
		TChoose.ar( Dust.ar(0.9), delay )
	]);

	Out.ar(out, Pan2.ar(sig1, -1) + Pan2.ar(sig2, 0) + Pan2.ar(sig3, 1));


}).add;

SynthDef(\trig_1, { |pan = 0, out = 0|
	var osc, env, sig;

	osc = BPF.ar(WhiteNoise.ar(0.5), 10000, XLine.ar(Rand(0.01, 0.3), Rand(0.01, 0.3), 0.3));

	env = EnvGen.ar(Env.perc(releaseTime: 0.3), doneAction: 2);

	sig = osc * env;

	Out.ar(out, Pan2.ar(sig, pan));
}).add;

SynthDef(\trig_2, { |pan = 0, out = 0|
	var osc, env, sig;

	osc = BPF.ar(WhiteNoise.ar(0.5), 20000, XLine.ar(Rand(0.01, 0.3), Rand(0.01, 0.3), 0.3));

	env = EnvGen.ar(Env.perc(releaseTime: 0.3), doneAction: 2);

	sig = osc * env;

	Out.ar(out, Pan2.ar(sig, pan));
}).add;

SynthDef(\trig_3, { |pan = 0, out = 0|
	var osc, env, sig;

	osc = BPF.ar(WhiteNoise.ar(0.5), 8000, XLine.ar(Rand(0.01, 0.3), Rand(0.01, 0.3), 0.3));

	env = EnvGen.ar(Env.perc(releaseTime: 0.3), doneAction: 2);

	sig = osc * env;

	Out.ar(out, Pan2.ar(sig, pan));
}).add;

SynthDef(\trig_4, { |pan = 0, out = 0|
	var osc, env, sig;

	osc = BPF.ar(WhiteNoise.ar(0.5), 16000, XLine.ar(Rand(0.01, 0.3), Rand(0.01, 0.3), 0.3));

	env = EnvGen.ar(Env.perc(releaseTime: 0.3), doneAction: 2);

	sig = osc * env;

	Out.ar(out, Pan2.ar(sig, pan));
}).add;

SynthDef(\perf_1_pad, {|pan = 0, gate = 0, out = 0|
	var osc, env, sig;

	//osc = Mix.ar(SinOsc.ar(220 * [0.5, 0.98, 1, 1.01,  2, 4], mul: 0.05));
	osc =  BPF.ar(
		PinkNoise.ar,
		SinOsc.kr(
			SinOsc.kr(
				0.01,
				0,
				0.01,
				0.11),
			0,
			200,
			300
		) * (
			SinOsc.ar(
				20,
				0,
				0.3,
				0.8
		) * SinOsc.ar(
				50,
				0,
				0.3,
				0.9)
		),
		Saw.kr(
			0.1,  // freq
			//0, // iphase
			0.2, // mul
			0.21 // add
		), 5
	);//.clip(-0.5, 0.5); // insurance

	env = EnvGen.kr(Env.adsr, gate, doneAction: 0);

	sig = osc * env;

	Out.ar(out, sig);//Pan2.ar(sig, pan));
}).add;

SynthDef(\perf_2_pad, {|pan = 0, gate = 0, out = 0|
	var osc, env, sig;
	//350
	osc = BPF.ar(Mix.ar(LFTri.ar((WhiteNoise.ar(1) + TRand.kr(250, 400, Changed.kr(gate))) * [0.5, 0.98, 1, 1.01,  2, 2.02, 4], mul: 0.5)), 350, Dust.kr(5, 0.2, 0.08), 5).clip(-1, 1);

	env = EnvGen.kr(Env.adsr, gate, doneAction: 0);

	sig = osc * env;

	Out.ar(out, sig);//Pan2.ar(sig, pan));
}).add;

SynthDef(\perf_3_pad, {|pan = 0, gate = 0, out = 0|
	var freq, osc, env, sig;

	freq = TChoose.kr(Changed.kr(gate),[0, 2, 3, 5]) + (12 * 3);

	//osc = Mix.ar(SinOsc.ar(410 * [0.5, 0.98, 1, 1.01,  2, 4], mul: 0.05));
	osc = Mix.ar(LPF.ar(LFTri.ar((freq + [0, 3, 5]).midicps, 0, 0.8), freq.midicps)).clip(-1, 1);

	env = EnvGen.kr(Env.adsr, gate, doneAction: 0);

	sig = osc * env;

	Out.ar(out, sig);//Pan2.ar(sig, pan));
}).add;
)

//~master.set(\gate, 0);
//~outputBus.index;