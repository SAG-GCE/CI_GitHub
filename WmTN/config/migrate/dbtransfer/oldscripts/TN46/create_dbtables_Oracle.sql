
--********************************************************************
CREATE TABLE Partner (
       ParentPartnerID      CHAR(24) NULL,
       PartnerID            CHAR(24) NOT NULL,
       CorporationName      VARCHAR2(255) NOT NULL,
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
      AttributeName        VARCHAR2(255) NOT NULL,
      AttributeID          CHAR(24) NOT NULL,
      AttributeDescription VARCHAR2(1024) NULL,
      AttributeType        VARCHAR2(20) NOT NULL,
      Deleted              SMALLINT NOT NULL,
      Persist              SMALLINT,
      LastModified         DATE NULL
)
   STORAGE( MAXEXTENTS UNLIMITED)
;

ALTER TABLE BizDocAttributeDef
      ADD  ( CONSTRAINT pk_BizDocAttDef_AttId PRIMARY KEY (AttributeID) ) ;

--********************************************************************

CREATE TABLE BizDocTypeDef (
      TypeName             VARCHAR2(128) NOT NULL,
      TypeID               CHAR(24) NOT NULL,
      TypeDescription      VARCHAR2(255) NULL,
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
      Description          VARCHAR2(255) NOT NULL
)
   STORAGE( MAXEXTENTS UNLIMITED)
;


ALTER TABLE BinaryType
      ADD  ( CONSTRAINT pk_BinaryType_Type PRIMARY KEY (Type) ) ;


--********************************************************************

CREATE TABLE ContactType (
      Type                 SMALLINT NOT NULL,
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
                             REFERENCES Partner(PartnerID) ) ;


ALTER TABLE BizDoc
       ADD  ( CONSTRAINT fk_BizDoc_SenderId_Ptnr FOREIGN KEY (SenderID)
                             REFERENCES Partner(PartnerID) ) ;


ALTER TABLE BizDoc
       ADD  ( CONSTRAINT fk_BizDoc_DocTyId_BizDocTypDef FOREIGN KEY (DocTypeID)
                             REFERENCES BizDocTypeDef(TypeID) ) ;

--********************************************************************

CREATE TABLE BizDocArchive (
      DocID                CHAR(24) NOT NULL,
      ArchiveTimestamp     DATE DEFAULT SYSDATE NOT NULL,
      DocTimestamp         DATE NOT NULL,
      SenderCorp           VARCHAR2(255) NOT NULL,
      DocTypeName          VARCHAR2(128) NOT NULL,
      ReceiverCorp         VARCHAR2(255) NOT NULL,
      SenderOrgUnit        VARCHAR2(255) NULL,
      ReceiverOrgUnit      VARCHAR2(255) NULL
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
       PartIndex	INTEGER NULL,
       StorageType  VARCHAR2(100) NULL,
       StorageRef   VARCHAR2(250) NULL
)
   STORAGE( MAXEXTENTS UNLIMITED)
   LOB(Content) STORE AS ( STORAGE (MAXEXTENTS UNLIMITED) )
;


ALTER TABLE BizDocContentArchive
       ADD CONSTRAINT pk_BDContArc_DocId_PartName PRIMARY KEY (DocID,PartName) ;

ALTER TABLE BizDocContentArchive
	ADD CONSTRAINT fk_BDContArc_DocId_BizDocArc FOREIGN KEY(DocID)
		REFERENCES BizDocArchive(DocID) ;

--********************************************************************

CREATE TABLE BizDocAttribute (
      DocID                CHAR(24) NOT NULL,
      AttributeID          CHAR(24) NOT NULL,
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
                             REFERENCES BizDoc(DocID) ) ;


ALTER TABLE BizDocAttribute
       ADD  ( CONSTRAINT fk_BizDocAtt_AttId_BizDocAtDef FOREIGN KEY (AttributeID)
                             REFERENCES BizDocAttributeDef(AttributeID) ) ;

--********************************************************************

