# Pong-Game
A gesture based multiplayer pong game using a variety of inputs such as hand gestures, push buttons or light sensors. 

This project recreates the Pong Game and provides the user with number of options to play. It is developed in Assembly and is run on the DE-1 Soc FPGA board. It makes uses of NIOS-2 and hardwares such as flex sensors and LEGO electrical toolbox (light sensors). The score appears on the HEX display on the FPGA. It also makes use of the Analog to Digital converter(ADC) on the FPGA to convert the analog value of the flex sensor to discrete values, helping the user to move the pong bar. 
Connect the sensors to the GPIO pins on the FPGA by referring to the comments in the source code. The pong bar is moved by moving bending and unbending your fingers. The other player can use the light sensors which  responds to white and black surfaces to move. Finally, you can also use the push puttons to move the pong bar.

# Requirements:
1) Altera DE1-Soc FPGA:

You can also use any other FPGA boards, but you must modify the code accordingly.
![alt text](https://github.com/dumontvi/Pong-Game/blob/master/project_pics/DE1-SoC_top45_01.jpg)

2) Flex Sensors on Gloves:

Attach the strips to the gloves and when the strip is bent, it develops a resistance, which as a result gives you some analog output. The ADC on the board will help you convert this value to a digital input, but you have to set the threshold. 

![alt text](https://github.com/dumontvi/Pong-Game/blob/master/project_pics/flex_sensors%20(1).JPG)
![alt text](https://github.com/dumontvi/Pong-Game/blob/master/project_pics/flex_sensors%20(2).JPG)
![alt text](https://github.com/dumontvi/Pong-Game/blob/master/project_pics/flex_sensors%20(3).JPG)
![alt text](https://github.com/dumontvi/Pong-Game/blob/master/project_pics/flex_sensors%20(4).JPG)

3) Lego Light Sensors:

Will move in response to white and black surfaces.

![alt text](https://github.com/dumontvi/Pong-Game/blob/master/project_pics/light_Sensors.jpg)

4) Intel FPGA Monitor Program software: Software under downloads at "university.altera.com". Also read the Monitor Program Manual to setup the software and to learn its features.


