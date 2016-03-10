// Author: K. Michael Fox
// email: kmichaelfox.contact@gmail.com
// website: http://kmichaelfox.com
(
SynthDef(\master, { |in, out = 0, gate = 1|
	var osc, env;

	osc = In.ar(in, 9);

	env = osc * EnvGen.kr(Env.adsr(releaseTime:(60 * 4), curve:-10), gate, doneAction:0);

	Out.ar(out, FreeVerb.ar(env, 0.2, 5, 0.8));
}).add;

SynthDef(\netDelay, { |in1, in2, in3, in4, in5, scale = 0, out = 0, delay_feedback = 0.9|
	var feedback, sig1, sig2, sig3, sig4, sig5, delay;

	feedback = LPF.ar(EnvGen.ar(Env.adsr(attackTime: (15 * 60), curve: 0), scale) * LocalIn.ar(5), 400);
	//feedback = LPF.ar(LocalIn.ar(5), 400);

	sig1 = In.ar(in1) + (feedback[0] * delay_feedback);
	sig2 = In.ar(in2) + (feedback[1] * delay_feedback);
	sig3 = In.ar(in3) + (feedback[2] * delay_feedback);
	sig4 = /*In.ar(in4) + */(feedback[3] * delay_feedback);
	sig5 = /*In.ar(in5) + */(feedback[4] * delay_feedback);

	delay = DelayN.ar(
		[
			sig1,
			sig2,
			sig3,
			sig4 + In.ar(in4),
			sig5 + In.ar(in5)
	    ], 1.5, [Rand(0.5, 1.5), Rand(0.5, 1.5), Rand(0.5, 1.5), Rand(0.5, 1.5), Rand(0.5, 1.5)]);

	LocalOut.ar([
		TWChoose.ar( Dust.ar(0.9), delay, [0.05, 0.2375, 0.2375, 0.2375, 0.2375] ),
		TWChoose.ar( Dust.ar(1.1), delay, [0.2375, 0.05, 0.2375, 0.2375, 0.2375] ),
		TWChoose.ar( Dust.ar(1.3), delay, [0.2375, 0.2375, 0.05, 0.2375, 0.2375] ),
		TWChoose.ar( Dust.ar(1.0), delay, [0.2375, 0.2375, 0.2375, 0.05, 0.2375] ),
		TWChoose.ar( Dust.ar(1.2), delay, [0.2375, 0.2375, 0.2375, 0.2375, 0.05] )
	]);

		//Out.ar(out,
		//	Pan4.ar(sig1, -0.75, -0.75) +
		//	Pan4.ar(sig2, -0.75, 0.75) +
		//	Pan4.ar(sig3, 0.75, -0.75) +
		//	Pan4.ar(sig4, 0.75, 0.75) +
		//	Pan4.ar(sig5)
		//);
	  Out.ar(out,
			Pan4.ar(sig1, -0.75, 0.75) +
			Pan4.ar(sig2, -0.75, 0) +
			Pan4.ar(sig3, -0.75, -0.75) +
			Pan4.ar(sig4, 0.75, 0.75) +
			Pan4.ar(sig5, 0.75, -0.75)
		);


}).add;

SynthDef(\trig_1, { |out = 0|
	var osc, env, sig;

	osc = BPF.ar(WhiteNoise.ar(0.5), 10000, XLine.ar(Rand(0.01, 0.3), Rand(0.01, 0.3), 0.3)) + (EnvGen.ar(Env.perc(1, 0.5), doneAction:0) * SinOsc.ar((2 + (12 * 3)).midicps));

	env = EnvGen.ar(Env.perc(releaseTime: 0.3), doneAction: 2);

	sig = osc * env;

	Out.ar(out, sig);
}).add;

SynthDef(\trig_2, { |out = 0|
	var osc, env, sig;

	osc = BPF.ar(WhiteNoise.ar(0.5), 20000, XLine.ar(Rand(0.01, 0.3), Rand(0.01, 0.3), 0.3)) + (EnvGen.ar(Env.perc(1, 0.5), doneAction:0) * SinOsc.ar((2 + (12 * 3)).midicps));

	env = EnvGen.ar(Env.perc(releaseTime: 0.3), doneAction: 2);

	sig = osc * env;

	Out.ar(out, sig);
}).add;

SynthDef(\trig_3, { |out = 0|
	var osc, env, sig;

	osc = BPF.ar(WhiteNoise.ar(0.5), 8000, XLine.ar(Rand(0.01, 0.3), Rand(0.01, 0.3), 0.3)) + (EnvGen.ar(Env.perc(1, 0.5), doneAction:0) * SinOsc.ar((2 + (12 * 3)).midicps));

	env = EnvGen.ar(Env.perc(releaseTime: 0.3), doneAction: 2);

	sig = osc * env;

	Out.ar(out, sig);
}).add;

SynthDef(\trig_4, { |out = 0|
	var osc, env, sig;

	osc = BPF.ar(WhiteNoise.ar(0.5), 16000, XLine.ar(Rand(0.01, 0.3), Rand(0.01, 0.3), 0.3)) + (EnvGen.ar(Env.perc(1, 0.5), doneAction:0) * SinOsc.ar((2 + (12 * 3)).midicps, mul:0.4));

	env = EnvGen.ar(Env.perc(releaseTime: 0.3), doneAction: 2);

	sig = osc * env;

	Out.ar(out, sig);
}).add;

SynthDef(\trig_b, { |out = 0|
	var freq, osc, env, sig;

	freq = [0, 1, 3, 9];

	freq = Select.kr(freq, IRand(0, freq.size - 1)) + (12 * 10);

	osc = EnvGen.ar(Env.perc(0.2, 0.1))*BPF.ar(WhiteNoise.ar(0.6), 16000, XLine.ar(Rand(0.01, 0.3), Rand(0.01, 0.3), 0.5)) + (EnvGen.ar(Env.perc(1, 0.5), doneAction:0) * Mix.ar(SinOsc.ar(([2, 10] + (12 * 3)).midicps * Rand(0.9, 1.1), mul:1)));

	//osc = [Mix.ar(SinOsc.ar([freq - 12, freq, freq + 3, freq + 5].midicps, mul:0.01)) + (BrownNoise.ar(0.01) * PinkNoise.ar(0.01)), BPF.ar(WhiteNoise.ar(0.5), 16000, XLine.ar(Rand(0.01, 0.3), Rand(0.01, 0.3), 0.3)) + (EnvGen.ar(Env.perc(1, 0.5), doneAction:0) * SinOsc.ar((2 + (12 * 3)).midicps, mul:0.4))];

	env = EnvGen.ar(Env.perc(releaseTime: [0.4, 0.2]), doneAction: 2);

	sig = MulAdd(osc * env, SinOsc.kr(30 + SinOsc.kr(0.2, mul: 3), mul:0.5, add:0.5));

	Out.ar(out, sig);
}).add;

SynthDef(\trig_n, { |out = 0|
	var osc, env, sig;

	//freq = [0, 1, 3, 9];

	//freq = Select.kr(freq, IRand(0, freq.size - 1)) + (12 * 10);

	//osc = BPF.ar(WhiteNoise.ar(0.5), 16000, XLine.ar(Rand(0.01, 0.3), Rand(0.01, 0.3), 0.3)) + (EnvGen.ar(Env.perc(1, 0.5), doneAction:0) * SinOsc.ar((2 + (12 * 3)).midicps, mul:0.4));

	osc = [SinOsc.ar(20000 + Rand(-3, 3), mul:0.1) + PinkNoise.ar(Dust.ar(4, 0.1)), BPF.ar(WhiteNoise.ar(0.5), 16000, XLine.ar(Rand(0.01, 0.3), Rand(0.01, 0.3), 0.3)) + (EnvGen.ar(Env.perc(1, 0.5), doneAction:0) * SinOsc.ar((2 + (12 * 3)).midicps, mul:0.4))];

	env = EnvGen.ar(Env.perc(releaseTime: [1, 0.3]), doneAction: 2);

	sig = Mix.ar(osc * env);

	Out.ar(out, sig);
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

	env = EnvGen.kr(Env.adsr(3, curve:5), gate, doneAction: 0);

	sig = osc * env;

	Out.ar(out, sig);//Pan2.ar(sig, pan));
}).add;

SynthDef(\perf_2_pad, {|pan = 0, gate = 0, out = 0|
	var osc, env, sig;
	//350
	osc = BPF.ar(Mix.ar(
		SinOsc.ar((WhiteNoise.ar(0.2) + (TChoose.kr(Latch.kr(gate, Changed.kr(gate)), [0, 2, 3, 5]) + (12 * 4)).midicps) * [0.98, 1, 1.01,  2, 2.02, 4], mul: 0.5 + WhiteNoise.ar(0.05))), 350, Dust.kr(5, 0.2, 0.09), 5).clip(-1, 1);
	/*osc = BPF.ar(WhiteNoise.ar(0.5), Latch.ar(700 * SinOsc.kr(0.01, mul:0.02, add: 1), Dust.kr(0.3)), 0.05);*/

	env = EnvGen.kr(Env.adsr(3, curve:6), gate, doneAction: 0);

	sig = osc * env;

	Out.ar(out, sig);//Pan2.ar(sig, pan));
}).add;

SynthDef(\perf_3_pad, {|pan = 0, gate = 0, out = 0|
	var freq, osc, env, sig;

	freq = TChoose.kr(Changed.kr(gate),[0, 2, 3, 5]) + (12 * 3);

	//osc = Mix.ar(SinOsc.ar(410 * [0.5, 0.98, 1, 1.01,  2, 4], mul: 0.05));
	osc = Mix.ar(LPF.ar(LFTri.ar((freq + [0, 3, 5]).midicps, 0, 0.6), freq.midicps)).clip(-0.8, 0.8);

	env = EnvGen.kr(Env.adsr(3, curve:8), gate, doneAction: 0);

	sig = osc * env;

	Out.ar(out, sig);//Pan2.ar(sig, pan));
}).add;

SynthDef(\perf_4_pad, {|pan = 0, gate = 0, out = 0|
	var freq, osc, env, sig, mod_mod_freq, mod_freq, car_freq, mod_mod_amp, mod_amp, car_amp, mod_modulator, modulator, carrier;

	mod_mod_freq = 45;
	car_freq = 3;
	mod_freq = 4;
	mod_mod_amp = 3;
	car_amp = 0.5;
	mod_amp = 30;

	mod_modulator = SinOsc.ar(mod_mod_freq, mul:mod_mod_amp);
	modulator = SinOsc.ar(mod_freq, mod_modulator, mod_amp);
	carrier = SinOsc.ar(car_freq, modulator, car_amp, 1.5);

	freq = TChoose.kr(Latch.kr(gate, Changed.kr(gate)),[0, 1, 2, 7, 8]) + (12 * 7);

	//osc = Mix.ar(SinOsc.ar(410 * [0.5, 0.98, 1, 1.01,  2, 4], mul: 0.05));
	osc = Mix.ar(LPF.ar(LFTri.ar((freq + [0, 3, 5]).midicps), freq * 2 * carrier)).clip(-1, 1);

	env = EnvGen.kr(Env.adsr(3, curve:8), gate, doneAction: 0);

	sig = (osc * env) * 1.1;

	Out.ar(out, sig);
}).add;

SynthDef(\perf_5_pad, {|pan = 0, gate = 0, out = 0|
	var freq, osc, env, sig;

	freq = TRand.kr(0.01, 0.15, Latch.kr(gate, Changed.kr(gate)));

	//osc = Mix.ar(SinOsc.ar(410 * [0.5, 0.98, 1, 1.01,  2, 4], mul: 0.05));
	//osc = Mix.ar(LPF.ar(LFTri.ar((freq + [0, 3, 5]).midicps, 0, 0.8), freq.midicps)).clip(-1, 1);

	osc = (NTube.ar(PinkNoise.ar*SinOsc.ar(0.25, mul:0.25, add: 0.75),`[0.97,1.0,1.0,1.0,1.0,0.97],`[0.5,   0.9   ,0.2,-0.4],`([0.01,0.02,0.01,0.005,0.05]*freq))*0.1).dup;

	env = EnvGen.kr(Env.adsr(5, 1, curve:\lin), gate, doneAction: 0);

	sig = osc * env;

	Out.ar(out, sig);//Pan2.ar(sig, pan));
}).add;

SynthDef(\connect_on, { |out = 0|
	var freq, osc, env, sig;

	freq = (2 + (12 * 6)).midicps / [16, 1];
	//freq = 2 + (12 * 6);

	osc = SinOsc.ar(SinOsc.ar(freq, mul:15) + freq, 0, 0.15);

	env = EnvGen.ar(Env.perc([0.01, 0.2], [0.05, 0.3]), doneAction:2);
	//env = EnvGen.ar(Env.perc(0.2, 0.2), doneAction:2);

	sig = Mix.ar(osc * env);
	//sig = osx * env;

	Out.ar(out, sig);
}).add;

SynthDef(\connect_off, { |out = 0|
	var freq, osc, env, sig;

	freq = (9 + (12 * 5)).midicps / [16, 1];
	//freq = 7 + (12 * 5);

	osc = SinOsc.ar(SinOsc.ar(freq, mul:15) + freq, 0, 0.15);

	env = EnvGen.ar(Env.perc([0.01, 0.2], [0.05, 0.3]), doneAction:2);
	//env = EnvGen.ar(Env.perc(0.2, 0.2), doneAction:2);

	sig = Mix.ar(osc * env);
	//sig = osc * env;

	Out.ar(out, sig);
}).add;

SynthDef(\lights, { |out = 0, dur = 5|
	var freq, osc, env, sig;

	freq = IRand(0,3) + (12 * 3);

	osc = LPF.ar(LFTri.ar(freq.midicps, mul:0.1), freq.midicps);

	env = EnvGen.kr(Env([0, 1, 1, 0], [dur / 5 * 2, dur / 5, dur / 5 * 2]), doneAction:2);

	sig = env * osc;

	Out.ar(out, Pan4.ar(sig, Dust2.kr(2), Dust2.kr(2)));
}).add;
)

//~master.set(\gate, 0);
//~outputBus.index;