CREATE TABLE BizDocContent (
      DocID                CHAR(24) NOT NULL,
      PartName		   VARCHAR2(100) NOT NULL,
      MimeType		   VARCHAR2(100),
      ContentLength	   INTEGER NULL,
      Content	           BLOB NULL,
      PartIndex	           INTEGER NULL,
      StorageType       VARCHAR2(100) NULL,
      StorageRef        VARCHAR2(250) NULL
)
   STORAGE( MAXEXTENTS UNLIMITED )
   LOB(Content) STORE AS ( STORAGE (MAXEXTENTS UNLIMITED) )
;

ALTER TABLE BizDocContent
       ADD CONSTRAINT pk_BizDocCont_DocId_PartName PRIMARY KEY (DocID,PartName) ;

ALTER TABLE BizDocContent
       ADD  ( CONSTRAINT fk_BizDocCont_DocId_BizDoc FOREIGN KEY (DocID)
                             REFERENCES BizDoc(DocID) ) ;

--********************************************************************

CREATE TABLE BizDocRelationship (
       DocID                CHAR(24) NOT NULL,
       RelatedDocID         CHAR(24) NOT NULL,
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
                             REFERENCES BizDoc(DocID) ) ;


ALTER TABLE BizDocRelationship
       ADD  ( CONSTRAINT fk_BizDocRel_RelatDocId_BizDoc FOREIGN KEY (RelatedDocID)
                             REFERENCES BizDoc(DocID) ) ;

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
                             REFERENCES BizDocTypeDef(TypeID) ) ;


ALTER TABLE BizDocTypeAttribute
       ADD  ( CONSTRAINT fk_BDocTypAtt_AttId_BDocAttDef FOREIGN KEY (AttributeID)
                             REFERENCES BizDocAttributeDef(AttributeID) ) ;

--********************************************************************

CREATE TABLE Contact (
      ContactID            CHAR(24) NOT NULL,
      PartnerID            CHAR(24) NOT NULL,
      Surname              VARCHAR2(255) NULL,
      GivenName            VARCHAR2(255) NULL,
      SequenceNumber       SMALLINT NOT NULL,
      RoleDescription		VARCHAR2(128) NULL,
      Type                 SMALLINT NOT NULL,
      EmailAddress         VARCHAR2(64) NULL,
      TelNumber            VARCHAR2(60) NULL,
      TelExtension         VARCHAR2(60) NULL,
      FaxNumber            VARCHAR2(60) NULL,
      PagerNumber          VARCHAR2(60) NULL
)
   STORAGE (MAXEXTENTS UNLIMITED)
;

CREATE INDEX idx_Cont_PtnrId ON Contact
(
       PartnerID                      ASC
);

ALTER TABLE Contact
       ADD  ( CONSTRAINT pk_Cont_ContId PRIMARY KEY (ContactID) ) ;

ALTER TABLE Contact
       ADD  ( CONSTRAINT fk_Cont_PtnrId_Ptnr FOREIGN KEY (PartnerID)
                             REFERENCES Partner(PartnerID) ) ;

ALTER TABLE Contact
  ADD CONSTRAINT fk_Contact_Type_ContType
      FOREIGN KEY(Type) REFERENCES ContactType(Type) ;

--*******************************************************************

CREATE TABLE Address (
      AddressID            CHAR(24) NOT NULL,
      PartnerID            CHAR(24) NULL,
      ContactID            CHAR(24) NULL,
      AddressLine1         VARCHAR2(255) NULL,
      AddressLine2         VARCHAR2(255) NULL,
      AddressLine3         VARCHAR2(255) NULL,
      City                 VARCHAR2(255) NULL,
      State_Province       VARCHAR2(128) NULL,
      Zip_PostalCode       VARCHAR2(128) NULL,
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
                             REFERENCES Partner(PartnerID) ) ;

ALTER TABLE Address
       ADD CONSTRAINT fk_Address_ContId_Cont FOREIGN KEY (ContactID)
                            REFERENCES Contact(ContactID) ;

--********************************************************************

