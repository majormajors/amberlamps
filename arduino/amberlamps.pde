#include <LiquidCrystal.h>
#define LIGHTS 2

boolean lights = false;
char command;
char current_byte;
LiquidCrystal lcd(7,8,9,10,11,12);

void setup(){
  pinMode(LIGHTS, OUTPUT);
  lcd.begin(16,2);
  digitalWrite(LIGHTS, HIGH);
  Serial.begin(9600);
}

void loop(){
  if(Serial.available()){
    command = Serial.read();
    switch(command){
      case 'L':
        switchLights();
        break;

      case 'N':
      case 'P':
        setDisplay();
        break;
        
      case 'C':
        lcd.clear();
        break;
    }
  }
}

void switchLights(){
  while(1){
    if(Serial.available()){
      current_byte = Serial.read();
      break;
    }
  }
  switch(current_byte){
    case '0':
      digitalWrite(LIGHTS, HIGH); break;    
    case '1':
      digitalWrite(LIGHTS, LOW); break;
  }
}

void setDisplay(){
  switch(command){
    case 'N':
      lcd.setCursor(0,0);
      break;
    case 'P':
      lcd.setCursor(0,1);
      break;
    default:
      lcd.clear();
  }
  
  for(int i = 0; i <= 16;){
    if(Serial.available()){
      current_byte = Serial.read();
      if(current_byte == '\n') break;
      lcd.write(current_byte);
      ++i;
    }
  }
}
