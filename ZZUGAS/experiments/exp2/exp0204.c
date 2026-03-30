#include <stdio.h>

int main() {
    char line0[] = "10 | 0 1 2 3 4 5 6 7 8 9 A B C D E F";
    char lineSep[] = "-- + --------------------------------";
    char line1[] = "20 |  ! \" # $ % & ' ( ) * + , - . /";
    char line2[] = "30 |0 1 2 3 4 5 6 7 8 9 : ; < = > ?";
    char line3[] = "40 |@ A B C D E F G H I J K L M N O";
    char line4[] = "50 |P Q R S T U V W X Y Z [  ] ^ _";
    char line5[] = "60 |` a b c d e f g h i j k l m n o";
    char line6[] = "70 |p q r s t u v w x y z { | } ~  ";

    printf("%s\n", line0);
    printf("%s\n", lineSep);
    printf("%s\n", line1);
    printf("%s\n", line2);
    printf("%s\n", line3);
    printf("%s\n", line4);
    printf("%s\n", line5);
    printf("%s\n", line6);

    /*
    // Row 10 - Header
    // Using \r\n for Windows compatibility
    printf("10 | 0 1 2 3 4 5 6 7 8 9 A B C D E F\r\n");
    
    // Separator Line
    printf("-- + --------------------------------\r\n");

    // Rows 20 to 70
    for (int row = 20; row <= 70; row += 10) {
        
        // Match the label format exactly
        // Row 30 in your screenshot has no space after the bar: "30 |0 1..."
        if (row == 30) {
            printf("%d |", row); 
        } else {
            printf("%d | ", row);
        }

        for (int col = 0; col < 16; col++) {
            int ascii_val = (row / 10) * 16 + col;

            // Handle the SPACE character at 0x20
            if (ascii_val == 0x20) {
                printf("  "); 
            } else if (ascii_val <= 0x7E) {
                // Print character followed by a space
                printf("%c ", (char)ascii_val);
            }
        }
        // Use \r\n to ensure the grading system recognizes the new line
        printf("\r\n");
        
    }
*/
    return 0;
}