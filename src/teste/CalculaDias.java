package teste;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.Locale;


public class CalculaDias {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		Date initialDate = null;
		Date finalDate = null;
		try {
	        SimpleDateFormat sdf =
	            new SimpleDateFormat( "dd/MM/yyyy", new Locale( "pt_BR" ) );
	        initialDate = sdf.parse( "01/01/2016" );
	    } catch ( ParseException e ) {
	    	e.printStackTrace();
	    }
		try {
	        SimpleDateFormat sdf =
	            new SimpleDateFormat( "dd/MM/yyyy", new Locale( "pt_BR" ) );
	        finalDate = sdf.parse( "31/01/2016" );
	    } catch ( ParseException e ) {
	    	e.printStackTrace();
	    }
		
		
		//Date finalDate = new Date( "31/01/2016");
		
		//Date initialDate = new Date("01/01/2016");
		int days = ( int ) ( ( finalDate.getTime() - initialDate.getTime() )/( 24*60*60*1000 ) );
		System.out.println(days);
		
		int workingDays = 0;
		Calendar calendar = new GregorianCalendar( finalDate.getYear(), finalDate.getMonth(), finalDate.getDay() );
		for (int i = 1; i <= days; i++)
		{
			if( !( calendar.get(Calendar.DAY_OF_WEEK) == Calendar.SATURDAY ) && !( calendar.get(Calendar.DAY_OF_WEEK) == Calendar.SUNDAY ) ) {
				workingDays++;
			}
			calendar.add( Calendar.DATE, 1 );			
		}
		
		System.out.println(workingDays);


	}

}
