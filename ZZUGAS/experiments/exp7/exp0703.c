// Lang C Assistance

#define EFL_NUM 6
#define EFL_CF  ((unsigned int)0x00000001U)  // Bit 0
#define EFL_PF  ((unsigned int)0x00000004U)  // Bit 2
#define EFL_AF  ((unsigned int)0x00000010U)  // Bit 4
#define EFL_ZF  ((unsigned int)0x00000040U)  // Bit 6
#define EFL_SF  ((unsigned int)0x00000080U)  // Bit 7
#define EFL_OF  ((unsigned int)0x00000800U)  // Bit 11

void dprflags() {
    const char * EFL_SIGNS  = "CZSOAP";
    unsigned int eflags = 0; // fake eflags
    int pos = 0;

    if ((eflags & EFL_CF) != 0) {
        pos++;
    }
    if ((eflags & EFL_PF) != 0) {
        pos++;
    }
    if ((eflags & EFL_AF) != 0) {
        pos++;
    }
    if ((eflags & EFL_ZF) != 0) {
        pos++;
    }
    if ((eflags & EFL_SF) != 0) {
        pos++;
    }
    if ((eflags & EFL_OF) != 0) {
        pos++;
    }
}

int main() {
    // Set flags
    dprflags(); // Print flags

    return 0;
}
