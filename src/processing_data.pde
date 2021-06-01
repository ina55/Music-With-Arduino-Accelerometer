import processing.serial.*;
import java.awt.event.KeyEvent;
import java.io.IOException;

Serial myPort;

String data = "";
float roll, pitch, rbe;

void settings() {
	System.setProperty("jogl.disable.openglcore", "true");
	size(960, 640, P3D);
}

void setup() {
	String portName = Serial.list()[32];

	// starts the serial communication
	myPort = new Serial(this, portName, 9600); 
	serialEvent(myPort);
}

void draw() {
	translate(width / 2, height / 2, 0);
	background(33);
	textSize(22);
	if (roll != 0 && pitch !=0) {
		text("Roll: " + int(roll) + "   Pitch: " + int(pitch) + "   Rbe: " + int(rbe), -100, 265);
	}

	rotateX(radians(roll));
	rotateZ(radians(-pitch));

	textSize(10);
	fill(0, 76, 153);
	box(186, 140, 200);
}

void serialEvent(Serial myPort) {
	data = myPort.readStringUntil('\n');
	println(data);

	if (data != null) {
		data = trim(data);
		String items[] = split(data, '/');
		if (items.length > 1) {
			roll = float(items[0]);
			pitch = float(items[1]);
			rbe = float(items[2]);
		}
	}
}
