(
var gui = gui ? ();

//
// Global gui code and data
//
gui.title = "fieldcuts";
gui.width = 800;
gui.height = 500;
gui.margin = 10;
gui.panelBrightness = 0.5;
gui.dataFilePath = "";
gui.fileReader = nil;

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
		gui.dataFilePath = path;
		gui.headingPanel.trigDataFilePathText.string_(path);

		if(gui.fileReader.notNil, {
			if(gui.fileReader.isOpen, {gui.fileReader.close;});
			gui.fileReader = nil;
		});

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
};

gui.paramPanel.title = StaticText(gui.paramPanel.view,
	Rect(gui.margin, gui.margin, 100, 30))
.string_("Parameters")
.font_(Font("Helvetica", 16));

gui.paramPanel.curPos = "";
gui.paramPanel.length = "";

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
)