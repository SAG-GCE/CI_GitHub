
--********************************************************************
CREATE TABLE Partner (
       ParentPartnerID      CHAR(24) NULL,
       PartnerID            CHAR(24) NOT NULL,
       							 -- i18n, 64 to 255
       CorporationName      VARCHAR2(255) NOT NULL,
       							 -- i18n, 64 to 255
       OrgUnitName          VARCHAR2(255) NULL,
       Deleted              SMALLINT NOT NULL,
       Status               VARCHAR2(12) NOT NULL,
       Type                 CHAR(12) NOT NULL,
       Self                 SMALLINT NOT NULL,
       TNVersion            VARCHAR2(20) NULL,
       B2BcomMember	       SMALLINT DEFAULT 0 NULL 
)
   STORAGE( MAXEXTENTS UNLIMITED )
;

CREATE INDEX idx_Ptnr_CorpName_OrgUnitName ON Partner
(
       CorporationName                ASC,
       OrgUnitName                    ASC
);


ALTER TABLE Partner
       ADD  ( CONSTRAINT pk_Ptnr_PtnrId PRIMARY KEY (PartnerID) ) ;


--********************************************************************

CREATE TABLE BizDocAttributeDef (
									-- i18n, 64 to 255
      AttributeName        VARCHAR2(255) NOT NULL,
      AttributeID          CHAR(24) NOT NULL,
      							-- i18n, 256 to 1024 
      AttributeDescription VARCHAR2(1024) NULL,
      AttributeType        VARCHAR2(10) NOT NULL,
      Deleted              SMALLINT NOT NULL,
      LastModified         DATE NULL
)
   STORAGE( MAXEXTENTS UNLIMITED)
;

ALTER TABLE BizDocAttributeDef
      ADD  ( CONSTRAINT pk_BizDocAttDef_AttId PRIMARY KEY (AttributeID) ) ;
      
--********************************************************************

CREATE TABLE BizDocTypeDef (
									--i18n, 64 to 128
      TypeName             VARCHAR2(128) NOT NULL,
      TypeID               CHAR(24) NOT NULL,
      TypeDescription      VARCHAR2(256) NULL,
      TypeData             BLOB NOT NULL,
      Deleted              SMALLINT NOT NULL,
      LastModified         DATE NULL
)
   STORAGE (MAXEXTENTS UNLIMITED)
   LOB(TypeData) STORE AS ( STORAGE (MAXEXTENTS UNLIMITED) )
;

ALTER TABLE BizDocTypeDef
       ADD  ( CONSTRAINT pk_BizDocTypeDef_TypeId PRIMARY KEY (TypeID) ) ;

--********************************************************************

CREATE TABLE BinaryType (
      Type                 SMALLINT NOT NULL,
      							-- i18n 24 to 255
      Description          VARCHAR2(255) NOT NULL
)
   STORAGE( MAXEXTENTS UNLIMITED) 
;


ALTER TABLE BinaryType
      ADD  ( CONSTRAINT pk_BinaryType_Type PRIMARY KEY (Type) ) ;
      
      
--********************************************************************

CREATE TABLE ContactType (
      Type                 SMALLINT NOT NULL,
      							-- i18n, 24 to 128
      Description          VARCHAR2(128) NOT NULL
)
   STORAGE( MAXEXTENTS UNLIMITED)
;

ALTER TABLE ContactType
       ADD  ( CONSTRAINT pk_ContType_Type PRIMARY KEY (Type) ) ;


--********************************************************************

CREATE TABLE BizDoc (
      DocID                CHAR(24) NOT NULL,
      DocTypeID            CHAR(24) NULL,
      SenderID             CHAR(24) NOT NULL,
      ReceiverID           CHAR(24) NOT NULL,
      NativeID             VARCHAR2(100) NULL,
      DocTimestamp         DATE NOT NULL,
      RoutingStatus        VARCHAR2(20) NOT NULL,
      GroupID              VARCHAR2(100) NULL,
      ConversationID       VARCHAR2(300) NULL,
      							--i18n 100 to 255
      UserStatus           VARCHAR2(255) NULL,
      LastModified         DATE NULL
)
   STORAGE( MAXEXTENTS UNLIMITED) 
;

CREATE INDEX idx_BizDoc_DocTypeId ON BizDoc
(
      DocTypeID            ASC
);

