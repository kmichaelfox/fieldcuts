(
~perf_1.stop;
~perf_1 = Synth(\perf_1_pad, [\gate, 1]);
)




// ideas:
osc =  BPF.ar(PinkNoise.ar, SinOsc.kr(PinkNoise.kr(200, 300), 0, 10, 30) + (Latch.kr(Dust.kr(10, 2000, 200), Dust.kr(2))), 0.01 + Crackle.kr(1.5, 0.2)).clip(-1, 1);

Server.local.options.device_("AudioBox USB");

s.scope;

~netDel[0].set(\scale, 1);
~netDel[1].set(\scale, 1);
~netDel[2].set(\scale, 1);

1.9.asInteger%2