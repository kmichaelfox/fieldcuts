(
~perf_1.stop;
~perf_1 = Synth(\perf_1_pad, [\gate, 1]);
)




// ideas:
osc =  BPF.ar(PinkNoise.ar, SinOsc.kr(PinkNoise.kr(200, 300), 0, 10, 30) + (Latch.kr(Dust.kr(10, 2000, 200), Dust.kr(2))), 0.01 + Crackle.kr(1.5, 0.2)).clip(-1, 1);

Server.local.options.device_("AudioBox USB");

s.scope;

~netDel[0].set(\scale, 0);
~netDel[1].set(\scale, 0);
~netDel[2].set(\scale, 0);

~netDel.set(\scale, 0);

1.9.asInteger%2

p.pop

Server.local.options.numOutputBusChannels
Server.local.options.outputStreamsEnabled_(nil);
Server.local.options.outputStreamsEnabled
Server.local.options.numOutputBusChannels;
Server.local.options.numOutputBusChannels_(9);
s.boot;

(
var f = {
	var mod_modulator, modulator, carrier, mod_mod_freq, car_freq, mod_freq, mod_mod_amp, car_amp, mod_amp;

	mod_mod_freq = 440;
	car_freq = 220;
	mod_freq = 700;
	mod_mod_amp = 20;
	car_amp = 0.5;
	mod_amp = 30;

	mod_modulator = SinOsc.ar(mod_mod_freq, mul:mod_mod_amp);
	modulator = SinOsc.ar(mod_freq, mod_modulator, mod_amp);
	carrier = SinOsc.ar(car_freq, modulator, car_amp, 1.5);
};
f.plot
)
~p4.plot