CREATE INDEX idx_BizDoc_SenderId ON BizDoc
(
      SenderID             ASC
);

CREATE INDEX idx_BizDoc_ReceiverId ON BizDoc
(
      ReceiverID           ASC
);


ALTER TABLE BizDoc
      ADD  ( CONSTRAINT pk_BizDoc_DocId PRIMARY KEY (DocID) ) ;


ALTER TABLE BizDoc
       ADD  ( CONSTRAINT fk_BizDoc_ReceiverId_Ptnr FOREIGN KEY (ReceiverID)
                             REFERENCES Partner ) ;


ALTER TABLE BizDoc
       ADD  ( CONSTRAINT fk_BizDoc_SenderId_Ptnr FOREIGN KEY (SenderID)
                             REFERENCES Partner ) ;


ALTER TABLE BizDoc
       ADD  ( CONSTRAINT fk_BizDoc_DocTyId_BizDocTypDef FOREIGN KEY (DocTypeID)
                             REFERENCES BizDocTypeDef ) ;

--********************************************************************

CREATE TABLE BizDocArchive (
      DocID                CHAR(24) NOT NULL,
      ArchiveTimestamp     DATE DEFAULT SYSDATE NOT NULL,
      DocTimestamp         DATE NOT NULL,
      SenderCorp           VARCHAR2(64) NOT NULL,
      DocTypeName          VARCHAR2(64) NOT NULL,
      ReceiverCorp         VARCHAR2(64) NOT NULL,
      SenderOrgUnit        VARCHAR2(64) NULL,
      ReceiverOrgUnit      VARCHAR2(64) NULL
)
   STORAGE( MAXEXTENTS UNLIMITED)
;


ALTER TABLE BizDocArchive
      ADD  ( CONSTRAINT pk_BizDocArc_DocId PRIMARY KEY (DocID) ) ;
      

--********************************************************************

CREATE TABLE BizDocContentArchive (
       DocID		CHAR(24) NOT NULL,
       PartName		VARCHAR2(100) NOT NULL,
       MimeType		VARCHAR2(100) NULL,
       ContentLength	INTEGER NULL,
       Content		BLOB NULL,
       PartIndex	INTEGER NULL
)
   STORAGE( MAXEXTENTS UNLIMITED)
   LOB(Content) STORE AS ( STORAGE (MAXEXTENTS UNLIMITED) )
;


ALTER TABLE BizDocContentArchive
       ADD CONSTRAINT pk_BDContArc_DocId_PartName PRIMARY KEY (DocID,PartName) ;

ALTER TABLE BizDocContentArchive
	ADD CONSTRAINT fk_BDContArc_DocId_BizDocArc FOREIGN KEY(DocID)
		REFERENCES BizDocArchive ;

--********************************************************************

CREATE TABLE BizDocAttribute (
      DocID                CHAR(24) NOT NULL,
      AttributeID          CHAR(24) NOT NULL,
      							-- i18n 256 to 512
      StringValue          VARCHAR2(512) NULL,
      NumberValue          FLOAT NULL,
      DateValue            DATE NULL
)
   STORAGE( MAXEXTENTS UNLIMITED)
;

CREATE INDEX idx_BizDocAtt_AttId ON BizDocAttribute
(
      AttributeID          ASC
);

CREATE INDEX idx_BizDocAtt_DocId ON BizDocAttribute
(
      DocID               ASC
);


ALTER TABLE BizDocAttribute
      ADD  ( CONSTRAINT pk_BizDocAtt_DocId_AttId PRIMARY KEY (DocID, AttributeID) ) ;


ALTER TABLE BizDocAttribute
       ADD  ( CONSTRAINT fk_BizDocAtt_DocId_BizDoc FOREIGN KEY (DocID)
                             REFERENCES BizDoc ) ;


ALTER TABLE BizDocAttribute
       ADD  ( CONSTRAINT fk_BizDocAtt_AttId_BizDocAtDef FOREIGN KEY (AttributeID)
                             REFERENCES BizDocAttributeDef ) ;

--********************************************************************

CREATE TABLE BizDocContent (
      DocID                CHAR(24) NOT NULL,
      PartName		   VARCHAR2(100) NOT NULL,
      MimeType		   VARCHAR2(100),
      ContentLength	   INTEGER NULL, 
      Content	           BLOB NOT NULL,
      PartIndex	           INTEGER NULL
)
   STORAGE( MAXEXTENTS UNLIMITED )
   LOB(Content) STORE AS ( STORAGE (MAXEXTENTS UNLIMITED) )