CREATE TABLE DeliveryService (
      ServiceName          VARCHAR2(128) NOT NULL,
      B2BInterface         VARCHAR2(512) NOT NULL,
      B2BService           VARCHAR2(512) NOT NULL,
      RemoteLocation       VARCHAR2(128) NULL,
      RemoteUser           VARCHAR2(32) NULL,
      RemotePassword       VARCHAR2(32) NULL,
      Scheduled            INTEGER
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
      TransportStatus      VARCHAR2(60) NULL,
      TransportStatusMessage VARCHAR2(512) NULL,
      TransportTime        NUMBER NULL,
      DocID                CHAR(24) NULL,
      OutputData           BLOB NULL,
      ServiceName          VARCHAR2(128) NULL,
      RetryFactor	   INTEGER NULL,
      TypeData		   BLOB NULL,
      JobType		   VARCHAR2(20) NULL,
      QueueName    VARCHAR2(254) NULL
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
                             REFERENCES BizDoc(DocID) ) ;

--********************************************************************

CREATE TABLE Destination (
       DestinationID        CHAR(24) NOT NULL,
       PartnerID            CHAR(24) NOT NULL,
       Protocol             VARCHAR2(64) NOT NULL,
       Host                 VARCHAR2(64) NULL,
       PrimaryAddr          INTEGER NOT NULL,
       Port                 VARCHAR2(6) NULL,
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
                             REFERENCES Partner(PartnerID)) ;

--********************************************************************

CREATE TABLE IDType (
       Type                 INTEGER NOT NULL,
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
                             REFERENCES Partner(PartnerID)) ;

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
                             REFERENCES Partner(PartnerID) ) ;

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
			   REFERENCES FieldGroup(ID) ;

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
                             REFERENCES ProfileField(ProfileFieldID) ) ;

ALTER TABLE PartnerProfileField
       ADD  ( CONSTRAINT fk_PtnrProFld_PtnrId_Ptnr FOREIGN KEY (PartnerID)
                             REFERENCES Partner(PartnerID) ) ;

--********************************************************************

CREATE TABLE ProcessingRule (
       RuleIndex            NUMBER NOT NULL,
       RuleDescription      VARCHAR2(255) NULL,
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
       PreferredProtocol    VARCHAR2(64) NULL,
       PollingFrequency     FLOAT NULL,
       DeliveryMaxRetries   SMALLINT NULL,
       DeliveryRetryWait    INTEGER NULL,
       PollingProtocol      VARCHAR2(64) NULL,
       RetryFactor	    INTEGER NULL,
       DeliveryQueue    VARCHAR2(254) NULL
)
   STORAGE( MAXEXTENTS UNLIMITED )
;

ALTER TABLE Remote
       ADD  ( CONSTRAINT pk_Remote_PtnrId PRIMARY KEY (PartnerID) ) ;

ALTER TABLE Remote
       ADD  ( CONSTRAINT fk_Remote_PtnrId_Ptnr FOREIGN KEY (PartnerID)
                             REFERENCES Partner(PartnerID) ) ;

--*******************************************************************

