import java.util.Scanner;
import java.io.*;

public class DBInit {

   public static void main(String[] args) throws IOException {
       File db = new File("DBContents.txt");
      /*if(args[0]!=null)
         db = new File(args[0]);
      else{
         System.out.println("No DB specified");
         return;
      }*/
      Scanner fileSc = new Scanner(db);
      PrintWriter fileOut = new PrintWriter("DBContentsCode.m");
      final String DS = "dayStart";
      final String DE = "dayEnd";
      final String ES = "eventStart";
      final String EE = "eventEnd";
      int counter = 0;
      while(fileSc.hasNextLine()){
         String line = fileSc.nextLine();
         if(line.contains(DS)==true){
            String dayTime = fileSc.nextLine();
            String dayDate = fileSc.nextLine();
            line = fileSc.nextLine();
         }
         while(line.contains(DE)!=true){
            String eventTime = line;
            String eventLocation = fileSc.nextLine();     
            String eventTitle = fileSc.nextLine();
            line = fileSc.nextLine();
            String eventDescription = "";
            while(line.contains(EE)!=true){
               eventDescription += line;
               line = fileSc.nextLine();
            }
            line = fileSc.nextLine();
            fileOut.println("[event["+counter+"] setEventTime:@\""+eventTime+"\"];");
            fileOut.println("[event["+counter+"] setEventLocation:@\""+eventLocation+"\"];");
            fileOut.println("[event["+counter+"] setEventTitle:@\""+eventTitle+"\"];");
            fileOut.println("[event["+counter+"] setEventDescription:@\""+eventDescription+"\"];");
            counter++;
         }
      }
      fileOut.close();
   }
}
