

// -----( IS Java Code Template v1.2
// -----( CREATED: 2016-05-06 10:20:46 IST
// -----( ON-HOST: MCBHP01.eur.ad.sag

import com.wm.data.*;
import com.wm.util.Values;
import com.wm.app.b2b.server.Service;
import com.wm.app.b2b.server.ServiceException;
// --- <<IS-START-IMPORTS>> ---
import java.util.Random;
// --- <<IS-END-IMPORTS>> ---

public final class Service

{
	// ---( internal utility methods )---

	final static Service _instance = new Service();

	static Service _newInstance() { return new Service(); }

	static Service _cast(Object o) { return (Service)o; }

	// ---( server methods )---




	public static final void getRandomNumber (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(getRandomNumber)>> ---
		// @sigtype java 3.5
		// [o] field:0:required number
		Random randomGenerator = new Random();		
		long randomLong = randomGenerator.nextLong(); 
		
		// pipeline
		IDataCursor pipelineCursor = pipeline.getCursor();
		IDataUtil.put( pipelineCursor, "number", randomLong );
		pipelineCursor.destroy();
		
			
		// --- <<IS-END>> ---

                
	}
}

