import java.util.Scanner;
import java.io.*;

public class DBInit {

   public static void main(String[] args) throws IOException {
       File db;
      if(args[0]!=null)
         db = new File(args[0]);
      else{
         System.out.println("No DB specified");
         return;
      }
      Scanner fileSc = new Scanner(db);
      PrintWriter fileOut = new PrintWriter("DBContentsCode.m","UTF-8");
      boolean day = false;
      boolean event = false;
      final String DS = "dayStart";
      final String DE = "dayEnd";
      final String ES = "eventStart";
      final String EE = "eventEnd";
      int counter = 0;
      while(fileSc.hasNextLine()){
         String line = fileSc.nextLine();
         if(line.compareTo(DS)==0){
            String dayTime = fileSc.nextLine();
            String dayDate = fileSc.nextLine();
            line = fileSc.nextLine();
         }
         while(line.compareTo(DE)!=0){
            String eventTime = line;
            String eventLocation = fileSc.nextLine();     
            String eventTitle = fileSc.nextLine();
            String eventDescription = fileSc.nextLine();
            line = fileSc.nextLine();
            while(line.compareTo(EE)!=0){
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