;

ALTER TABLE BizDocContent
       ADD CONSTRAINT pk_BizDocCont_DocId_PartName PRIMARY KEY (DocID,PartName) ;

ALTER TABLE BizDocContent
       ADD  ( CONSTRAINT fk_BizDocCont_DocId_BizDoc FOREIGN KEY (DocID)
                             REFERENCES BizDoc ) ;

--********************************************************************

CREATE TABLE BizDocRelationship (
       DocID                CHAR(24) NOT NULL,
       RelatedDocID         CHAR(24) NOT NULL,
       							 -- i18n, 80 to 255
       Relationship         VARCHAR2(255) NULL
)
   STORAGE( MAXEXTENTS UNLIMITED )
;


CREATE INDEX idx_BizDocRel_RelatedDocId ON BizDocRelationship
(
      RelatedDocID                   ASC
);

CREATE INDEX idx_BizDocRel_DocId ON BizDocRelationship
(
       DocID                          ASC
);


ALTER TABLE BizDocRelationship
       ADD  ( CONSTRAINT pk_BizDocRel_DocId_RelatDocId PRIMARY KEY (DocID, RelatedDocID) ) ;


ALTER TABLE BizDocRelationship
       ADD  ( CONSTRAINT fk_BizDocRel_DocId_BizDoc FOREIGN KEY (DocID)
                             REFERENCES BizDoc ) ;


ALTER TABLE BizDocRelationship
       ADD  ( CONSTRAINT fk_BizDocRel_RelatDocId_BizDoc FOREIGN KEY (RelatedDocID)
                             REFERENCES BizDoc ) ;

--********************************************************************

CREATE TABLE BizDocTypeAttribute (
      AttributeID          CHAR(24) NOT NULL,
      TypeID               CHAR(24) NOT NULL
)
   STORAGE (MAXEXTENTS UNLIMITED)
;

CREATE INDEX idx_BizDocTypeAtt_AttId ON BizDocTypeAttribute
(
      AttributeID                    ASC
);

CREATE INDEX idx_BizDocTypeAtt_TypeId ON BizDocTypeAttribute
(
      TypeID                         ASC
);

ALTER TABLE BizDocTypeAttribute
       ADD  ( CONSTRAINT pk_BizDocTypeAtt_AttId_TypeId PRIMARY KEY (AttributeID, TypeID) ) ;

       
ALTER TABLE BizDocTypeAttribute
       ADD  ( CONSTRAINT fk_BDocTypAtt_TypId_BDocTypDef FOREIGN KEY (TypeID)
                             REFERENCES BizDocTypeDef ) ;


ALTER TABLE BizDocTypeAttribute
       ADD  ( CONSTRAINT fk_BDocTypAtt_AttId_BDocAttDef FOREIGN KEY (AttributeID)
                             REFERENCES BizDocAttributeDef ) ;

--********************************************************************

CREATE TABLE Contact (
      ContactID            CHAR(24) NOT NULL,
      PartnerID            CHAR(24) NOT NULL,
      							-- i18n, 40 to 255
      Surname              VARCHAR2(255) NULL,
      							-- i18n, 40 to 255
      GivenName            VARCHAR2(255) NULL,
      SequenceNumber       SMALLINT NOT NULL,
      							-- i18n, 64 to 128
      Role                 VARCHAR2(128) NULL,
      Type                 SMALLINT NOT NULL,
      EmailAddress         VARCHAR2(64) NULL,
									-- i18n, 20 to 60
      TelNumber            VARCHAR2(60) NULL,
									-- i18n, 20 to 60
      TelExtension         VARCHAR2(60) NULL,
									-- i18n, 20 to 60      
      FaxNumber            VARCHAR2(60) NULL,
									-- i18n, 20 to 60
      PagerNumber          VARCHAR2(60) NULL
)
   STORAGE (MAXEXTENTS UNLIMITED)
;

CREATE INDEX idx_Cont_PtnrId ON Contact
(
       PartnerID                      ASC
);

ALTER TABLE Contact
       ADD  ( CONSTRAINT pk_Cont_ContId PRIMARY KEY ( ContactID) ) ;

