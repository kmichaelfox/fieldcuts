(
var gui = gui ? ();
gui.title = "fieldcuts synthdef test";
gui.width = 450;
gui.height = 100;
gui.margin = 20;
gui.buttonHeight = 25;
gui.buttonWidth = 50;

~p1 = Synth(\perf_1_pad, [\out, 0]);
~p2 = Synth(\perf_2_pad, [\out, 0]);
~p3 = Synth(\perf_3_pad, [\out, 0]);
~p4 = Synth(\perf_4_pad, [\out, 0]);
~p5 = Synth(\perf_5_pad, [\out, 0]);

(thisProcess.nowExecutingPath.dirname +/+ "fieldcuts_synthdefs.scd").loadPaths;

Window.closeAll;
gui.w = Window
.new(gui.title, Rect(0, 0, gui.width, gui.height))
.front;

//
// Pad 1
//
gui.pad1 = Button(gui.w, Rect(gui.margin, gui.height / 2 - (gui.buttonHeight / 2), 50, 25))
.states_([
	["Pad 1", Color.black, Color.gray(0.8)],
	["Pad 1", Color.black, Color.gray]

])
.action_({ |state|
	if(state.value == 1, {
		"setting 1".postln;
		~p1.set(\gate, 1);
	}, {
		"setting 0".postln;
		~p1.set(\gate, 0);
	});
});

//
// Pad 2
//
gui.pad2 = Button(gui.w, Rect(gui.margin + ((gui.buttonWidth + gui.margin)), gui.height / 2 - (gui.buttonHeight / 2), 50, 25))
.states_([
	["Pad 2", Color.black, Color.gray(0.8)],
	["Pad 2", Color.black, Color.gray]

])
.action_({ |state|
	if(state.value == 1, {
		"setting 1".postln;
		~p2.set(\gate, 1);
	}, {
		"setting 0".postln;
		~p2.set(\gate, 0);
	});
});

//
// Pad 3
//
gui.pad3 = Button(gui.w, Rect(gui.margin + ((gui.buttonWidth + gui.margin) * 2), gui.height / 2 - (gui.buttonHeight / 2), 50, 25))
.states_([
	["Pad 3", Color.black, Color.gray(0.8)],
	["Pad 3", Color.black, Color.gray]

])
.action_({ |state|
	if(state.value == 1, {
		"setting 1".postln;
		~p3.set(\gate, 1);
	}, {
		"setting 0".postln;
		~p3.set(\gate, 0);
	});
});

//
// Pad 4
//
gui.pad4 = Button(gui.w, Rect(gui.margin + ((gui.buttonWidth + gui.margin) * 3), gui.height / 2 - (gui.buttonHeight / 2), 50, 25))
.states_([
	["Pad 4", Color.black, Color.gray(0.8)],
	["Pad 4", Color.black, Color.gray]

])
.action_({ |state|
	if(state.value == 1, {
		"setting 1".postln;
		~p4.set(\gate, 1);
	}, {
		"setting 0".postln;
		~p4.set(\gate, 0);
	});
});

//
// Pad 5
//
gui.pad5 = Button(gui.w, Rect(gui.margin + ((gui.buttonWidth + gui.margin) * 4), gui.height / 2 - (gui.buttonHeight / 2), 50, 25))
.states_([
	["Pad 5", Color.black, Color.gray(0.8)],
	["Pad 5", Color.black, Color.gray]

])
.action_({ |state|
	if(state.value == 1, {
		"setting 1".postln;
		~p5.set(\gate, 1);
	}, {
		"setting 0".postln;
		~p5.set(\gate, 0);
	});
});
)
