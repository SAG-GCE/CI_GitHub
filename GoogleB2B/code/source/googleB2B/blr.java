package googleB2B;

// -----( IS Java Code Template v1.2
// -----( CREATED: 2016-05-06 10:20:44 IST
// -----( ON-HOST: MCBHP01.eur.ad.sag

import com.wm.data.*;
import com.wm.util.Values;
import com.wm.app.b2b.server.Service;
import com.wm.app.b2b.server.ServiceException;
// --- <<IS-START-IMPORTS>> ---
import java.util.Date;
import java.text.ParseException;
import java.text.SimpleDateFormat;
// --- <<IS-END-IMPORTS>> ---

public final class blr

{
	// ---( internal utility methods )---

	final static blr _instance = new blr();

	static blr _newInstance() { return new blr(); }

	static blr _cast(Object o) { return (blr)o; }

	// ---( server methods )---




	public static final void currentTimeStamp (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(currentTimeStamp)>> ---
		// @sigtype java 3.5
		// [o] field:0:required currentDateTime
		String currentDateTime = new SimpleDateFormat("yyyyMMddHHmmssSSS").format(new Date());
		 IDataCursor pipelineCursor = pipeline.getCursor();
		 IDataUtil.put( pipelineCursor, "currentDateTime", currentDateTime );
		 pipelineCursor.destroy();
			
		// --- <<IS-END>> ---

                
	}



	public static final void getTimeDiffInMills (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(getTimeDiffInMills)>> ---
		// @sigtype java 3.5
		// [i] field:0:required startTime
		// [i] field:0:required endTime
		// [o] field:0:required difference
		IDataCursor pipelineCursor = pipeline.getCursor();
		String	start = IDataUtil.getString( pipelineCursor, "startTime" );
		String	end = IDataUtil.getString( pipelineCursor, "endTime" );
		pipelineCursor.destroy();
		
		SimpleDateFormat format = new SimpleDateFormat("HHmmssSSS");
		
		
		try {
			Date date1 = format.parse(start);
			Date date2 = format.parse(end);
			long difference = date2.getTime() - date1.getTime();
			IDataCursor pipelineCursor_1 = pipeline.getCursor();
			IDataUtil.put( pipelineCursor_1, "difference", String.valueOf(difference) );
			pipelineCursor_1.destroy();
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
			
		// --- <<IS-END>> ---

                
	}



	public static final void sleep (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(sleep)>> ---
		// @sigtype java 3.5
		try {
		Thread.sleep(50);                 //1000 milliseconds is one second.
		} catch(InterruptedException ex) {
		Thread.currentThread().interrupt();
		}
		// --- <<IS-END>> ---

                
	}
}