ALTER TABLE Contact
       ADD  ( CONSTRAINT fk_Cont_PtnrId_Ptnr FOREIGN KEY (PartnerID)
                             REFERENCES Partner) ;
                             
ALTER TABLE Contact 
  ADD CONSTRAINT fk_Contact_Type_ContType 
      FOREIGN KEY(Type) REFERENCES ContactType ;

--*******************************************************************

CREATE TABLE Address (
      AddressID            CHAR(24) NOT NULL,
      PartnerID            CHAR(24) NULL,
      ContactID            CHAR(24) NULL,
      							-- i18n 50 to 255
      AddressLine1         VARCHAR2(255) NULL,
      							-- i18n 50 to 255
      AddressLine2         VARCHAR2(255) NULL,
      							-- i18n 50 to 255
      AddressLine3         VARCHAR2(255) NULL,
      							-- i18n 50 to 255
      City                 VARCHAR2(255) NULL,
      							-- i18n 20 to 128
      State_Province       VARCHAR2(128) NULL,
      							-- i18n 12 to 128
      Zip_PostalCode       VARCHAR2(128) NULL,
      							-- i18n 18 to 60
      Country              VARCHAR2(60) NULL,
      SequenceNumber       SMALLINT NULL      
)
   STORAGE( MAXEXTENTS UNLIMITED) 
;

CREATE INDEX idx_Address_ContId ON Address
(
      ContactID            ASC
);

CREATE INDEX idx_Address_PtnrId ON Address
(
      PartnerID            ASC
);

ALTER TABLE Address
      ADD  ( CONSTRAINT pk_Address_AddressId PRIMARY KEY (AddressID) ) ;

ALTER TABLE Address
       ADD  ( CONSTRAINT fk_Address_PtnrId_Ptnr FOREIGN KEY (PartnerID)
                             REFERENCES Partner) ;

ALTER TABLE Address
       ADD CONSTRAINT fk_Address_ContId_Cont FOREIGN KEY (ContactID)
                            REFERENCES Contact
;                               
                             
--********************************************************************

CREATE TABLE DeliveryService (
			                  -- i18n, 64 to 128
      ServiceName          VARCHAR2(128) NOT NULL,
      							-- i18n, 128 to 512
      B2BInterface         VARCHAR2(512) NOT NULL,
      							-- i18n, 128 to 512
      B2BService           VARCHAR2(512) NOT NULL,
      RemoteLocation       VARCHAR2(128) NULL,
      RemoteUser           VARCHAR2(32) NULL,
      RemotePassword       VARCHAR2(32) NULL
)
   STORAGE( MAXEXTENTS UNLIMITED )
;


ALTER TABLE DeliveryService
       ADD  ( CONSTRAINT pk_DeliServ_ServName PRIMARY KEY (ServiceName) ) ;
                             
--********************************************************************

CREATE TABLE DeliveryJob (
      JobID                CHAR(24) NOT NULL,
      ServerID             VARCHAR2(50) NOT NULL,
      TimeCreated          DATE NULL,
      TimeUpdated          DATE NULL,
      JobStatus            VARCHAR2(20) NULL,
      TimeToWait           NUMBER NULL,
      Retries              NUMBER NULL,
      RetryLimit           NUMBER NULL,
      							-- i18n 20 to 60
      TransportStatus      VARCHAR2(60) NULL,
      							-- i18n 256 to 512
      TransportStatusMessage VARCHAR2(512) NULL,
      TransportTime        NUMBER NULL,
      DocID                CHAR(24) NULL,
      OutputData           BLOB NULL,
      							-- i18n 64 to 128
      ServiceName          VARCHAR2(128) NULL,
      RetryFactor	   INTEGER NULL,
      TypeData		   BLOB NULL,
      JobType		   VARCHAR2(20) NULL
)
   STORAGE( MAXEXTENTS UNLIMITED )
   LOB(OutputData) STORE AS ( STORAGE (MAXEXTENTS UNLIMITED) )
   LOB(TypeData) STORE AS ( STORAGE (MAXEXTENTS UNLIMITED) )
;

CREATE INDEX idx_DeliJob_ServName ON DeliveryJob
(
       ServiceName                    ASC
);

CREATE INDEX idx_DeliJob_DocId ON DeliveryJob
(
       DocID                          ASC
);