CREATE TABLE ConversationScript (
   ScriptName  VARCHAR2(255) NOT NULL,
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

CREATE TABLE Process(
	InstanceID          varchar2(300) NOT NULL,
	ParentInstanceID    varchar2(300),
	ProcessKey          varchar2(64) NOT NULL,
	ProcessLabel        varchar2(512),
	ProcessVersion      varchar2(64),
	Status              varchar2(40) NOT NULL,
  DeploymentVersion   integer,
	TimeCreated         date NOT NULL,
	LastModified        date
)
   STORAGE( MAXEXTENTS UNLIMITED )
;

ALTER TABLE Process ADD CONSTRAINT pk_Process_InstId PRIMARY KEY(InstanceID) ;

ALTER TABLE Process ADD CONSTRAINT fk_proc_PInID_proc
	FOREIGN KEY(ParentInstanceID) REFERENCES Process(InstanceID) ;

--********************************************************************

CREATE TABLE ProcessStep(
	InstanceID      varchar2(300) NOT NULL,
	StepID          varchar2(128) NOT NULL,
	StepLabel       varchar2(128),
	Status          varchar2(40) NOT NULL,
	System          varchar2(10) NOT NULL,
	CurrentTry      integer NOT NULL,
  TargetStepIDs   varchar2(255),
  Server          varchar2(128),
  Component       varchar2(128),
	TimeCreated     date NOT NULL,
	LastModified    date
)
   STORAGE( MAXEXTENTS UNLIMITED )
;

ALTER TABLE ProcessStep ADD CONSTRAINT pk_PStep_InId_StID PRIMARY KEY(InstanceID, StepID);

ALTER TABLE ProcessStep ADD CONSTRAINT fk_PStep_InId_Proc
	FOREIGN KEY(InstanceID) REFERENCES Process(InstanceID) ;

--********************************************************************

CREATE TABLE CustomProcessData(
	InstanceID			varchar2(300) NOT NULL,
	StepID				varchar2(128) NOT NULL,
	DocumentID			varchar2(128) NOT NULL,
	FieldName			varchar2(128) NOT NULL,
	DocumentName		varchar2(128),
	StringValue			varchar2(4000),
	NumberValue			float,
	DateValue			date
)
   STORAGE( MAXEXTENTS UNLIMITED )
;

ALTER TABLE CustomProcessData ADD CONSTRAINT pk_CustomProcData
	PRIMARY KEY(InstanceID, StepID, DocumentID, FieldName) ;

ALTER TABLE CustomProcessData ADD CONSTRAINT fk_CusPD_InID_StID
	FOREIGN KEY(InstanceID,StepID) REFERENCES ProcessStep(InstanceID, StepID) ;

--********************************************************************

CREATE TABLE TNProcess(
	InstanceID			varchar2(300) NOT NULL,
	ScriptName			varchar2(255) NOT NULL,
	TNStatus				varchar2(40) NOT NULL,
	UserInstanceID		varchar2(150),
	UserInstanceID2	varchar2(150),
	CurrentStep			varchar2(64),
	Timeout				date,
	LastModified		date
)
   STORAGE( MAXEXTENTS UNLIMITED )
;

CREATE INDEX idx_TNP_UserInID ON TNProcess
(
       UserInstanceID,
       UserInstanceID2
);

CREATE INDEX idx_TNP_TNStatus ON TNProcess
(
		 TNStatus
);

ALTER TABLE TNProcess ADD CONSTRAINT pk_TNProc_InstID
	PRIMARY KEY(InstanceID) ;

ALTER TABLE TNProcess ADD CONSTRAINT fk_TNPro_InID_Proc
	FOREIGN KEY(InstanceID) REFERENCES Process(InstanceID) ;

--********************************************************************

CREATE TABLE TNRoleBinding(
	InstanceID			varchar2(300) NOT NULL,
	RoleName				varchar2(128) NOT NULL,
	PartnerID			char(24),
	RoleType				integer NOT NULL
)
   STORAGE( MAXEXTENTS UNLIMITED )
;

ALTER TABLE TNRoleBinding ADD CONSTRAINT pk_TNRB_InID_RName
	PRIMARY KEY(InstanceID, RoleName);

ALTER TABLE TNRoleBinding ADD CONSTRAINT fk_TNRB_InID_Proc
	FOREIGN KEY(InstanceID) REFERENCES Process(InstanceID) ;

ALTER TABLE TNRoleBinding
       ADD CONSTRAINT fk_RBind_PtrId_Ptr FOREIGN KEY (PartnerID)
                             REFERENCES Partner(PartnerID) ;

--********************************************************************

CREATE TABLE ActivityLog(
       RelatedDocID         char(24),
       EntryTimestamp       date NOT NULL,
       EntryType            int NOT NULL,
       EntryClass           varchar2(20),
       BriefMessage         varchar2(240) NOT NULL,
       RelatedPartnerID     char(24),
       RelatedInstanceID	 varchar2(300),
       RelatedStepID			 varchar2(128),
       B2BUser              varchar2(20),
       FullMessage          varchar2(1024)
)
   STORAGE( MAXEXTENTS UNLIMITED )
;

CREATE INDEX idx_ActLog_RelatedDocId ON ActivityLog
(
       RelatedDocID
);

CREATE INDEX idx_ActLog_RelatedPtnrId ON ActivityLog
(
       RelatedPartnerID
);

ALTER TABLE ActivityLog
       ADD CONSTRAINT fk_ActLog_RelatedPtnrId_Ptnr FOREIGN KEY (RelatedPartnerID)
                             REFERENCES Partner(PartnerID);

ALTER TABLE ActivityLog
       ADD CONSTRAINT fk_ActLog_RelatedDocId_BizDoc FOREIGN KEY (RelatedDocID)
                             REFERENCES BizDoc(DocID);

ALTER TABLE ActivityLog
       ADD CONSTRAINT fk_ActLog_RelatedInstId_Conv FOREIGN KEY (RelatedInstanceID)
                             REFERENCES Process(InstanceID) ;

--********************************************************************

CREATE TABLE DeliveryQueue (
	QueueName            VARCHAR2(254) NOT NULL,
	QueueType            VARCHAR2(12) NOT NULL,
	QueueState           VARCHAR2(12) NOT NULL,
	Schedule             BLOB NOT NULL
);

CREATE INDEX idx_DeliQueue_QueueType ON DeliveryQueue
(
  QueueType
);

ALTER TABLE DeliveryQueue
       ADD CONSTRAINT pk_DeliQueue_QueueName PRIMARY KEY (QueueName);

--********************************************************************

CREATE TABLE SecurityData
(
	DataID					CHAR(24) NOT NULL,
	OwnerID					CHAR(24) NOT NULL,
	CertificateData		BLOB NULL
);

CREATE INDEX Idx_SecDat_OwnrId ON SecurityData( OwnerID );

ALTER TABLE SecurityData ADD CONSTRAINT pk_SecDat_DataId
	PRIMARY KEY ( DataID );

ALTER TABLE SecurityData ADD CONSTRAINT fk_SecDat_OwnrId_Ptnr
	FOREIGN KEY ( OwnerID ) REFERENCES Partner( PartnerID );

--********************************************************************

CREATE TABLE SecurityAgreement
(
	AgreementID				CHAR(24) NOT NULL,
	SenderID				CHAR(24) NULL,
	ReceiverID				CHAR(24) NULL,
	SecurityUsage			VARCHAR2(20) NOT NULL,
	SecurityDataID			CHAR(24) NOT NULL
);

CREATE INDEX Idx_SecAgr_SndrId ON SecurityAgreement( SenderID );

CREATE INDEX Idx_SecAgr_RcvrId ON SecurityAgreement( ReceiverID );

CREATE INDEX Idx_SecAgr_Usg ON SecurityAgreement( SecurityUsage );

ALTER TABLE SecurityAgreement ADD CONSTRAINT pk_SecAgr_AgrId
	PRIMARY KEY ( AgreementID );

ALTER TABLE SecurityAgreement ADD CONSTRAINT fk_SecAgr_SndrId_Ptnr
	FOREIGN KEY ( SenderID ) REFERENCES Partner( PartnerID );

ALTER TABLE SecurityAgreement ADD CONSTRAINT fk_SecAgr_RcvrId_Ptnr
	FOREIGN KEY ( ReceiverID ) REFERENCES Partner( PartnerID );

ALTER TABLE SecurityAgreement ADD CONSTRAINT fk_SecAgr_SecDatId_SecDat
	FOREIGN KEY ( SecurityDataID ) REFERENCES SecurityData( DataID );

--********************************************************************

CREATE TABLE TNModelVersion (
       MajorVersion         NUMBER NOT NULL,
       MinorVersion         NUMBER NOT NULL
);


ALTER TABLE TNModelVersion
       ADD  ( CONSTRAINT pk_TNModelVer_MajVer_MinorVer PRIMARY KEY (MajorVersion, MinorVersion) ) ;

--********************************************************************
-- BI Tables
--********************************************************************

CREATE TABLE ProcessDefinition(
	ProcessKey		varchar2(64) NOT NULL,
	ProcessLabel		varchar2(255),
	OID			varchar2(128),
	ProcessPath		varchar2(512),
	Description		varchar2(512),
	Version			varchar2(20),
	CreatedBy		varchar2(64),
	LastModified		date,
	SingleStop		integer NOT NULL,
	Icon			blob,
	ProcessImage		blob,
	DeploymentTime		date,
	DeploymentVersion	integer NOT NULL,
	StopCount		integer
)
   STORAGE( MAXEXTENTS UNLIMITED )
   LOB(Icon) STORE AS ( STORAGE (MAXEXTENTS UNLIMITED) )
   LOB(ProcessImage) STORE AS ( STORAGE (MAXEXTENTS UNLIMITED) )
;

ALTER TABLE ProcessDefinition
	ADD CONSTRAINT pk_PDef_ProcessKey PRIMARY KEY (ProcessKey, DeploymentVersion) ;

--********************************************************************

CREATE TABLE StepDefinition(
	ProcessKey		varchar2(64) NOT NULL,
	StepID			varchar2(128) NOT NULL,
	StepLabel		varchar2(128),
	Type			varchar2(10),
	Icon			blob,
	Description		varchar2(512),
	Is_Start		integer,
	Is_Stop			integer,
	Icon_X			integer,
	Icon_Y			integer,
	Icon_Width		integer,
	Icon_Height		integer,
	DeploymentVersion	integer NOT NULL,
	Server			varchar2(128),
	Component		varchar2(128),
	SubprocessKey		varchar2(150),
	InlineStepID		varchar2(128)
)
   STORAGE( MAXEXTENTS UNLIMITED )
   LOB(Icon) STORE AS ( STORAGE (MAXEXTENTS UNLIMITED) )
;

ALTER TABLE StepDefinition
      ADD CONSTRAINT pk_StepDef_StepID PRIMARY KEY (ProcessKey, StepID, DeploymentVersion) ;

--********************************************************************

CREATE TABLE StepTransitionDefinition(
	ProcessKey		varchar2(64) NOT NULL,
	SourceStepID		varchar2(128) NOT NULL,
	TargetStepID		varchar2(128) NOT NULL,
	SourceX			integer,
	SourceY			integer,
	TargetX			integer,
	TargetY			integer,
	VisualType		varchar2(10),
	Type			varchar2(10),
	Label			varchar2(255),
	Condition		varchar2(255),
	DeploymentVersion	integer NOT NULL
)
   STORAGE(MAXEXTENTS UNLIMITED)
;

ALTER TABLE StepTransitionDefinition
      ADD CONSTRAINT pk_StepTranDef PRIMARY KEY (ProcessKey, SourceStepID, TargetStepID, DeploymentVersion) ;

--********************************************************************

CREATE TABLE CustomFieldDefinition(
	ProcessKey		varchar2(64) NOT NULL,
	StepID			varchar2(128) NOT NULL,
	DocumentName		varchar2(128) NOT NULL,
	FieldName		varchar2(128) NOT NULL,
	FieldType		varchar2(20),
	DeploymentVersion	integer NOT NULL
)
   STORAGE(MAXEXTENTS UNLIMITED)
;

ALTER TABLE CustomFieldDefinition
      ADD CONSTRAINT pk_CustomFieldDef PRIMARY KEY (ProcessKey, StepID, DeploymentVersion, DocumentName, FieldName) ;

--********************************************************************

CREATE TABLE SchemaDefinition (
	Version			varchar2(20),
	CreationDate		date,
	CreatingSystem		varchar2(20)
)
   STORAGE(MAXEXTENTS UNLIMITED)
;

--********************************************************************

CREATE TABLE ProcessPermission (
	GroupLabel		varchar2(255) NOT NULL,
	ProcessKey		varchar2(64) NOT NULL,
	ProcessLabel		varchar2(255) NOT NULL
)
  STORAGE(MAXEXTENTS UNLIMITED)
;

ALTER TABLE ProcessPermission
	ADD CONSTRAINT pk_ProcPerm_Group_Key PRIMARY KEY (GroupLabel, ProcessKey) ;


--********************************************************************
-- Enterprise Logger Adapter Tables
--********************************************************************
CREATE SEQUENCE ent_object_seq;

CREATE SEQUENCE ent_component_seq;

CREATE SEQUENCE ent_work_unit_seq;

CREATE SEQUENCE ent_message_seq;

CREATE SEQUENCE ent_transaction_seq;

--********************************************************************

CREATE TABLE ent_object (
       obj_id               NUMBER(9) NOT NULL ,
       object_name          VARCHAR2(256) NOT NULL
);

CREATE UNIQUE INDEX ENT_XUIDObject ON ent_object
(
       object_name                       ASC
);

ALTER TABLE ent_object ADD CONSTRAINT pk_entobj_objid PRIMARY KEY(obj_id) ;

--********************************************************************

CREATE TABLE ent_component (
       obj_id               NUMBER(9) NOT NULL,
       comp_id              NUMBER(9) NOT NULL,
       component            VARCHAR2(256) NOT NULL
);

CREATE UNIQUE INDEX ENT_XUIDComponent ON ent_component
(
       obj_id                            ASC,
       component                         ASC
);

CREATE UNIQUE INDEX ENT_XUIDComponentSerial ON ent_component
(
       comp_id                           ASC
) ;

ALTER TABLE ent_component ADD CONSTRAINT
  pk_entcomp_objid_compid PRIMARY KEY(obj_id, comp_id) ;

ALTER TABLE ent_component ADD CONSTRAINT
  fk_entcomp_objid_entobj FOREIGN KEY(obj_id) REFERENCES ent_object(obj_id);

--********************************************************************

CREATE TABLE ent_work_unit (
       work_unit_id         NUMBER(9) NOT NULL,
       client_id            VARCHAR2(128) NOT NULL,
       adapter_type         VARCHAR2(128) NULL,
       class_name           VARCHAR2(512) NOT NULL
);

CREATE UNIQUE INDEX ENT_XUIDWorkUnit ON ent_work_unit
(
       client_id                         ASC,
       class_name                        ASC
);

ALTER TABLE ent_work_unit ADD CONSTRAINT
		pk_entworkunit_workunitid PRIMARY KEY(work_unit_id);

--********************************************************************

CREATE TABLE ent_integration (
       obj_id               NUMBER(9) NOT NULL,
       comp_id              NUMBER(9) NOT NULL,
       tranx_id             NUMBER(9) NOT NULL,
       integration_id       VARCHAR2(300) NOT NULL
) STORAGE (INITIAL 2M  NEXT 2M  MINEXTENTS 1  MAXEXTENTS 100  PCTINCREASE 0);

CREATE UNIQUE INDEX ENT_XUIDIntegration ON ent_integration
(
       obj_id                            ASC,
       comp_id                           ASC,
       integration_id                    ASC
) STORAGE (INITIAL 2M  NEXT 2M  MINEXTENTS 1  MAXEXTENTS 100  PCTINCREASE 0) ;

CREATE UNIQUE INDEX ENT_XUIDIntegrationSerial ON ent_integration
(
       tranx_id                          ASC
) ;

ALTER TABLE ent_integration ADD CONSTRAINT
		pk_entintg_objid_compid_tranid PRIMARY KEY(obj_id, comp_id, tranx_id) ;

ALTER TABLE ent_integration ADD CONSTRAINT
		fk_entint_objid_compid_entcomp FOREIGN KEY(obj_id, comp_id) REFERENCES ent_component(obj_id, comp_id) ;

--********************************************************************

CREATE TABLE ent_activation (
       obj_id               NUMBER(9) NOT NULL,
       comp_id              NUMBER(9) NOT NULL,
       tranx_id             NUMBER(9) NOT NULL,
       work_unit_id         NUMBER(9) NOT NULL,
       event_type_name      VARCHAR2(256) NOT NULL,
       integration_id       VARCHAR2(300) NOT NULL,
       restart_count        NUMBER(9) NOT NULL,
       timestamp            DATE NOT NULL,
       end_flag             CHAR(1) NOT NULL,
       end_timestamp        DATE NULL,
       event                LONG RAW NULL,
       seq_number           NUMBER(9) NULL,
       event_id             VARCHAR2(24) NOT NULL
) STORAGE (INITIAL 2M  NEXT 2M  MINEXTENTS 1  MAXEXTENTS 100  PCTINCREASE 0) ;

CREATE INDEX ENT_XIDActivationTranxId on ent_activation
(
       tranx_id                          ASC
) ;

CREATE INDEX ENT_XIDActivation on ent_activation
(
       tranx_id                          ASC,
       work_unit_id                      ASC
) ;

CREATE INDEX ENT_XIDActivationStatus on ent_activation
(
       tranx_id                          ASC,
       end_flag                          ASC
) ;

ALTER TABLE ent_activation ADD CONSTRAINT pk_entact_oid_cid_tid_wid_etyp
		PRIMARY KEY(obj_id, comp_id, tranx_id, work_unit_id, event_type_name) ;

ALTER TABLE ent_activation ADD CONSTRAINT fk_entact_oid_cid_tid_entintg
		FOREIGN KEY(obj_id, comp_id, tranx_id) REFERENCES ent_integration(obj_id, comp_id, tranx_id) ;

ALTER TABLE ent_activation ADD CONSTRAINT fk_entact_workunitid_entwunit
		FOREIGN KEY(work_unit_id) REFERENCES ent_work_unit(work_unit_id) ;

--********************************************************************

CREATE TABLE ent_message_log (
       obj_id               NUMBER(9) NOT NULL,
       comp_id              NUMBER(9) NOT NULL,
       tranx_id             NUMBER(9) NOT NULL,
       work_unit_id         NUMBER(9) NOT NULL,
       event_type_name      VARCHAR2(256) NOT NULL,
       msg_nbr              NUMBER(9) NOT NULL,
       integration_id       VARCHAR2(300) NOT NULL,
       timestamp            DATE NOT NULL,
       severity             NUMBER(5) NULL,
       msg_content          LONG VARCHAR NULL
) STORAGE (INITIAL 2M  NEXT 2M  MINEXTENTS 1  MAXEXTENTS 100  PCTINCREASE 0) ;

CREATE UNIQUE INDEX ENT_XUIDMsgLogSerial ON ent_message_log
(
       msg_nbr                           ASC
) ;

CREATE INDEX ENT_XIDMessage on ent_message_log
(
       tranx_id                          ASC
) ;

CREATE INDEX ENT_XIDMessageSeverity on ent_message_log
(
       tranx_id                          ASC,
       event_type_name                   ASC,
       severity
) ;

ALTER TABLE ent_message_log ADD CONSTRAINT pk_entmsglog
	PRIMARY KEY(obj_id, comp_id, tranx_id, work_unit_id, event_type_name, msg_nbr) ;

ALTER TABLE ent_message_log ADD CONSTRAINT fk_entmsglog_to_entactivation
  FOREIGN KEY(obj_id, comp_id, tranx_id, work_unit_id, event_type_name)
  REFERENCES ent_activation(obj_id, comp_id, tranx_id, work_unit_id, event_type_name) ;

--********************************************************************

CREATE TABLE ent_activation_custom (
       obj_id               NUMBER(9) NOT NULL,
       comp_id              NUMBER(9) NOT NULL,
       tranx_id             NUMBER(9) NOT NULL,
       work_unit_id         NUMBER(9) NOT NULL,
       event                LONG RAW NULL,
       field_name           VARCHAR2(128) NULL,
       string_value         VARCHAR2(256) NULL,
       number_value         FLOAT NULL,
       date_value           DATE NULL
) STORAGE (INITIAL 2M  NEXT 2M  MINEXTENTS 1  MAXEXTENTS 100  PCTINCREASE 0) ;

CREATE INDEX ENT_XIDActivationCustom on ent_activation_custom
(
       obj_id                            ASC,
       comp_id                           ASC,
       tranx_id                          ASC,
       work_unit_id                      ASC
) ;

ALTER TABLE ent_activation_custom ADD CONSTRAINT fk_entactcust_to_entinteg
	FOREIGN KEY(obj_id, comp_id, tranx_id) REFERENCES ent_integration(obj_id, comp_id, tranx_id) ;

ALTER TABLE ent_activation_custom ADD CONSTRAINT fk_entactcust_wunitid_entwunit
	FOREIGN KEY(work_unit_id) REFERENCES ent_work_unit(work_unit_id) ;

--********************************************************************
-- insert BI schema version
--********************************************************************
INSERT INTO SchemaDefinition (Version, CreationDate, CreatingSystem)
        VALUES ('1', SYSDATE, 'BI') ;

--********************************************************************

COMMIT ;

--********************************************************************

