// MAX518 is a Digital-to-Analog converter using I2C
import processing.io.I2C;
import processing.io.*;
//MAX518 dac;

//void MAX518Setup(){
//   dac = new MAX518(I2C.list()[0], 0x2C); 
//}

void MAX518Write(float volt)
 {
   dac.setAnalog(map(volt, 0, 5, 0.0, 1.00));   
 }



class MAX518 extends I2C {
  int address;

  // there can be more than one device connected to the bus
  // as long as they have different addresses
  MAX518(String dev, int address) {
    super(dev);
    this.address = address;
  }

  // outputs voltages from 0V to the supply voltage
  // (works with 3.3V and 5V)
  void setAnalog(float fac) {
    fac = constrain(fac, 0.0, 1.0);
    // convert to 8 bit value
    int val = int(256 * fac);
    beginTransmission(address);
    write(0);
    write(val & 255);
    endTransmission();
  }
 }
