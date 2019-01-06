#include <iostream>
#include <fstream>
#include <string>

using namespace std;

  /*
 16bit Hi   Lo   Name/Function
 AF    A    -    Accumulator & Flags
 BC    B    C    BC
 DE    D    E    DE
 HL    H    L    HL
 SP    -    -    Stack Pointer
 PC    -    -    Program Counter/Pointer
  */

int AF_reg;
int BC_reg;
int DE_reg;
int HL_reg;
int SP_reg;
int PC_reg;


void init_cpu(){
/*
  AF=$01B0
  BC=$0013
  DE=$00D8
  HL=$014D
  Stack Pointer=$FFFE
*/
  AF_reg = 0x01B0;
  BC_reg = 0x0013;
  DE_reg = 0x00D8;
  HL_reg = 0x014D;
  SP_reg = 0xFFFE;
  PC_reg = 0x0000;
}

int run_cpu(int inst){
  switch(inst) {
    case 0x00 : //cout << "NOP";
                PC_reg += 1;
                return(0); 
                break;       
    case 0x01 : return(0);
                break;
    case 0x60 : cout << "LD H,B";
                HL_reg = (BC_reg && 0xFF00 ) | (HL_reg && 0xFF);
                return(0);
                break;
    case 0x3c : cout << "SRL";
                AF_reg = (AF_reg && 0xEF) | ((HL_reg && 0x1) >>4);
                HL_reg = HL_reg >> 1;
                PC_reg += 1;
                return(0);
                break;
    default: return(inst);
             break;
    }
}

int main(int argc, char **argv){
  streampos size;
  char * buffer; 

  ifstream file;

  file.open("cpu_instrs/cpu_instrs.gb", ios::in|ios::binary|ios::ate);
  if (file.is_open())
  {
     size = file.tellg();
     buffer = new char [size];
     file.seekg (0, ios::beg);
     file.read (buffer, size);
     file.close();

    //cout << "the entire file content is in memory";

    bool running;
    running = true;

    int g = 1;
    int lol;
    int nope;
    init_cpu();
    while(running == true){
      lol = int((unsigned char)(buffer[PC_reg]));
      nope = run_cpu(lol);
      if(nope = lol){ cout << nope; break; }
      //if(lol !=0) cout << lol << '\n';
    }
    delete[] buffer;
  }
  else cout << "Unable to open file";
  file.close(); 
}
