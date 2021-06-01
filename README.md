# Music With Arduino & Accelerometer

### Files
In src/ directory there are 2 files:
 * _music_with_arduino_accelerometer.ino_ -> code for Arduino Uno board
 * _processing_data.pde_ -> code for displaying the accelerometer 
							movement on computer

### Libraries
	I2Cdev.h
	MPU6050.h
	LedControl.h
	Keypad.h
	Wire.h

### Short description
	My project is about implementing a musical instrument, built with
	Arduino UNO, using an accelerometer and gyroscope module for 
	interaction and movement processing.

	The goal of this project is getting familiar with both Arduino and
	MPU-6050 sensors from the accelerometer.

### Code and Implementation
	.ino file:

	/ Musical keynotes & scales /
	Firstly, I have defined keynotes and scales. 
	In "melodies" vector we have 6 scales of keys, coresponding to
	the 6 themes that I set for our instrument.

	/ Connection with MPU-6050 sensor /
	In setup() function:
	I take the I2C address of the MPU-6050 (0x68) and then set to 0,
	so that we wake up the sensor.
	For calibration, we will also set the flag on the three addresses 
	that I use to read data for axis x, y and z.

	In loop() function:
	I request from the MPU address, and begin the transmission.
	As we want to have a masurement for acceleration, rotation and time,
	we will need a total amount of 14 registers (one for time measurement,
	two for an axis measurement - and we have 3 axis for acceleration and
	3 axis for rotation). 

	/ 8x8 Leds Matrix ouput /
	Using an LedControl object, we want to display the processed data
	from accelerometer on the matrix of leds. So, I map the acceleration
	values into [0, 8] range and compute HIGH on the led coresponding to
	the position we obtained.

	/ Keypad interaction /
	We will use an Keypad object to read keys.
	For a key representing a digit from 1 to 6, I will change the theme of
	the instrument into the scale on that index in the melodies vector.
	On pressing 'A', I will activate one more speaker to sound.
	There are 3 stagers of volume: so pressing 'A' three times means getting
	into the first stage of volume.
	On pressing 'B', a little song with the keynotes from the current theme
	will play.

	/ Accelerometer Movement Sounds /
	After getting the proper data from the sensor, I will activate
	a correspondent sound from the current theme. The sound is the mapped
	value from initial data into [0, 10] range, as there are 10 keynotes
	into a scale in out program.

	.pde file:
	/ Receiving the data /
	We wait from the serial port to get some events.
	The port is the 32th port from my PC (dev/tty/USB0), but it 
	depends on your PC configurations and SO.

	As I sent the roll, pitch and rbe values (datas for x, y and z axis),
	separated with "/", in the processing data code I will split
	on this character. 
	Then, I will use function of rotation for getting the proper movement
	on the object we designed.

	/ Output /
	The output will be displayed on a pop-up window, if you use
	the processing IDE listed below.

### IDEs
	https://www.arduino.cc/en/software
	https://processing.org/download/