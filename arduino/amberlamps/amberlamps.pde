#include <LiquidCrystal.h>
#define LIGHTS 2
#define CMD_LIGHT 'L'
#define CMD_NAME  'N'
#define CMD_PRICE '$'
#define CMD_CLEAR 'C'

boolean lights = false;
char command;
char current_byte;
char buffer;
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
      case CMD_LIGHT:
        switchLights(); break;
      case CMD_NAME:
        displayName(); break;
      case CMD_PRICE:
        displayPrice(); break;
      case CMD_CLEAR:
        lcd.clear(); break;
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

void displayName(){
  lcd.setCursor(0,0);

  for(int i = 0; i <= 25;){
    if(Serial.available()){
      current_byte = Serial.read();
      if(current_byte == '\n') break;
      lcd.write(current_byte);

      if(i == 16) lcd.setCursor(0,1);

      ++i;
    }
  }
}

void displayPrice(){
  lcd.setCursor(10,1);
  
  for(int i = 0; i <= 6;){
    if(Serial.available()){
      current_byte = Serial.read();
      if(current_byte == '\n') break;
      lcd.write(current_byte);
      ++i;
    }
  }
}