ALTER TABLE DeliveryJob
       ADD  ( CONSTRAINT pk_DeliJob_JobId PRIMARY KEY (JobID) ) ;

ALTER TABLE DeliveryJob
       ADD  ( CONSTRAINT fk_DeliJob_DocId_BizDoc FOREIGN KEY (DocID)
                             REFERENCES BizDoc ) ;

--********************************************************************

CREATE TABLE Destination (
       DestinationID        CHAR(24) NOT NULL,
       PartnerID            CHAR(24) NOT NULL,
       Protocol             CHAR(8) NOT NULL,
       Host                 VARCHAR2(64) NULL,
       PrimaryAddr          INTEGER NOT NULL,
       Port                 VARCHAR2(6) NULL,
       							 -- i18n, 128 to 255
       Location             VARCHAR2(255) NULL,
       UserName             VARCHAR2(24) NULL,
       Password             VARCHAR2(24) NULL,
       CustomData	    BLOB NULL
)
   STORAGE( MAXEXTENTS UNLIMITED )
   LOB(CustomData) STORE AS ( STORAGE (MAXEXTENTS UNLIMITED) )
;

CREATE INDEX idx_Dest_PtnrId ON Destination
(
       PartnerID                      ASC
);

CREATE INDEX idx_Dest_PtnrId_Protocol ON Destination
(
       PartnerID,
       Protocol
);

ALTER TABLE Destination
       ADD CONSTRAINT pk_Dest_DestinationId PRIMARY KEY (DestinationID) ;

ALTER TABLE Destination
       ADD  ( CONSTRAINT fk_Dest_PtnrId_Ptnr FOREIGN KEY (PartnerID)
                             REFERENCES Partner) ;

--********************************************************************

CREATE TABLE IDType (
       Type                 INTEGER NOT NULL,
       							 -- i18n, 128 to 255
       Description          VARCHAR2(255) NOT NULL
)
   STORAGE ( MAXEXTENTS UNLIMITED )
;


ALTER TABLE IDType
       ADD  ( CONSTRAINT pk_IdType_Type PRIMARY KEY (Type) ) ;


--********************************************************************

CREATE TABLE PartnerBinary (
       PartnerID            CHAR(24) NOT NULL,
       Type                 VARCHAR2(20) NOT NULL,
       Value                BLOB NULL
)
   STORAGE( MAXEXTENTS UNLIMITED )
   LOB(Value) STORE AS ( STORAGE (MAXEXTENTS UNLIMITED) )   
;

CREATE INDEX idx_PtnrBin_PtnrId ON PartnerBinary
(
       PartnerID                      ASC
);


ALTER TABLE PartnerBinary
       ADD  ( CONSTRAINT pk_PtnrBin_PtnrId_Type PRIMARY KEY (PartnerID, Type) ) ;

ALTER TABLE PartnerBinary
       ADD  ( CONSTRAINT fk_PtnrBin_PtnrId_Ptnr FOREIGN KEY (PartnerID)
                             REFERENCES Partner) ;

--********************************************************************

CREATE TABLE PartnerID (
       PartnerIDID          CHAR(24) NOT NULL,
       InternalID           CHAR(24) NOT NULL,
       ExternalID           VARCHAR2(128) NOT NULL,
       IDType               INTEGER NOT NULL,
       SequenceNumber       SMALLINT NOT NULL       
)
   STORAGE( MAXEXTENTS UNLIMITED )
;

CREATE INDEX idx_PtnrIdTbl_InternalId ON PartnerID
(
       InternalID                     ASC
);

ALTER TABLE PartnerID
       ADD CONSTRAINT pk_PtnrIdTbl_PtnrIdId PRIMARY KEY (PartnerIDID) ;

ALTER TABLE PartnerID
       ADD  ( CONSTRAINT fk_PtnrIdTbl_InternalId_Ptnr FOREIGN KEY (InternalID)
                             REFERENCES Partner) ;


--*******************************************************************

CREATE TABLE FieldGroup (
       ID           smallint     NOT NULL,
       Description  varchar2(128) NOT NULL
)
   STORAGE( MAXEXTENTS UNLIMITED)
;

ALTER TABLE FieldGroup
       ADD CONSTRAINT pk_GroupID_ID PRIMARY KEY (ID) ;

--********************************************************************

