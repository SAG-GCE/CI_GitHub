package googleB2B.services;

// -----( IS Java Code Template v1.2
// -----( CREATED: 2016-05-05 16:16:09 IST
// -----( ON-HOST: MCBHP01.eur.ad.sag

import com.wm.data.*;
import com.wm.util.Values;
import com.wm.app.b2b.server.Service;
import com.wm.app.b2b.server.ServiceException;
// --- <<IS-START-IMPORTS>> ---
import java.net.InetAddress;
import java.net.UnknownHostException;
import com.wm.util.Debug;
import java.io.*;
import java.util.*;
import java.lang.System;
import com.wm.app.b2b.server.*;
import com.wm.util.Table;
import java.text.*;
import com.wm.lang.ns.*;
// --- <<IS-END-IMPORTS>> ---

public final class Simulation

{
	// ---( internal utility methods )---

	final static Simulation _instance = new Simulation();

	static Simulation _newInstance() { return new Simulation(); }

	static Simulation _cast(Object o) { return (Simulation)o; }

	// ---( server methods )---




	public static final void sleep (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(sleep)>> ---
		// @sigtype java 3.5
		// [i] field:0:required milisecToWait
		IDataCursor cursor = pipeline.getCursor();
		
		long millis = 0;
		
		System.console().printf(cursor.getValue().toString());
		millis = (Long)cursor.getValue();
		
		
		try {
			Thread.sleep(millis);
		} 
		catch (InterruptedException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		
			
		// --- <<IS-END>> ---

                
	}

	// --- <<IS-START-SHARED>> ---
	/**
	 * Used by "deepConvert"
	 * 
	 */
	private static final Values convert(Hashtable hT)
	{
	  // Following statement gets all arrays in this object.
	  boolean nullFlag = false;
	  Object[] hTArray = hT.values().toArray();
	  Enumeration hTEnumeration = hT.keys();
	  Values outbound = new Values();
	
	  for (int i = 0; i < hTArray.length; i++)
	  {
	    String key = (String) hTEnumeration.nextElement();
	    if (hTArray[i] instanceof java.lang.String)
	    {
	      outbound.put(key, (String) hTArray[i]);
	    }
	    else if (hTArray[i] instanceof java.util.Hashtable)
	    {
	      Values internalObject = convert((Hashtable) hTArray[i]);
	      if (internalObject == null)
	      {
	        nullFlag = true;
	        return null;
	      }
	      outbound.put(key, internalObject);
	    }
	    else
	    {
	      System.out.println("Conversion Failure:" + "unsupported type within inbound Hashtable.");
	      return null;
	    }
	  }
	  return outbound;
	}
	
	public static final int MAXSLEEP = 3600000; // one hr
		
	// --- <<IS-END-SHARED>> ---
}

