import processing.io.I2C;
// MCP4725 is a Digital-to-Analog converter using I2C
// datasheet: http://ww1.microchip.com/downloads/en/DeviceDoc/22039d.pdf
MCP4725 dac;

void MCP7425Setup(){
   dac = new MCP4725(I2C.list()[0], 0x60); 
}

void MCP7425Write(float volt)
 {
   dac.setAnalog(map(volt, 0, 5, 0.0, 1.00));   
 }
 
class MCP4725 extends I2C {
  int address;

  // there can be more than one device connected to the bus
  // as long as they have different addresses
  MCP4725(String dev, int address) {
    super(dev);
    this.address = address;
  }

  // outputs voltages from 0V to the supply voltage
  // (works with 3.3V and 5V)
  void setAnalog(float fac) {
    fac = constrain(fac, 0.0, 1.0);
    // convert to 12 bit value
    int val = int(4095 * fac);
    beginTransmission(address);
    write(val >> 8);
    write(val & 255);
    endTransmission();
  }
  
 
}