CREATE TABLE ProfileField (
       ProfileFieldID       CHAR(24) NOT NULL,
       Name                 CHAR(32) NULL,
       Required             SMALLINT NOT NULL,
       Registration         SMALLINT NOT NULL,
       ValidValues          VARCHAR2(4000) NULL,
       DefaultValue         VARCHAR2(128) NULL,
       ProfileTbl           VARCHAR2(20) NULL,
       DataType             VARCHAR2(10) NULL,
       ProfileCol           VARCHAR2(20) NULL,
       Deleted              SMALLINT NOT NULL,
       GroupID              SMALLINT NOT NULL,
       Description          VARCHAR2(1024) NULL,
       MaxLength            NUMBER NULL,
       Display              SMALLINT NOT NULL
);

CREATE INDEX idx_ProfFld_ProfTbl_ProfCol ON ProfileField
(
       ProfileTbl                     ASC,
       ProfileCol                     ASC
);

CREATE INDEX idx_ProfFld_Name ON ProfileField
(
       Name                           ASC
);


ALTER TABLE ProfileField
       ADD  ( CONSTRAINT pk_ProfFld_ProfFldId PRIMARY KEY (ProfileFieldID) ) ;

ALTER TABLE ProfileField
	ADD CONSTRAINT fk_ProfileFld_GrpID_FieldGrp FOREIGN KEY (GroupID)
			   REFERENCES FieldGroup ;

--********************************************************************

CREATE TABLE PartnerProfileField (
       ProfileFieldID       CHAR(24) NOT NULL,
       ValueBinary          BLOB NULL,
       PartnerID            CHAR(24) NOT NULL,
       ValueString          VARCHAR2(4000) NULL
);

CREATE INDEX idx_PtnrProFld_ProFldId ON PartnerProfileField
(
       ProfileFieldID                 ASC
);

CREATE INDEX idx_PtnrProFld_PtnrId ON PartnerProfileField
(
       PartnerID                      ASC
);


ALTER TABLE PartnerProfileField
       ADD  ( CONSTRAINT pk_PtnrProFld_PtnrId_ProFldId PRIMARY KEY (PartnerID, ProfileFieldID) ) ;


ALTER TABLE PartnerProfileField
       ADD  ( CONSTRAINT fk_PtnrProFld_ProFldId_ProFld FOREIGN KEY (ProfileFieldID)
                             REFERENCES ProfileField ) ;

ALTER TABLE PartnerProfileField
       ADD  ( CONSTRAINT fk_PtnrProFld_PtnrId_Ptnr FOREIGN KEY (PartnerID)
                             REFERENCES Partner) ;
                             
--********************************************************************

CREATE TABLE ProcessingRule (
       RuleIndex            NUMBER NOT NULL,
       RuleDescription      VARCHAR2(256) NULL,
       							 -- i18n, 64 to 128
       RuleName             VARCHAR2(128) NOT NULL,
       RuleData             BLOB NULL,
       LastModified         DATE NULL,
       Disabled             SMALLINT NOT NULL
)
   STORAGE( MAXEXTENTS UNLIMITED )
   LOB(RuleData) STORE AS ( STORAGE (MAXEXTENTS UNLIMITED) )   
;

ALTER TABLE ProcessingRule
       ADD  ( CONSTRAINT pk_ProcessingRule_RuleIndex PRIMARY KEY (RuleIndex) ) ;


--********************************************************************

CREATE TABLE Remote (
       PartnerID            CHAR(24) NOT NULL,
       Certificate          VARCHAR2(255) NULL,
       CACertificate        VARCHAR2(255) NULL,
       RemoteStatus         VARCHAR2(12) NULL,
       PrivateKey           VARCHAR2(255) NULL,
       PreferredProtocol    VARCHAR2(8) NULL,
       PollingFrequency     FLOAT NULL,
       DeliveryMaxRetries   SMALLINT NULL,
       DeliveryRetryWait    INTEGER NULL,
       PollingProtocol      VARCHAR2(8) NULL,
       RetryFactor	    INTEGER NULL
)
   STORAGE( MAXEXTENTS UNLIMITED )
;


ALTER TABLE Remote
       ADD  ( CONSTRAINT pk_Remote_PtnrId PRIMARY KEY (PartnerID) ) ;

