#include <iostream>
#include <fstream>
#include <string>


using namespace std;

int main(int argc, char **argv){
  streampos size;
  char * memblock; 

  ifstream file;

  file.open("cpu_instrs/cpu_instrs.gb", ios::in|ios::binary|ios::ate);
  if (file.is_open())
  {
    size = file.tellg();
    cout << size;
    memblock = new char [size];
    file.seekg (0, ios::beg);
    file.read (memblock, size);
    file.close();

    cout << "the entire file content is in memory";

    bool running;
    running = true;

    int g = 1;
    int lol;
    while(running == true){
      g ++;
      lol = memblock[g] | (uint8_t)memblock[g+1] << 4;
      if(lol !=0) cout << lol << '\n';
    }
    delete[] memblock;
  }
  else cout << "Unable to open file";
  file.close(); 
}
