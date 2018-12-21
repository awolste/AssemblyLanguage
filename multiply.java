/*
Andrew Wolstenholme (awolste)
2300 - 002
Program 2
October 23, 2018
Description:    This program shows the steps for binary multiplication of 2 8 bit binary numbers
                converted from user given decimal numbers
*/
import java.util.*;
public class multiply {
    public static void main(String[] args) {

        Scanner keyboard = new Scanner (System.in);
        int multiplicand;
        int multiplier;
        String intermediate;
        String mdr;
        String acc;
        String mq;
        String c;

        System.out.print("multiplicand: ");
        multiplicand = keyboard.nextInt();
        //exit if bad input
        if (multiplicand < 0 || multiplicand > 255) {
            System.out.println("Must be within range of 0 to 255.");
            System.exit(0);
        }

        //exit if bad input
        System.out.print("multiplier: ");
        multiplier = keyboard.nextInt();
        if (multiplier < 0 || multiplier > 255) {
            System.out.println("Must be within range of 0 to 255.");
            System.exit(0);
        }

        //initialize to 0s
        c = "0";
        acc = "00000000";
        //convert input
        mq = toBinary(multiplier);
        mdr = toBinary(multiplicand);
        System.out.println("c and acc set to 0");
        System.out.println("mq set to multiplier    =   " + multiplier + " decimal and " + mq + " binary");
        System.out.println("mdr set to multiplicand =   " + multiplicand + " decimal and " + mdr + " binary");

        int step = 1;
        while(step < 9){
            System.out.println("---------------------------------------------------");
            System.out.println("Step " + step + ":   " + c + " " + acc + " " + mq);
            //if the last bit in mq denotes an add or not
            if (mq.charAt(mq.length() - 1) == '0'){
                System.out.println("        +   00000000        ^ no add based on lsb=0");
            }
            else{
                System.out.println("        +   "+ mdr + "        ^ add based on lsb=1");
                //add acc and mdr if last bit was a 1
                //acc = binaryAdd(acc, mdr);
                int tempACC = Integer.parseInt(acc, 2);
                int tempMDR = Integer.parseInt(mdr, 2);
                //add numbers, becomes decimal
                int sum = tempACC + tempMDR;
                //if 100000000 or greater there is a carry
                if (sum > 255)
                    c = "1";
                else
                    c = "0";
                //turn back into binary
                String temp = toBinary(sum);
                if (temp.length() > 8)
                    temp = temp.substring(temp.length()-8);
                acc = temp;
            }
            System.out.println("          ----------");
            System.out.println("          " + c + " " + acc + " " + mq);
            System.out.println("       >>                     shift right");
            //concatenate 17 bits to be shifted
            intermediate = "" + c + acc + mq;
            //set mq, acc, and carry from substring of the concatenation of c, acc and mq
            c = "0";
            //carry becomes the first bit in acc
            acc = intermediate.substring(0, 8);
            //drop last bit (17)
            mq = intermediate.substring(8, 16);
            System.out.println("          " + c + " " + acc + " " + mq);
            step ++;
        }
        System.out.println("---------------------------------------------------");
        System.out.println("check:                 binary   decimal");
        System.out.println("                     " + toBinary(multiplicand) + "        " +  multiplicand);
        System.out.println("           x         " + toBinary(multiplier) + "  x     " + multiplier);
        System.out.println("             ----------------    ------");
        System.out.println("             " + ("" + acc + mq) + "      " + (multiplicand * multiplier));
    }

    /*
            This function converts an int in decimal form (base 10) given as a parameter
            to a String of equivalent binary bits
     */
    private static String toBinary(int dec){
        int remainder;
        String bin = "";
        if (dec == 0)
            bin += 0;
        //while decimal is not 0
        while(dec > 0)
        {
            //mod takes the remainder of decimal divided by 2
            remainder = dec % 2;
            //add remainder to front of binary string
            bin = remainder + bin;
            //divide and update decimal
            dec = dec / 2;
        }
        //turn binary string into integer
        int temp = Integer.parseInt(bin);
        //formatting with padded 0s requires input of an int, turns into a string
        return String.format("%08d", temp);
    }
}