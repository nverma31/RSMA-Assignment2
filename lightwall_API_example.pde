  
  import processing.serial.*;
  import cc.arduino.*;
  int sample, sample1;
  Arduino arduino; //creates arduino object
  int sampleWindow = 50;
  Lightwall lw;
  
  
  color back = color(64, 218, 255); //variables for the 2 colors
  
  int sensor= 0;
  int read;
  int read2;
  
  float value;
  int count = 0;
  
  void setup() {
    lw = new Lightwall("http://127.0.0.1");
  
    size(800, 600);
    arduino = new Arduino(this, Arduino.list()[1], 57600); //sets up arduino
    println(arduino.list());
    arduino.pinMode(sensor, Arduino.INPUT);//setup pins to be input (A0 =0?)
  
    background(back);
  }
  
  void draw() {
  
  
    long startMillis= millis(); 
  
    // Start of sample window
    int peakToPeak = 0;   // peak-to-peak level
  
    int signalMax = 0;
    int signalMin = 1024;
    //unsigned long startMillis= millis();  // Start of sample window
    int peakToPeak1 = 0;   // peak-to-peak level
    int signalMax1 = 0;
    int signalMin1 = 1024;
    //long x = millis() - startMillis;
    //print(x);
    //while (x < 50.0) {
  
    //}
    while (millis() - startMillis < 1500.0)
    {
      sample = arduino.analogRead(0);
      sample1 = arduino.analogRead(1);
  
      if (sample < 1024)  // toss out spurious readings
      {
        if (sample > signalMax)
        {
          signalMax = sample;  // save just the max levels
        } else if (sample < signalMin)
        {
          signalMin = sample;  // save just the min levels
        }
      }
  
      if (sample1 < 1024)  // toss out spurious readings
      {
        if (sample1 > signalMax1)
        {
          signalMax1 = sample1;  // save just the max levels
        } else if (sample1 < signalMin1)
        {
          signalMin1 = sample1;  // save just the min levels
        }
      }
    }
    //sample = arduino.analogRead(0);
    //sample1 = arduino.analogRead(1);
    //if (sample > 750) {
    //println("sample" + sample);
    //}
    //if (sample1 > 750) {
    //println("sample1" + sample1);
    //}
    peakToPeak = signalMax - signalMin;  // max - min = peak-peak amplitude
    double volts = (peakToPeak * 5.0) / 1024;  // convert to volts
    if (volts > 2.75) {
      print("first");
      //print(count);
      //count++;
      
      lw.sweep(0,0,20,20,20);
      println(volts);
    }
  
    peakToPeak1 = signalMax1 - signalMin1;  // max - min = peak-peak amplitude
    double volts1 = (peakToPeak1 * 5.0) / 1024;  // convert to volts
    if (volts1 > 2.75) {
      print("second");
        lw.sweep(80,80,40,40,20);

      println(volts1);
    }
  }
  