ALTER TABLE Remote
       ADD  ( CONSTRAINT fk_Remote_PtnrId_Ptnr FOREIGN KEY (PartnerID)
                             REFERENCES Partner) ;

--*******************************************************************

CREATE TABLE ConversationScript (
   ScriptName  VARCHAR2(64) NOT NULL,
   ScriptIndex INTEGER NULL,
   ScriptData  BLOB NULL
)
   STORAGE( MAXEXTENTS UNLIMITED )
   LOB(ScriptData) STORE AS ( STORAGE (MAXEXTENTS UNLIMITED) )   
;

ALTER TABLE ConversationScript
       ADD CONSTRAINT pk_ConvScr_ScriptName PRIMARY KEY (ScriptName)
;

--*******************************************************************

CREATE TABLE Conversation (
   ConversationID       varchar2(300) NOT NULL,
   ConversationStatus   varchar2(40),
   ScriptName           varchar2(64),
   TimeCreated          date,
   ParentConversationID varchar2(300),
   CurrentStep    	varchar(64),
   Timeout              date,
   LastModified         date
)
   STORAGE( MAXEXTENTS UNLIMITED )
;

ALTER TABLE Conversation
       ADD CONSTRAINT pk_Conv_ConvId PRIMARY KEY (ConversationID)
;

ALTER TABLE Conversation
   ADD CONSTRAINT fk_Conv_ParentConvID_Conv FOREIGN KEY (ParentConversationID) 
            REFERENCES Conversation
;

--*******************************************************************

CREATE TABLE RoleBinding (
    ConversationID   varchar(300) NOT NULL,
    RoleName         varchar(128),
    PartnerID        char(24) NOT NULL,
    RoleType         int NOT NULL    
)
   STORAGE( MAXEXTENTS UNLIMITED )
;

ALTER TABLE RoleBinding
   ADD CONSTRAINT pk_RoleBind_ConvID_RoldName 
      PRIMARY KEY(ConversationID, RoleName)
;

ALTER TABLE RoleBinding
       ADD CONSTRAINT fk_RoleBind_ConvId_Conv FOREIGN KEY (ConversationID)
                             REFERENCES Conversation
;

ALTER TABLE RoleBinding
       ADD CONSTRAINT fk_RoleBind_PtnrId_Ptnr FOREIGN KEY (PartnerID)
                             REFERENCES Partner
;

--*******************************************************************

CREATE TABLE ActivityLog (
      RelatedDocID         CHAR(24) NULL,
      EntryTimestamp       DATE NOT NULL,
      EntryType            INTEGER NOT NULL,
      EntryClass           VARCHAR2(20) NULL,
      							-- i18n 80 to 240
      BriefMessage         VARCHAR2(240) NOT NULL, 
      RelatedPartnerID     CHAR(24) NULL,
      RelatedConversationID VARCHAR2(300) NULL,
      B2BUser              VARCHAR2(20) NULL,
      FullMessage          VARCHAR2(1024) NULL
) 
   STORAGE( MAXEXTENTS UNLIMITED)
;

CREATE INDEX idx_ActLog_RelatedDocId ON ActivityLog
(
      RelatedDocID         ASC
);

CREATE INDEX idx_ActLog_RelatedPtnrId ON ActivityLog
(
      RelatedPartnerID     ASC
);

ALTER TABLE ActivityLog
      ADD  ( CONSTRAINT fk_ActLog_RelatedPtnrId_Ptnr FOREIGN KEY (RelatedPartnerID)
                  REFERENCES Partner ) ;


ALTER TABLE ActivityLog
      ADD  ( CONSTRAINT fk_ActLog_RelatedDocId_BizDoc FOREIGN KEY (RelatedDocID)
                     REFERENCES BizDoc ) ;

ALTER TABLE ACTIVITYLOG
       ADD CONSTRAINT fk_ActLog_RelatedConvId_Conv FOREIGN KEY (RelatedConversationID)
                             REFERENCES Conversation ;

--********************************************************************

CREATE TABLE TNModelVersion (
       MajorVersion         NUMBER NOT NULL,
       MinorVersion         NUMBER NOT NULL
);


ALTER TABLE TNModelVersion
       ADD  ( CONSTRAINT pk_TNModelVer_MajVer_MinorVer PRIMARY KEY (MajorVersion, MinorVersion) ) ;


--********************************************************************
