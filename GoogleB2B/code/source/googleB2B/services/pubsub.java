package googleB2B.services;

// -----( IS Java Code Template v1.2
// -----( CREATED: 2016-05-06 10:20:43 IST
// -----( ON-HOST: MCBHP01.eur.ad.sag

import com.wm.data.*;
import com.wm.util.Values;
import com.wm.app.b2b.server.Service;
import com.wm.app.b2b.server.ServiceException;
// --- <<IS-START-IMPORTS>> ---
import java.io.File;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.security.GeneralSecurityException;
import java.util.List;
import com.google.api.client.googleapis.auth.oauth2.GoogleCredential;
import com.google.api.client.googleapis.javanet.GoogleNetHttpTransport;
import com.google.api.client.http.HttpTransport;
import com.google.api.client.json.JsonFactory;
import com.google.api.client.json.jackson2.JacksonFactory;
import com.google.api.client.util.Lists;
import com.google.api.services.pubsub.Pubsub;
import com.google.api.services.pubsub.PubsubScopes;
import com.google.api.services.pubsub.model.PublishRequest;
import com.google.api.services.pubsub.model.PublishResponse;
import com.google.api.services.pubsub.model.PubsubMessage;
import com.google.api.services.pubsub.model.Topic;
// --- <<IS-END-IMPORTS>> ---

public final class pubsub

{
	// ---( internal utility methods )---

	final static pubsub _instance = new pubsub();

	static pubsub _newInstance() { return new pubsub(); }

	static pubsub _cast(Object o) { return (pubsub)o; }

	// ---( server methods )---




	public static final void publish2Topic (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(publish2Topic)>> ---
		// @sigtype java 3.5
		// [i] field:0:optional jasonPayLoad
		// [o] field:0:required messageID
		final Pubsub mypubsub;
		
		try { 
			
			IDataCursor pipelineInCursor = pipeline.getCursor();
			String JASONData= IDataUtil.getString( pipelineInCursor, "jasonPayLoad" );
			if (JASONData.equals(""))
				JASONData="No JASON Data";
			pipelineInCursor.destroy();
			String emailAddress = "account-2@sccs-pint-sandbox.iam.gserviceaccount.com";
			JsonFactory JSON_FACTORY = JacksonFactory.getDefaultInstance();
			HttpTransport httpTransport = GoogleNetHttpTransport.newTrustedTransport();
			//Yalkin's Note: Replace this with/home/sanjanbora/pubsub/SCCS-PINT-SANDBOX-cd631d89d614.p12
			GoogleCredential credential = new GoogleCredential.Builder()
			    .setTransport(httpTransport)
			    .setJsonFactory(JSON_FACTORY)
			    .setServiceAccountId(emailAddress)
			    .setServiceAccountPrivateKeyFromP12File(new File("/home/SoftwareAG98/pubsub/SCCS-PINT-SANDBOX-cd631d89d614.p12"))
			    .setServiceAccountScopes(PubsubScopes.all())
			    .build();
			mypubsub = new Pubsub.Builder(httpTransport, JSON_FACTORY, credential)
				.setApplicationName("sccs-pint-sandbox")
				.build();
			Pubsub.Projects.Topics topics = mypubsub.projects().topics();
		    //Topic newTopic = topics.create("projects/sccs-pint-sandbox/topics/ISServiceTopic01", new Topic()).execute();
			//Topic mynewTopic=createTopic("projects/sccs-pint-sandbox/topics/mytestTopicNew03");
			List<PubsubMessage> messages = Lists.newArrayList();
			messages.add(new PubsubMessage().encodeData(JASONData.getBytes("UTF-8")));
			PublishRequest publishRequest = new PublishRequest().setMessages(messages);
			PublishResponse publishResponse = mypubsub.projects().topics()
				.publish("projects/sccs-pint-sandbox/topics/PerfTestInboundTopic", publishRequest)
				.execute();
			String messageID=publishResponse.getMessageIds().get(0);
			IDataCursor pipelineOutCursor = pipeline.getCursor();
			pipelineOutCursor.last();
			pipelineOutCursor.insertAfter("messageID", messageID);
			pipelineOutCursor.destroy();
			} 
		
		catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (GeneralSecurityException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
			
		// --- <<IS-END>> ---

                
	}
}

