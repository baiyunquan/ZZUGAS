#include <stdio.h>

int main(void) {
    fputs(
        "10 | 0 1 2 3 4 5 6 7 8 9 A B C D E F\n"
        "-- + --------------------------------\n"
        "20 |  ! \" # $ % & ' ( ) * + , - . /\n"
        "30 |0 1 2 3 4 5 6 7 8 9 : ; < = > ?\n"
        "40 |@ A B C D E F G H I J K L M N O\n"
        "50 |P Q R S T U V W X Y Z [ \\ ] ^ _\n"
        "60 |` a b c d e f g h i j k l m n o\n"
        "70 |p q r s t u v w x y z { | } ~\n",
        stdout);
    return 0;
}