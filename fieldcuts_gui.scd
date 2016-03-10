// Author: K. Michael Fox
// email: kmichaelfox.contact@gmail.com
// website: http://kmichaelfox.com
(
var gui = gui ? (),
data = data ? ();
//0, 11 29 2015 19 14 34 2915849 perf_1 trig_1 on;
data.sampleID = 0;
data.month = 1;
data.day = 2;
data.year = 3;
data.hour = 4;
data.minute = 5;
data.second = 6;
data.tick = 7;
data.perfID = 8;
data.trigID = 9;
data.state = 10;

//
// Global gui code and data
//
gui.title = "fieldcuts";
gui.width = 450;
gui.height = 200;
gui.margin = 10;
gui.panelBrightness = 0.5;
gui.dataFilePath = "";
gui.fileReader = nil;
gui.counter = 0;
gui.timeStamp = 0;
gui.loopback = NetAddr("127.0.0.1", NetAddr.langPort);

gui.counterRoutine = Routine({
	loop({
		//gui.counter = gui.counter + 1;
		//"looping".postln;
		//1.wait;
		//gui.fileReader[gui.counter][data.tick].postln;
		//gui.timeStamp.postln;
		if(gui.fileReader[gui.counter][data.tick].asInteger > gui.timeStamp, {
			((1/60) * (gui.fileReader[gui.counter][data.tick].asInteger - gui.timeStamp.asInteger)).wait;

			gui.timeStamp = gui.fileReader[gui.counter][data.tick].asInteger;
		});

		if(gui.counter >= gui.fileReader.size,
			{
				"Reached end of data".postln;
				gui.counterRoutine.stop;
			}, {
				//"sampling".postln;
				gui.loopback.sendMsg(
					"/fieldcuts/" ++ gui.fileReader[gui.counter][data.perfID].asString,
					gui.fileReader[gui.counter][data.trigID],
					gui.fileReader[gui.counter][data.state]
				);

				gui.counter = gui.counter + 1;

				gui.paramPanel.curPosCounter.string_(gui.counter.asString);
			}
		);
	});
});

Window.closeAll;
gui.w = Window
.new(gui.title, Rect(0, 0, gui.width, gui.height))
.front;

//
// Heading panel gui code
//
gui.headingPanel = gui.headingPanel ? ();

gui.headingPanel.width = gui.width - (gui.margin * 2);
gui.headingPanel.height = 75;

gui.headingPanel.view = CompositeView(gui.w,
	Rect(gui.margin,
		gui.margin,
		gui.headingPanel.width,
		gui.headingPanel.height))
.background_(Color.gray(gui.panelBrightness));

gui.headingPanel.titleText = StaticText(gui.headingPanel.view,
	Rect(gui.margin,
		gui.margin,
		200,
		gui.headingPanel.height - (gui.margin * 2)))
.string_(gui.title)
.font_(Font("Helvetica", 24))
.front;

gui.headingPanel.loadTrigDataButton = Button(gui.headingPanel.view,
	Rect(gui.headingPanel.width - (200 + gui.margin), // x
		gui.margin, // y
		200, // w
		25)) // h
.states_([
	["Load Data", Color.black, Color.gray(0.8)]
])
.action_({
	Dialog.openPanel({ |path|
		gui.dataFilePath = path; gui.dataFilePath.postln;
		gui.headingPanel.trigDataFilePathText.string_(path);

		/*if(gui.fileReader.notNil, {
			if(gui.fileReader.isOpen, {gui.fileReader.close;});
			gui.fileReader = nil;
		});*/

		gui.fileReader = FileReader.read(gui.dataFilePath);
		//gui.fileReader.inspect;
		gui.paramPanel.setup.value;
	}, {
		"cancelled".postln;
	});
});

gui.headingPanel.trigDataFilePathText = TextField(gui.headingPanel.view,
	Rect(gui.headingPanel.width - (200 + gui.margin), // x
		30 + (gui.margin), // y
		200, // w
		25))
.string_("no file selected")
.stringColor_(Color.gray(0.4))
.enabled_(false);

//
// Parameter panel gui code
//
gui.paramPanel = gui.paramPanel ? ();
gui.paramPanel.helperText = gui.paramPanel.helperText ? ();

gui.paramPanel.x = gui.margin;
gui.paramPanel.y = gui.headingPanel.height + (gui.margin * 2);
gui.paramPanel.width = gui.width - (gui.margin * 2);
gui.paramPanel.height = gui.height - (gui.headingPanel.height + (gui.margin * 3));
gui.paramPanel.verticalOffset = 30 + (gui.margin * 2);

gui.paramPanel.view = CompositeView(gui.w,
	Rect(gui.paramPanel.x,
		gui.paramPanel.y,
		gui.paramPanel.width,
		gui.paramPanel.height))
.background_(Color.gray(gui.panelBrightness));

gui.paramPanel.setup = {
	gui.paramPanel.curPosCounter.string_("0");
	gui.paramPanel.lengthCounter.string_((gui.fileReader.size - 1).asString);
	gui.paramPanel.runButton.states_([
		["Run", Color.black, Color.gray(0.8)],
		["Stop", Color.black, Color.gray(0.8)]
	]);
	gui.paramPanel.runButton.enabled_(true);
	gui.paramPanel.resetButton.states_([["Reset",Color.black,Color.gray(0.8)]]);
	gui.paramPanel.resetButton.enabled_(true);
	gui.timeStamp = gui.fileReader[0][data.tick].asInteger;
	gui.timeStamp.postln;
};

gui.paramPanel.title = StaticText(gui.paramPanel.view,
	Rect(gui.margin, gui.margin, 100, 30))
.string_("Parameters")
.font_(Font("Helvetica", 16));

gui.paramPanel.runButton = Button(gui.paramPanel.view,
	Rect(gui.paramPanel.width - (200 + gui.margin),
		gui.margin,
		95,
		30))
.states_([
	["Run", Color.gray, Color.gray(0.8)]
])
.action_({ |state|
	if(state.value == 1,
		{
			"running".postln;
			if(gui.counter == 0,
				{
					gui.counterRoutine.play(AppClock);
				},{
					"restarting".postln;
					gui.counterRoutine.reset;
					gui.counterRoutine.play(AppClock);
				}
			);
		},{
			"stopping".postln;
			gui.counterRoutine.stop;
		}
	);
})
.enabled_(false);

gui.paramPanel.resetButton = Button(gui.paramPanel.view,
	Rect(gui.paramPanel.width - (95 + gui.margin),
		gui.margin,
		95,
		30))
.states_([
	["Reset", Color.gray, Color.gray(0.8)]
])
.action_({
	gui.counter = 0;
	gui.timeStamp = gui.fileReader[0][data.tick].asInteger;
	gui.paramPanel.curPosCounter.string_(gui.counter.asString);
	//gui.paramPanel.runButton.value_(1);
	gui.counterRoutine.reset;
})
.enabled_(false);

gui.paramPanel.curPosLabel = StaticText(gui.paramPanel.view,
	Rect(gui.margin,
		gui.paramPanel.verticalOffset,
		150,
		15))
.string_("Position / Samples");

gui.paramPanel.curPosCounter = TextView(gui.paramPanel.view,
	Rect(gui.margin,
		gui.paramPanel.verticalOffset + (0 * 50 + 15),
		75,
		25))
.enabled_(false);

gui.paramPanel.helperText.lengthSlashText = StaticText(gui.paramPanel.view,
	Rect(gui.margin + 82,
		gui.paramPanel.verticalOffset + (0 * 50 + 15),
		20,
		25))
.string_("of");

gui.paramPanel.lengthCounter = TextView(gui.paramPanel.view,
	Rect(gui.margin + 100,
		gui.paramPanel.verticalOffset + (0 * 50 + 15),
		75,
		25))
.enabled_(false);

// shortcut
// gui.dataFilePath = "/Users/kellyfox/Desktop/fieldcuts_dev_112915_dataStream/sample_data/fieldcuts_dev_112915_run_1_trig.txt";
// gui.dataFilePath.postln;
// gui.headingPanel.trigDataFilePathText.string_("/Users/kellyfox/Desktop/fieldcuts_dev_112915_dataStream/sample_data/fieldcuts_dev_112915_run_1_trig.txt");
//
// /*if(gui.fileReader.notNil, {
// if(gui.fileReader.isOpen, {gui.fileReader.close;});
// gui.fileReader = nil;
// });*/
//
// gui.fileReader = FileReader.read(gui.dataFilePath);
// //gui.fileReader.inspect;
// gui.paramPanel.setup.value;
)